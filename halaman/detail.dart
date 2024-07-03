import 'package:flutter/material.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatefulWidget {
  final String imageUrl;
  final String category;

  const ImageDialog({
    Key? key,
    required this.imageUrl,
    required this.category,
  }) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isLiked = context.read<FavoriteProvider>().isFavorite(widget.imageUrl);
    _isSaved = context.read<BookmarkProvider>().isBookmarked(widget.imageUrl);
  }

  void _toggleLiked() {
    setState(() {
      _isLiked = !_isLiked;
      context.read<FavoriteProvider>().toggleFavorite(widget.imageUrl);
    });
  }

  void _toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
      context.read<BookmarkProvider>().toggleBookmark(widget.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(widget.imageUrl),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _toggleLiked,
                  icon: _isLiked
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                ),
                IconButton(
                  onPressed: _toggleSaved,
                  icon: _isSaved
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_border),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Category: ${widget.category}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
