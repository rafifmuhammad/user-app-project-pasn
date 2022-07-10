import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String? title;
  Function onPressed;
  Button({
    Key? key,
    this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.purple[800],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.purple,
              onTap: () => onPressed(),
              child: Center(
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
