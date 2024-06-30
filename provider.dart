import 'package:flutter/cupertino.dart';

class ChangeTheme extends ChangeNotifier {
  bool isDark = false;

  void change(bool val) {
    isDark = val;
    notifyListeners();
  }
}

class NotificationProvider extends ChangeNotifier {
  bool isNotificationOn = false;

  void toggleNotification(bool val) {
    isNotificationOn = val;
    notifyListeners();
  }
}

class PrivacyProvider extends ChangeNotifier {
  bool isPrivacyOn = false;

  void togglePrivacy(bool val) {
    isPrivacyOn = val;
    notifyListeners();
  }
}

class Post {
  final String imageURL;
  final String category;

  Post({required this.imageURL, required this.category});
}

class ProfileProvider extends ChangeNotifier {
  List<Post> posts = [];

  void addPost({required String imageURL, required String category}) {
    Post newPost = Post(imageURL: imageURL, category: category);
    posts.add(newPost);
    notifyListeners();
  }
}

class LoveProvider extends ChangeNotifier {
  Map<String, bool> lovedImages = {};

  void toggleLove(String imageUrl) {
    if (lovedImages.containsKey(imageUrl)) {
      lovedImages[imageUrl] = !lovedImages[imageUrl]!;
    } else {
      lovedImages[imageUrl] = true;
    }
    notifyListeners();
  }
}
