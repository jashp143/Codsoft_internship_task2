import 'dart:async';
import 'package:alarm_clock/Provider/Provier.dart';
import 'package:alarm_clock/tabs/alarm.dart';
import 'package:alarm_clock/tabs/clock.dart';
import 'package:alarm_clock/tabs/stopwatch.dart';
import 'package:alarm_clock/tabs/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  runApp(ChangeNotifierProvider(
    create: (contex) => alarmprovider(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;

  @override
  void initState() {
    context.read<alarmprovider>().Inituilize(context);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
    context.read<alarmprovider>().GetData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Alarm Clock App",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          primaryContainer: Colors.teal.shade900,
          secondary: Colors.tealAccent,
          secondaryContainer: Colors.tealAccent.shade700,
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.menu),
              actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.settings))],
              backgroundColor: Colors.teal,
              title: const Text("Alarm Clock App"),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.access_time),
                    child: Text(
                      "Clock",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.access_alarm),
                    child: Text(
                      "Alarm",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.av_timer),
                    child: Text(
                      "Stop",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.timer_rounded),
                    child: Text(
                      "Timer",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Clock(),
                Alarm(),
                StopWatch(),
                CountdownTimer(),
              ],
            )),
      ),
    );
  }
}

