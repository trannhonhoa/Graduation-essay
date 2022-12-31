import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper(
      {super.key,
      required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      required this.iconSize,
      required this.value,
      required this.onChanged});
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;
  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;
                widget.onChanged({"qty": widget.value, "type": "-"});
              });
            }),
            child: const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 20,
                )),
          ),
          SizedBox(
            width: widget.iconSize,
            child: Text(
              widget.value.toString(),
              style: TextStyle(
                  fontSize: widget.iconSize * 0.7, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                widget.value = widget.value == widget.upperLimit
                    ? widget.lowerLimit
                    : widget.value += widget.stepValue;
                widget.onChanged({"qty": widget.value, "type": "+"});
              });
            }),
            child: const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
