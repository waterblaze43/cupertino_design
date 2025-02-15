import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await WindowManager.instance.ensureInitialized();
    await WindowManager.instance.setAlwaysOnTop(true);
    await WindowManager.instance.setSize(const Size(400, 730));
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            leading: Icon(CupertinoIcons.airplane),
            largeTitle: Text("Home"),
            trailing: Icon(CupertinoIcons.building_2_fill),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Drag Here"),
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => About()),
                      );
                    },
                    child: Text("Click Me"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            bottomMode: NavigationBarBottomMode.automatic,
            largeTitle: Text("About"),
            trailing: Icon(CupertinoIcons.share),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CupertinoSearchTextField(),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("this is the About")],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
