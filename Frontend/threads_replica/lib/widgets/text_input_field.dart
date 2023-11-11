import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool? showObsecure;
  RxBool obsecurePassword = RxBool(true);
  final String? Function(String?)? validator;
  TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType,
      this.validator,
      this.showObsecure});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      obscureText: isPass,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: showObsecure == true
            ? GestureDetector(
                onTap: () {
                  obsecurePassword.toggle();
                  isPass = !isPass;
                },
                child: Icon(
                  obsecurePassword.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.red,
                  size: 25,
                ),
              )
            : null,
        hintText: hintText,
        filled: true,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}