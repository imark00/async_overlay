import 'package:flutter/material.dart';

class AsyncOverlay extends StatefulWidget {
  /// Set future task to be completed
  @required
  final Future asyncTask;

  /// Set custom [BoxDecoration] for [AsyncOverlay].
  final BoxDecoration? decoration;

  /// Set custom loading widget, other than the default [CircularProgressIndicator].
  final Widget? loadingWidget;

  /// Set loading message for default [AsyncOverlay].
  final Widget? message;

  /// Set padding around the dialog
  final EdgeInsets? insetPadding;

  /// Set space between the loader and the text
  final double loaderAndTextSpacing;

  /// Set overall custom overlay UI
  final Widget? customOverlayUI;

  const AsyncOverlay(
    this.asyncTask, {
    super.key,
    this.decoration,
    this.loadingWidget,
    this.message,
    this.insetPadding = kInsetPadding,
    this.loaderAndTextSpacing = 20,
    this.customOverlayUI,
  }) : assert(
          customOverlayUI == null ||
              (decoration == null &&
                  loadingWidget == null &&
                  message == null &&
                  insetPadding == kInsetPadding &&
                  loaderAndTextSpacing == 20),
          'If customOverlay is provided, no other properties (decoration, loadingWidget, message, '
          'insetPadding, or loaderAndTextSpacing) should be set.'
          '\nUse customOverlay to fully define your overlay.',
        );

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
        child: widget.customOverlayUI ??
            (widget.message != null
                ? Container(
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    decoration: widget.decoration ?? kDefaultDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.loadingWidget ??
                            const CircularProgressIndicator(),
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
                      child: widget.loadingWidget ??
                          const CircularProgressIndicator(),
                    ),
                  )),
      ),
    );
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

const kInsetPadding = EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);
