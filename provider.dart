import 'package:flutter/material.dart';

// Mengelola tema (terang/gelap)
class ChangeTheme extends ChangeNotifier {
  bool isDark = false;

  void change(bool val) {
    isDark = val;
    notifyListeners();
  }
}

// Mengelola status notifikasi
class NotificationProvider extends ChangeNotifier {
  bool isNotificationOn = false;

  void toggleNotification(bool val) {
    isNotificationOn = val;
    notifyListeners();
  }
}

// Mengelola status privasi
class PrivacyProvider extends ChangeNotifier {
  bool isPrivacyOn = false;

  void togglePrivacy(bool val) {
    isPrivacyOn = val;
    notifyListeners();
  }
}

// Model untuk Postingan
class Post {
  final String imageURL;
  final String category;

  Post({required this.imageURL, required this.category});
}

// Mengelola daftar postingan (gambar dan kategori)
class ProfileProvider extends ChangeNotifier {
  List<Post> posts = [];

  void addPost({required String imageURL, required String category}) {
    Post newPost = Post(imageURL: imageURL, category: category);
    posts.add(newPost);
    notifyListeners();
  }

  // Metode untuk mengacak daftar postingan
  void shufflePosts() {
    posts.shuffle();
    notifyListeners();
  }
}

// Mengelola status "loved" pada gambar
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
