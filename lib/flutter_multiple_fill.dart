import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FillCallback = Function(List);

class FlutterMultipleFill extends StatefulWidget {
  final TextStyle circleAvatarTextStyle;
  final Color circleAvatarColor;
  final TextStyle chipTextStyle;
  final double chipLabelPadding;
  final Color chipColor;
  InputDecoration inputDecoration;
  final bool emailPattern;
  final Decoration boxDecoration;
  final double boxPadding;
  final TextInputType keyboardType;
  final FillCallback onfillCallback;

  FlutterMultipleFill(
      {Key? key,
      this.circleAvatarTextStyle = const TextStyle(fontSize: 12),
      this.circleAvatarColor = Colors.black,
      this.chipTextStyle = const TextStyle(fontSize: 12, color: Colors.white),
      this.chipColor = Colors.blue,
      this.chipLabelPadding = 1,
      this.inputDecoration = const InputDecoration(
        hintText: "Add email or other text",
        filled: false,
        hintStyle: TextStyle(fontSize: 12),
      ),
      this.emailPattern = true,
      this.boxDecoration = const BoxDecoration(color: Colors.transparent),
      this.boxPadding = 0,
      this.keyboardType = TextInputType.emailAddress,
      required this.onfillCallback})
      : super(key: key);

  @override
  State<FlutterMultipleFill> createState() => _FlutterMultipleFillState();
}

class _FlutterMultipleFillState extends State<FlutterMultipleFill> {
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String lastValueFill = '';

  List<String> inputAdding = [];

  updateinputAdding() {
    setState(() {
      if (widget.emailPattern) {
        if (validateEmail(_inputController.text)) {
          if (!inputAdding.contains(_inputController.text)) {
            inputAdding.add(_inputController.text.trim());
            widget.onfillCallback(inputAdding);
          }
          _inputController.clear();
        } else if (!validateEmail(_inputController.text)) {
          // email not correct set border color to red
          _inputController.clear();
        }
      } else {
        if (!inputAdding.contains(_inputController.text)) {
          inputAdding.add(_inputController.text.trim());
          widget.onfillCallback(inputAdding);
        }
        _inputController.clear();
      }
    });
  }

  setinputAdding(List<String> inputAdding) {
    this.inputAdding = inputAdding;
  }

  bool validateEmail(String value) {
    String patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(patternEmail);
    return regex.hasMatch(value);
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        ...inputAdding
            .map(
              (value) => _buildChip(value),
            )
            .toList()
      ],
    );
  }

  Widget _buildChip(String email) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: widget.circleAvatarColor,
        child: Text(
          email.substring(0, 1),
          style: widget.circleAvatarTextStyle,
        ),
      ),
      labelPadding: EdgeInsets.all(widget.chipLabelPadding),
      backgroundColor: widget.chipColor,
      label: Text(
        email,
        style: widget.chipTextStyle,
      ),
      onDeleted: () => {
        setState(() {
          inputAdding.removeWhere((element) => email == element);
        })
      },
    );
  }

  Widget multipleFill() {
    return Container(
        decoration: widget.boxDecoration,
        padding: EdgeInsets.all(widget.boxPadding),
        child: Center(
          child: Column(
            children: <Widget>[
              chipList(),
              TextField(
                keyboardType: widget.keyboardType,
                decoration: widget.inputDecoration,
                controller: _inputController,
                onChanged: (String val) {
                  setState(() {
                    if (val != lastValueFill) {
                      lastValueFill = val;
                      if (val.endsWith(' ') && validateEmail(val.trim())) {
                        if (!inputAdding.contains(val.trim())) {
                          inputAdding.add(val.trim());
                          // widget.fillCallback(inputAdding);
                        }
                        _inputController.clear();
                      } else if (val.endsWith(' ') &&
                          !validateEmail(val.trim())) {
                        _inputController.clear();
                      }
                    }
                  });
                },
                onEditingComplete: () {
                  updateinputAdding();
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: multipleFill(),
    );
  }
}
