import 'package:async_overlay/async_overlay.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async Overlay Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 18,
          children: [
            Text(
              res,
              style: TextStyle(fontSize: 22),
            ),
            ElevatedButton(
              onPressed: showDefaultAsyncOverlay,
              child: Text('Show default Async Overlay'),
            ),
            ElevatedButton(
              onPressed: showDefaultAsyncOverlayWithMsg,
              child: Text('Show default Async Overlay with message'),
            ),
            ElevatedButton(
              onPressed: showDefaultAsyncOverlayWithCustomLoader,
              child: Text('Show default Async Overlay with custom loader'),
            ),
            ElevatedButton(
              onPressed: showCustomOverlay,
              child: Text('Show Custom Async Overlay'),
            ),
          ],
        ),
      ),
    );
  }

  Future asyncFutureTask() async {
    await Future.delayed(Duration(seconds: 5));
    return 'Hello World!';
  }

  showDefaultAsyncOverlay() async {
    res = await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(asyncFutureTask()),
    );
    if (!mounted) return;
    setState(() {});
  }

  showDefaultAsyncOverlayWithMsg() async {
    res = await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncFutureTask(),
        message: Text('Loading'),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  showDefaultAsyncOverlayWithCustomLoader() async {
    res = await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncFutureTask(),
        message: Text('Loading'),
        loadingWidget: const CustomLoader(),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  showCustomOverlay() async {
    res = await showDialog(
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
    if (!mounted) return;
    setState(() {});
  }
}

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        value: 0.0, duration: Duration(milliseconds: 1000), vsync: this);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: AnimatedIcons.menu_home,
      progress: controller,
    );
  }
}
