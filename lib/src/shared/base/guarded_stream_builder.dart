import 'dart:async';
import 'package:flutter/material.dart';

class GuardedStreamBuilder<T> extends StatefulWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext, T) builder;
  final T Function() initialData;

  const GuardedStreamBuilder(
      {super.key,
      required this.stream,
      required this.builder,
      required this.initialData});

  @override
  createState() => _State();
}

class _State<T> extends State<GuardedStreamBuilder<T>> {
  late T _data;
  late StreamSubscription<T> subscription;

  @override
  initState() {
    super.initState();
    _data = widget.initialData();
    subscription = widget.stream.listen((event) {
      if (mounted) {
        setState(() {
          _data = event;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  build(context) {
    return widget.builder(context, _data);
  }
}
