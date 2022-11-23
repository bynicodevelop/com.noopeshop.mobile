import "package:another_flushbar/flushbar.dart";
import "package:flutter/material.dart";
import "package:shop/constants.dart";

void notice(
  BuildContext context,
  String message,
) async =>
    Flushbar(
      message: message,
      messageColor: Colors.grey[900],
      backgroundColor: Colors.white,
      duration: const Duration(
        seconds: 2,
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(defaultPadding),
      borderRadius: BorderRadius.circular(
        defaultBorderRadious,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.grey[300]!,
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
    ).show(context);
