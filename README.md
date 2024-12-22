# async_overlay

AsyncOverlay is a simple package, inspired by the [_future_progress_dialog_](https://github.com/donguseo/future_progress_dialog) 
package for displaying custom overlay UIs during **_asynchronous Future operations_**. 
It empowers developers to define their own unique loading overlays, 
offering a flexible alternative to default UI options.


## Supported Dart Version 
**Dart SDK version >=3.0.0**


## Installation

Add **_async_overlay_** to pubspec:

```yaml
dependencies:
  async_overlay: # latest version 
```

## Usage

Import the package 

```dart
import 'package:async_overlay/async_overlay.dart';
```

Call [showDialog](https://api.flutter.dev/flutter/material/showDialog.html) method with **AsyncOverlay** to show overlay loading UI

- without message
```dart
await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(asyncFutureTask()),
    );
```
![](https://raw.githubusercontent.com/imark00/async_overlay/refs/heads/main/readme_assets/async_overlay_without_msg.gif)

- with message
```dart
await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncFutureTask(),
        message: Text('Loading'),
      ),
    );
```
![](https://raw.githubusercontent.com/imark00/async_overlay/refs/heads/main/readme_assets/async_overlay_with_msg.gif)

- with custom loading widget
```dart
await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncFutureTask(),
        message: Text('Loading'),
        loadingWidget: const CustomLoader(),
      ),
    );
```
![](https://raw.githubusercontent.com/imark00/async_overlay/refs/heads/main/readme_assets/async_overlay_with_custom_loader.gif)

- with custom overlay UI
```dart
await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncFutureTask(),
        customOverlayUI: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.network(
                'https://lottie.host/add90c20-d592-4c79-90b1-35d4cdff3035/SXrl7L2Y8G.json',
                height: 200,
                width: 230,
                renderCache: RenderCache.raster,
              ),
              Lottie.network(
                'https://lottie.host/a3f86098-dd8c-4f30-9aa4-e4795eda9243/9b4YUI1crz.json',
                height: 112,
                width: 127,
                renderCache: RenderCache.raster,
              ),
            ],
          ),
        ),
      ),
    );
```
![](https://raw.githubusercontent.com/imark00/async_overlay/refs/heads/main/readme_assets/async_overlay_without_custom_overlay.gif)

## Visitors Count

<img src = "https://profile-counter.glitch.me/async_overlay/count.svg" alt ="Loading">