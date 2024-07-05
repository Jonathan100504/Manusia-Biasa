import 'package:flutter/material.dart';

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
  final DateTime? scheduledDateTime; 

  Post({
    required this.imageURL,
    required this.category,
    this.scheduledDateTime,
  });
}

class ProfileProvider extends ChangeNotifier {
  List<Post> posts = [];

  void addPost({
    required String imageURL,
    required String category,
    DateTime? scheduledDateTime,
  }) {
    Post newPost = Post(
      imageURL: imageURL,
      category: category,
      scheduledDateTime: scheduledDateTime,
    );
    posts.add(newPost);
    
    if (scheduledDateTime != null) {
     
      _scheduleNotification(newPost);
    }
    
    notifyListeners();
  }

  void removeLastPost() {
    if (posts.isNotEmpty) {
      posts.removeLast();
      notifyListeners();
    }
  }

  void shufflePosts() {
    posts.shuffle();
    notifyListeners();
  }

 
  void _scheduleNotification(Post post) {
    notifyListeners();
  }
}

class LoveProvider extends ChangeNotifier {
  Map<String, bool> lovedImages = {};

  void toggleLove(String imageUrl) {
    lovedImages.update(imageUrl, (value) => !value, ifAbsent: () => true);
    notifyListeners();
  }

  bool isLoved(String imageUrl) {
    return lovedImages[imageUrl] ?? false;
  }
}

class BookmarkProvider extends ChangeNotifier {
  List<String> bookmarkedImages = [];

  void toggleBookmark(String imageUrl) {
    if (bookmarkedImages.contains(imageUrl)) {
      bookmarkedImages.remove(imageUrl);
    } else {
      bookmarkedImages.add(imageUrl);
    }
    notifyListeners();
  }

  bool isBookmarked(String imageUrl) {
    return bookmarkedImages.contains(imageUrl);
  }
}

class FavoriteProvider extends ChangeNotifier {
  List<String> favoriteImages = [];

  void toggleFavorite(String imageUrl) {
    if (favoriteImages.contains(imageUrl)) {
      favoriteImages.remove(imageUrl);
    } else {
      favoriteImages.add(imageUrl);
    }
    notifyListeners();
  }

  bool isFavorite(String imageUrl) {
    return favoriteImages.contains(imageUrl);
  }
}
