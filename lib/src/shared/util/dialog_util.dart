import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_assignment/src/device/global_data.dart';
import 'package:weather_app_assignment/src/shared/theme/color.dart';

showOk(
  BuildContext context, {
  String? title,
  String ok = 'Close',
  required String message,
}) async =>
    await showModalBottomSheet(
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: false,
        isScrollControlled: false,
        backgroundColor: purple,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        builder: (context) => ActionModalBottomSheet(
              content: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(ok),
                ),
              ],
              title: title == null ? null : Text(title),
            ),
        context: context);

Future<bool> showYesNo(
  BuildContext context, {
  String? title,
  String yes = 'Confirm',
  String no = 'Close',
  required String message,
  bool danger = false,
  bool swapButtonPosition = false,
  bool isDismissible = true,
}) async =>
    (await showModalBottomSheet(
        isDismissible: isDismissible,
        useRootNavigator: true,
        enableDrag: false,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        builder: (context) {
          final noBtn = ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(no),
          );
          final yesBtn = danger
              ? ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(yes),
                )
              : ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(yes),
                );
          final children =
              !swapButtonPosition ? [noBtn, yesBtn] : [yesBtn, noBtn];
          return PopScope(
            onPopInvoked: (didPop) async => isDismissible,
            child: ActionModalBottomSheet(
              content: Text(message),
              actions: children,
              title: title == null ? null : Text(title),
            ),
          );
        },
        context: context)) ??
    false;

class ActionModalBottomSheet extends StatelessWidget {
  const ActionModalBottomSheet({
    Key? key,
    required this.content,
    this.title,
    required this.actions,
  }) : super(key: key);

  final Widget content;
  final Widget? title;
  final List<Widget> actions;

  @override
  build(context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              DefaultTextStyle.merge(
                  style: Theme.of(context).textTheme.titleMedium,
                  child: Center(child: title)),
            if (title != null) const SizedBox(height: 40),
            DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.bodyLarge,
                child: Center(child: content)),
            if (actions.isNotEmpty) const SizedBox(height: 40),
            for (final (idx, action) in actions.indexed) ...[
              action,
              if (idx < actions.length - 1) const SizedBox(height: 16),
            ],
          ],
        ));
  }
}

makeBackButton(BuildContext context, bool left) => Container(
      width: 40, // Adjust the size of the container as needed
      height: 40, // Adjust the size of the container as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Circular shape
        color: neuralColor.shade100, // Background color of the circle
      ),
      child: Center(
        child: IconButton(
          icon: Icon(left ? Icons.arrow_back : Icons.close, size: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );

showLoading() {
  if (!GlobalData.instance.isLoading) {
    GlobalData.instance.isLoading = true;
    showDialog(
        context: GlobalData.instance.context,
        barrierDismissible: false,
        barrierColor: neuralColor[0]?.withAlpha(50),
        builder: (context) => PopScope(
              onPopInvoked: (didPop) async => false,
              child: SizedBox(
                height: double.infinity,
                child: SpinKitRing(
                  color: Theme.of(context).primaryColor,
                  lineWidth: 2,
                  size: 30,
                ),
              ),
            ));
    Future.delayed(const Duration(seconds: 60), () {
      if (GlobalData.instance.isLoading) {
        hideLoading();
      }
    });
  }
}

hideLoading() {
  if (GlobalData.instance.isLoading) {
    GlobalData.instance.isLoading = false;
    Navigator.pop(GlobalData.instance.context);
  }
}
