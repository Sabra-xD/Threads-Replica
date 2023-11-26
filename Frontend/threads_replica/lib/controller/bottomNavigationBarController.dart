// ignore: file_names
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
