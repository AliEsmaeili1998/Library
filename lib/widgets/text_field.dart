import 'package:flutter/material.dart';

import '../colors.dart';

class MyTextField extends StatelessWidget {
  final String myLableText;
  final TextAlign txtAlign;
  final void Function(String)? myOnSubmit;
  final void Function(String)? myOnChange;
  final TextEditingController? changeText;
  final FocusNode? focusNode;

  const MyTextField({Key? key, 
    required this.myLableText,
    this.txtAlign = TextAlign.center,
    this.myOnSubmit,
    this.myOnChange,
    this.changeText,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: MyColors.text2.withOpacity(0.4),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(-10, 10),),
          ],
        ),
        child: TextField(
          cursorColor: MyColors.foreground3,
          textInputAction: TextInputAction.done,
          maxLines: null,
          textAlign: txtAlign,
          style: TextStyle(
            color: MyColors.text1,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.foreground1,
            labelText: myLableText,
            labelStyle: TextStyle(
              color: MyColors.text1,
              fontSize: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: MyColors.text1, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.foreground3, width: 2),
            ),
          ),
          onSubmitted: myOnSubmit,
          onChanged: myOnChange,
          controller: changeText,
          focusNode: focusNode,
        ),
      ),
    );
  }
}
