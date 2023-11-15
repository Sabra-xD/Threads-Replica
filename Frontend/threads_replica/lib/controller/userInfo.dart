import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends GetxController {
  Future<void> saveUserInfo(String userName, String email, String? img) async {
    print("Saving the user: ${userName}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName);
    await prefs.setString('email', email);
    if (img != null) {
      await prefs.setString('username', userName);
    }
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
