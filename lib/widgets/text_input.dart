import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  String? title;
  IconData? icon;
  bool obsecureText;
  TextEditingController? controller;

  TextInput({
    Key? key,
    this.title,
    this.icon,
    this.obsecureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          TextField(
            controller: controller,
            obscureText: obsecureText,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.purple[800],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              label: Text(
                '$title',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
