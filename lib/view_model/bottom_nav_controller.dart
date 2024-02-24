import 'package:get/get.dart';
import 'package:softec_app_dev/view/Home/achivements.dart';
import 'package:softec_app_dev/view/Home/homepage.dart';
import 'package:softec_app_dev/view/Home/profile.dart';
import 'package:softec_app_dev/view/Home/search.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offAll(const HomePage());
        break;
      case 1:
        Get.offAll(const Achievements());
        break;
      case 2:
        Get.offAll(const Search());
        break;
      case 3:
        Get.offAll(const Profile());
        break;
      default:
        Get.offAll(const HomePage());
    }
  }
}
