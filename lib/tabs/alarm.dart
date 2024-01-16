import 'dart:async';

import 'package:alarm_clock/Provider/Provier.dart';
import 'package:alarm_clock/Screen/Add_Alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _MyAppState();
}

class _MyAppState extends State<Alarm> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body:
      ListView(
        children: [
          Consumer<alarmprovider>(builder: (context, alarm, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                  itemCount: alarm.modelist.length,
                  itemBuilder: (BuildContext, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          alarm.modelist[index].dateTime!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                              "|${alarm.modelist[index].label}"),
                                        ),
                                      ],
                                    ),
                                    CupertinoSwitch(
                                        value: (alarm.modelist[index]
                                                    .milliseconds! <
                                                DateTime.now()
                                                    .microsecondsSinceEpoch)
                                            ? false
                                            : alarm.modelist[index].check,
                                        onChanged: (v) {
                                          alarm.EditSwitch(index, v);
                                          alarm.CancelNotification(
                                              alarm.modelist[index].id!);
                                        }),
                                  ],
                                ),
                                Text(alarm.modelist[index].when!)
                              ],
                            ),
                          ),
                        ));
                  }),
            );
          }),
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddAlarm()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(60, 60),
                elevation: 10,
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
