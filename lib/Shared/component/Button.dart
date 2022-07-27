import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);
  final String label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 300,

        decoration:  BoxDecoration(
          color:Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(

          label,
          style: const TextStyle(
            color: Colors.white,

          ),
          textAlign: TextAlign.center,
        ),

      ),
    );
  }
}
