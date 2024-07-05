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
        title: Text(
          'Username',
          style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 5, offset: Offset(1, 1)),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(7, 160, 129, 1),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 4,
      ),
      body: Consumer<ChangeTheme>(
        builder: (context, theme, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      IconButton(
                        icon: _isLiked
                            ? Icon(Icons.favorite, color: theme.isDark ? Colors.red : Colors.red, size: 28)
                            : Icon(Icons.favorite_border, color: theme.isDark ? Colors.white : Colors.black, size: 28),
                        onPressed: _toggleLiked,
                      ),
                      SizedBox(width: 12),
                      IconButton(
                        icon: _isSaved
                            ? Icon(Icons.bookmark, color: theme.isDark ? Colors.blue : Colors.blue, size: 28)
                            : Icon(Icons.bookmark_border, color: theme.isDark ? Colors.white : Colors.black, size: 28),
                        onPressed: _toggleSaved,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/fotoprofil.jpg'),
                    ),
                    title: Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '666 Followers . 66 Uploads',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: theme.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Provider.of<ChangeTheme>(context).isDark
          ? Color.fromARGB(255, 33, 33, 33)
          : Colors.white,
    );
  }
}
