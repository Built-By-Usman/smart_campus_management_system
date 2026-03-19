import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CampusX/core/constant/app_routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
  }

  Future<void> checkLoginStatus() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('is_logged_in')??false;
    if(isLoggedIn){
      String role=preferences.getString('role')??'';
      if(role=='admin'){
        Future.delayed(Duration(seconds: 2), () {
          Get.offNamed(AppRoutes.adminHome);
        });

      }
      else if(role=='teacher'){
        Future.delayed(Duration(seconds: 2), () {
          Get.offNamed(AppRoutes.login);
        });

      }
      else{
        Future.delayed(Duration(seconds: 2), () {
          Get.offNamed(AppRoutes.login);
        });

      }

    }
    else{
      Future.delayed(Duration(seconds: 2), () {
        Get.offNamed(AppRoutes.login);
      });
    }

  }
}
