import 'package:flutter/material.dart';

void showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.indigoAccent,
      content: Text(text, style: const TextStyle(
        fontSize: 12, fontStyle: FontStyle.italic, color: Colors.white70,)),
      action: SnackBarAction(
          label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}