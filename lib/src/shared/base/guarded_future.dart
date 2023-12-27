import 'package:flutter/material.dart';
import 'package:weather_app_assignment/src/shared/base/app_exception.dart';
import 'package:weather_app_assignment/src/shared/base/do_action.dart';

Widget _defaultErrorBuilder(BuildContext context,
        {required dynamic Function() retry, required AppException exception}) =>
    Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${exception.message}'),
          TextButton(
            onPressed: retry,
            child: const Text('Retry'),
          ),
        ],
      ),
    ));

/// should be used on top of the build() method.
/// reason: if new instance of this widget is created, the init() function will be called again.
/// expected usage: _init should initialize state once, unless there is an error.
/// If _init() throws an error, the user can retry by pressing retry button and _init() will be called again.
class GuardedFutureBuilder<T> extends StatefulWidget {
  const GuardedFutureBuilder({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.noReport = false,
    this.errorBuilder = _defaultErrorBuilder,
    required this.init,
    required this.builder,
    required this.actionMixin,
  }) : super(key: key);

  final Duration duration;
  final dynamic Function() init;
  final Widget Function(BuildContext) builder;
  final Widget Function(BuildContext,
      {required dynamic Function() retry,
      required AppException exception}) errorBuilder;
  final bool noReport;
  final ActionMixin actionMixin;

  @override
  createState() => _State();
}

class _State extends State<GuardedFutureBuilder> {
  AppException? _exception;

  @override
  initState() {
    _retry();
    super.initState();
  }

  Future<void> _retry() async {
    try {
      await widget.actionMixin.doInit(widget.init);
    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _exception = convertException(e,
              noReport: widget.noReport, stackTrace: stackTrace);
        });
      }
    }
  }

  @override
  build(context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _exception != null
            ? widget.errorBuilder(context,
                retry: _retry, exception: _exception!)
            : widget.builder(context));
  }
}
