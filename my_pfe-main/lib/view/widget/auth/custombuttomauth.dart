import 'package:flutter/material.dart';

class CustomButtomAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  // final double widt;
  final double? width;
  const CustomButtomAuth(
      {super.key, required this.text, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,

        color: Colors.green,
        textColor: Colors.black,
        child: Text(
          text,
          style: const TextStyle(),
        ),
        // colorBrightness: Brightness.dark,
      ),
    );
  }
}
