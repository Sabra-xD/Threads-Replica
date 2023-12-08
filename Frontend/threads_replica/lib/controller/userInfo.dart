import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends GetxController {
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString bio = ''.obs;
  RxString img = ''.obs;
  RxInt followers = RxInt(0);
  RxInt following = RxInt(0);
  RxBool isLoading = true.obs;

  Future<void> saveUserInfo(String userName, String email, String? img,
      String userId, List followers, List following) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName);
    await prefs.setString('id', userId);
    await prefs.setString('email', email);
    await prefs.setInt('followers', followers.length);
    await prefs.setInt('following', following.length);
    if (img != null) {
      await prefs.setString('profilePic', img);
    }
  }

  Future<void> saveBio(String bio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bio', bio);
  }

  Future<void> savedImage(String img) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', img);
  }

  Future<void> fetchData() async {
    isLoading.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userName.value = prefs.getString('username') ?? "Username";
    followers.value = prefs.getInt('followers') ?? 0;
    following.value = prefs.getInt('following') ?? 0;
    bio.value = prefs.getString("bio") ?? "";
    userId.value = prefs.getString('id') ?? "";
    email.value = prefs.getString('email') ?? "email";
    img.value = prefs.getString('profilePic') ??
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
  }

  void cleareSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
