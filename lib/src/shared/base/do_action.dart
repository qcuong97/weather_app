import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app_assignment/src/device/ext.dart';
import 'package:weather_app_assignment/src/shared/theme/color.dart';
import 'package:weather_app_assignment/src/shared/util/dialog_util.dart';

import 'package:weather_app_assignment/src/shared/base/app_exception.dart';

enum ActionInformKind {
  snackBar,
  modalBottomSheet,
  skip,
}

_informAction(BuildContext context, ActionInformKind kind, String message,
    {String? title, bool isSuccess = true}) {
  switch (kind) {
    case ActionInformKind.snackBar:
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor:
            isSuccess ? AccentSwatch.green.color : AccentSwatch.red.color,
      ));
    case ActionInformKind.modalBottomSheet:
      showOk(context, message: message, title: title);
    case ActionInformKind.skip:
  }
}

/// doAction is used to inform the user about the result of an action: error, success (skip by default).
///
/// use submitting as a state to disable Button/Field/etc.
/// If the last action is being executed, the next action will be ignored.
/// If the caller screen is a bottom modal, specify ActionInformKind.modalBottomSheet to avoid the modal being overlapped by the caller screen.
/// If you want to return without informing the user, return actionIgnore. When success = ActionInformKind.skip (default), we never show the success inform.
mixin ActionMixin<T extends StatefulWidget> on State<T> {
  bool _submitting = false;
  int _initCount = 0;
  AppException? exception;

  /// NOTE: Always prefer `loading`. DON'T use `isInitializing` unless you know what you are doing.
  ///
  /// Lifecycle of `isInitializing`:
  /// - In first render frame, `isInitializing` = false.
  /// - In second frame, `isInitializing` = true (triggered by `initState` of GuardedFutureBuilder).
  /// - When loading is done, `isInitializing` = false.
  ///
  /// How to manage loading state in your widget:
  /// - If there is a natural default value of the state: empty list, empty string ,etc.
  ///   - Use `submitting` (sometimes, `isInitializing` but not recommended except for special cases) to detect loading state.
  ///   - For example: disable editing TextField, disable action buttons, etc.
  /// - If there is no such default value:
  ///   - Initialize the state with null value.
  ///   - Show appropriate loading UI when the state is null. There is no need to use `isInitializing` or `loading`.
  ///
  /// !!DON'T USE THIS!! unless you know what you are doing
  get isInitializing => _initCount > 0;

  /// NOTE: Always prefer `loading`. DON'T use `isSubmitting` unless you know what you are doing.
  /// !!DON'T USE THIS!! unless you know what you are doing
  get isSubmitting => _submitting;

  /// !!SHOULD USE THIS!! to detect loading state.
  get loading => isSubmitting || isInitializing;

  doAction<V>(
    Future<V> Function() action, {
    error = ActionInformKind.modalBottomSheet,
    errorTitle = 'Error',
    bool noReport = false,
    success = ActionInformKind.skip,
    String successMessage = 'Success',
    String successTitle = 'Success', // bottom sheet only
  }) async {
    setState(() {
      exception = null;
    });
    try {
      showLoading();
      final result = await action();
      hideLoading();
      if (mounted) {
        _informAction(context, success, successMessage,
            title: successTitle, isSuccess: true);
      }
      return result;
    } catch (e, stackTrace) {
      if (!mounted) rethrow;
      hideLoading();
      final appException =
          convertException(e, noReport: noReport, stackTrace: stackTrace);
      setState(() {
        exception = appException;
      });
      _informAction(context, error, appException.messageError(context),
          title: errorTitle, isSuccess: false);
      rethrow;
    } finally {
      if (mounted) {
        hideLoading();
        setState(() {
          _submitting = false;
        });
      } else {
        _submitting = false;
      }
    }
  }

  clearException() {
    setState(() {
      exception = null;
    });
  }

  // no action handler
  doInit(
    dynamic Function() init, {
    bool noReport = false,
  }) async {
    final completer = Completer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _initCount += 1;
      });
      try {
        await init();
        completer.complete();
      } catch (e, stackTrace) {
        completer.completeError(
            convertException(e, noReport: noReport, stackTrace: stackTrace));
      } finally {
        if (mounted) {
          setState(() {
            _initCount -= 1;
          });
        } else {
          _initCount -= 1;
        }
      }
    });
    return await completer.future;
  }
}
