import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/provider.dart'; 

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
  late bool _isLiked;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();

    _isLiked = Provider.of<FavoriteProvider>(context, listen: false).isFavorite(widget.imageUrl);
    _isSaved = Provider.of<BookmarkProvider>(context, listen: false).isBookmarked(widget.imageUrl);
  }

  void _toggleLiked() {
    setState(() {
      _isLiked = !_isLiked;
      Provider.of<FavoriteProvider>(context, listen: false).toggleFavorite(widget.imageUrl);
    });
  }

  void _toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
      Provider.of<BookmarkProvider>(context, listen: false).toggleBookmark(widget.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 500),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 8),
                  IconButton(
                    icon: _isLiked
                        ? Icon(Icons.favorite, color: Colors.red, size: 28) 
                        : Icon(Icons.favorite_border, size: 28), 
                    onPressed: _toggleLiked,
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    icon: _isSaved
                        ? Icon(Icons.bookmark, color: Colors.blue, size: 28) 
                        : Icon(Icons.bookmark_border, size: 28), 
                    onPressed: _toggleSaved,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/fotoprofil.jpg'), 
              ),
              title: Text(
                'Username', 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                '666 Followers . 66 Uploads',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
