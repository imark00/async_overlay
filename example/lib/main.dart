import 'package:async_overlay/async_overlay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          ],
        ),
      ),
    );
  }

  Future asyncTask() async {
    await Future.delayed(Duration(seconds: 5));
    return 'Hello World!';
  }

  showDefaultAsyncOverlay() async {
    res = await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(asyncTask()),
    );
    if (!mounted) return;
    setState(() {});
  }

  showDefaultAsyncOverlayWithMsg() async {
    res = await showDialog(
      context: context,
      builder: (context) => AsyncOverlay(
        asyncTask(),
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
        asyncTask(),
        message: Text('Loading'),
        customLoader: const CustomLoader(),
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
