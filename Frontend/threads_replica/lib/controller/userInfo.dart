import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends GetxController {
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString img = ''.obs;
  RxBool isLoading = true.obs;

  Future<void> saveUserInfo(
      String userName, String email, String? img, String userId) async {
    print("Saving the user: ${userName}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName);
    await prefs.setString('id', userId);
    await prefs.setString('email', email);
    if (img != null) {
      await prefs.setString('username', userName);
    }
  }

  Future<void> fetchData() async {
    print("Fetching Data");
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('username') ?? "Username";
    userId.value = prefs.getString('id') ?? "";
    print(userId.value);
    email.value = prefs.getString('email') ?? "email";
    img.value = prefs.getString('img') ??
        "https://c8.alamy.com/comp/2E915TB/glitch-error-404-computer-page-anaglyph-glitch-404-banner-error-layout-effect-screen-2E915TB.jpg";

    isLoading.value = false;
  }

  Future getUserName() async {
    print("This function was called: ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Supposed Username: ${prefs.getString('username')}");
    return prefs.getString('username') ?? "Username";
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? "email";
  }

  Future<String> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('img') ??
        "https://static.vecteezy.com/system/resources/thumbnails/001/840/618/small/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg";
  }

  Future<String> getUserBio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('bio') ?? " ";
  }
}
