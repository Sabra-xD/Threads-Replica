import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends GetxController {
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString bio = ''.obs;
  RxString img = ''.obs;
  RxBool isLoading = true.obs;

  Future<void> saveUserInfo(
      String userName, String email, String? img, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName);
    await prefs.setString('id', userId);
    await prefs.setString('email', email);
    if (img != null) {
      await prefs.setString('profilePic', img);
    }
  }

  Future<void> saveBio(String bio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bio', bio);
  }

  Future<void> fetchData() async {
    print("Fetch Data has been called");

    isLoading.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('username') ?? "Username";
    bio.value = prefs.getString("bio") ?? "";
    userId.value = prefs.getString('id') ?? "";
    email.value = prefs.getString('email') ?? "email";
    img.value = prefs.getString('img') ??
        "https://c8.alamy.com/comp/2E915TB/glitch-error-404-computer-page-anaglyph-glitch-404-banner-error-layout-effect-screen-2E915TB.jpg";

    // isLoading.value = false;
  }
}
