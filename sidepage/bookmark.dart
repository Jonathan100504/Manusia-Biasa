import 'package:flutter/material.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarked Images')),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            itemCount: provider.bookmarkedImages.length,
            itemBuilder: (context, index) {
              String imageUrl = provider.bookmarkedImages[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ImageDialog(
                        imageUrl: imageUrl,
                        category: 'Bookmark',
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
