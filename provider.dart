import 'package:flutter/material.dart';

// ChangeTheme Provider
class ChangeTheme extends ChangeNotifier {
  bool isDark = false;

  void change(bool val) {
    isDark = val;
    notifyListeners();
  }
}

// NotificationProvider
class NotificationProvider extends ChangeNotifier {
  bool isNotificationOn = false;

  void toggleNotification(bool val) {
    isNotificationOn = val;
    notifyListeners();
  }
}

// PrivacyProvider
class PrivacyProvider extends ChangeNotifier {
  bool isPrivacyOn = false;

  void togglePrivacy(bool val) {
    isPrivacyOn = val;
    notifyListeners();
  }
}

// Post Model
class Post {
  final String imageURL;
  final String category;

  Post({required this.imageURL, required this.category});
}

// ProfileProvider
class ProfileProvider extends ChangeNotifier {
  List<Post> posts = [];

  // Add new post to the list
  void addPost({required String imageURL, required String category}) {
    Post newPost = Post(imageURL: imageURL, category: category);
    posts.add(newPost);
    notifyListeners(); 
  }


  void removeLastPost() {
    if (posts.isNotEmpty) {
      posts.removeLast();
      notifyListeners();
    }
  }

  // Shuffle posts list
  void shufflePosts() {
    posts.shuffle();
    notifyListeners(); // Notify listeners after shuffling posts
  }
}

// LoveProvider
class LoveProvider extends ChangeNotifier {
  Map<String, bool> lovedImages = {};
  
  // Toggle love status of image
  void toggleLove(String imageUrl) {
    lovedImages.update(imageUrl, (value) => !value, ifAbsent: () => true);
    notifyListeners();
  }

  // Check love status of image
  bool isLoved(String imageUrl) {
    return lovedImages[imageUrl] ?? false;
  }
}

// BookmarkProvider
class BookmarkProvider extends ChangeNotifier {
  List<String> bookmarkedImages = [];

  // Toggle bookmark status of image
  void toggleBookmark(String imageUrl) {
    if (bookmarkedImages.contains(imageUrl)) {
      bookmarkedImages.remove(imageUrl);
    } else {
      bookmarkedImages.add(imageUrl);
    }
    notifyListeners();
  }

  // Check bookmark status of image
  bool isBookmarked(String imageUrl) {
    return bookmarkedImages.contains(imageUrl);
  }
}

// FavoriteProvider
class FavoriteProvider extends ChangeNotifier {
  List<String> favoriteImages = [];

  // Toggle favorite status of image
  void toggleFavorite(String imageUrl) {
    if (favoriteImages.contains(imageUrl)) {
      favoriteImages.remove(imageUrl);
    } else {
      favoriteImages.add(imageUrl);
    }
    notifyListeners();
  }

  // Check favorite status of image
  bool isFavorite(String imageUrl) {
    return favoriteImages.contains(imageUrl);
  }
}
