import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  const AppContainer(
      {Key? key,
      required this.child,
      required this.padding,
      this.color = Colors.white,
      required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.grey[300]!),
        ],
      ),
      child: child,
    );
  }
}
