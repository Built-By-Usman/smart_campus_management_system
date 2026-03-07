import 'package:get/get.dart';
import 'package:smar_campus_management_system/core/constant/app_routes.dart';

class SplashScreenController extends GetxController{
  
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2),(){
      Get.offNamed(AppRoutes.login);
    });
    super.onInit();
  }
}