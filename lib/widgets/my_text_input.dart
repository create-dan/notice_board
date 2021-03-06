// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final TextInputAction textInputAction;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Stack(
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade700.withOpacity(0.15)),
            ),
          ),
          TextFormField(
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
            decoration: kTextFormFieldAuthDec.copyWith(
              hintText: widget.hintText,
              prefixIcon: Icon(
                widget.icon,
                color: kVioletShade,
              ),
              errorStyle: TextStyle(color: kGreenShadeColor),
            ),
            textInputAction: widget.textInputAction,
            cursorColor: Colors.red,
            controller: widget.controller,
            onSaved: (value) {
              widget.controller.value =
                  widget.controller.value.copyWith(text: value);
            },
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
