import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangeTheme extends ChangeNotifier {
  bool isDark = false;

  void change(bool val) {
    isDark = val;
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

  List<Post> get listPostingan => posts;

  void addPosting(Post postingan) {
    posts.add(postingan);
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

  void schedulepost(Duration duration, DateTime scheduletime, Post p) async {
    addPosting(
      Post(
          category:
              "Post available on ${DateFormat("dd MMM yyyy HH:mm").format(scheduletime)}",
          imageURL: "https://static.thenounproject.com/png/78760-200.png"),
    );
    int pos = posts.length - 1;
    await Future.delayed(duration, () {
      posts.removeAt(pos);
      posts.insert(pos, p);
    });
    notifyListeners();
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


class NotificationProvider extends ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  void toggleNotification(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }
}