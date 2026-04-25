import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:CampusX/core/constant/app_color.dart';

import '../constant/navigator_key.dart';

void showSnackBarGlobal(String title, String message) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      elevation: 10,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColor.white,
    gravity: ToastGravity.BOTTOM,
    textColor: AppColor.black,
    toastLength: Toast.LENGTH_LONG,
  );
}
