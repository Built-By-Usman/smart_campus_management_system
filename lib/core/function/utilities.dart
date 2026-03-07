import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_color.dart';

void showSnackBar(String error, String message) {
  Get.snackbar(
      error,
      message,
      backgroundColor: AppColor.blue,
      colorText: AppColor.white,
      snackPosition: SnackPosition.TOP
  );
}


void showToast(String message) {
  Fluttertoast.showToast(msg: message,
      backgroundColor: AppColor.white,
      gravity: ToastGravity.BOTTOM,
      textColor: AppColor.black,
      toastLength: Toast.LENGTH_SHORT);
}
