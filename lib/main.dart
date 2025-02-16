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
      theme: CupertinoThemeData(),
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
                    sizeStyle: CupertinoButtonSize.medium,
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
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CupertinoContextMenu(
                      enableHapticFeedback: true,
                      actions: [
                        CupertinoContextMenuAction(
                          isDefaultAction: true,
                          trailingIcon: CupertinoIcons.clear,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"),
                        ),
                        CupertinoContextMenuAction(
                          isDestructiveAction: true,
                          trailingIcon: CupertinoIcons.delete,
                          onPressed: () {
                            Navigator.pop(context);
                            showCupertinoDialog(
                              context: context,
                              builder:
                                  (context) => CupertinoAlertDialog(
                                    title: Text("Delete?"),
                                    content: Text(
                                      "Do you want to delete this?",
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      ),
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: Text("Delete"),
                        ),
                      ],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: ColoredBox(
                          color: CupertinoColors.activeBlue,
                          child: FlutterLogo(size: 160),
                        ),
                      ),
                    ),
                  ),

                  CupertinoButton.tinted(
                    sizeStyle: CupertinoButtonSize.medium,
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder:
                            (context) => CupertinoActionSheet(
                              title: Text("Share"),
                              message: Text("Do you want To share this?"),
                              cancelButton: CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Share"),
                                ),
                              ],
                            ),
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
