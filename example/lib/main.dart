import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_multiple_fill/flutter_multiple_fill.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin FlutterMultipleFill'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              FlutterMultipleFill(
                circleAvatarTextStyle: const TextStyle(fontSize: 12),
                circleAvatarColor: Colors.black,
                chipTextStyle:
                    const TextStyle(fontSize: 12, color: Colors.white),
                chipColor: Colors.blue,
                chipLabelPadding: 1,
                inputDecoration: const InputDecoration(
                  hintText: "Add email",
                  filled: false,
                  hintStyle: TextStyle(fontSize: 12),
                ),
                emailPattern: true,
                boxDecoration: const BoxDecoration(color: Colors.transparent),
                boxPadding: 0,
                keyboardType: TextInputType.emailAddress,
                // get all values as list from this function
                onfillCallback: (List value) {
                  setState(() {
                    list = value;
                    print(list);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
