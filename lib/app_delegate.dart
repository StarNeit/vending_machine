import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vending_machine/core/route/app_page.dart';

class AppDelegate extends StatefulWidget {
  final String? initialRoute;
  const AppDelegate({Key? key, this.initialRoute}) : super(key: key);

  @override
  AppDelegateState createState() => AppDelegateState();
}

class AppDelegateState extends State<AppDelegate> with WidgetsBindingObserver {
  late StreamSubscription _showMessageSubscription;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addObserver(this);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          focus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Vending Machine',
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppPages.generateRoute,
        initialRoute: widget.initialRoute,
      ),
    );
  }
}
