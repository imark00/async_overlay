import 'package:flutter/material.dart';

class AsyncOverlay extends StatefulWidget {
  /// Dialog will be closed when [future] task is finished.
  @required
  final Future asyncTask;

  /// [BoxDecoration] of [FutureProgressDialog].
  final BoxDecoration? decoration;

  /// opacity of [FutureProgressDialog]
  final double opacity;

  /// If you want to use custom progress widget set [customLoader].
  final Widget? customLoader;

  /// If you want to use message widget set [message].
  final Widget? message;

  /// If you want to give padding around the dialog
  final EdgeInsets? insetPadding;

  /// If you want to set space between the loader and the text
  final double loaderAndTextSpacing;

  const AsyncOverlay(
    this.asyncTask, {
    super.key,
    this.decoration,
    this.opacity = 1.0,
    this.customLoader,
    this.message,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.loaderAndTextSpacing = 20,
  });

  @override
  State<AsyncOverlay> createState() => _AsyncOverlayState();
}

class _AsyncOverlayState extends State<AsyncOverlay> {
  @override
  void initState() {
    super.initState();
    _handleFuture();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: widget.insetPadding,
          child: widget.message != null
              ? Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: widget.decoration ?? kDefaultDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.customLoader ?? const CircularProgressIndicator(),
                      SizedBox(width: widget.loaderAndTextSpacing),
                      Expanded(child: widget.message!)
                    ],
                  ),
                )
              : Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: widget.decoration ?? kDefaultDecoration,
                    child: widget.customLoader ??
                        const CircularProgressIndicator(),
                  ),
                ),
        ));
  }

  Future<void> _handleFuture() async {
    try {
      final result = await widget.asyncTask;
      if (!mounted) return;
      Navigator.pop(context, result);
    } catch (e) {
      Navigator.pop(context);
      rethrow;
    }
  }
}

const kDefaultDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
