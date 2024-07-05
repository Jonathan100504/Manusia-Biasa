import 'package:flutter/material.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmark',
          style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(7, 160, 129, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, _) {
          final isDarkMode = Provider.of<ChangeTheme>(context).isDark;
          final Color backgroundColor =
              isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white;

          return Container(
            color: backgroundColor, // Ubah warna latar belakang sesuai dengan dark mode
            child: ListView.builder(
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Sesuaikan padding di sini
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10), // Opsi: tambahkan border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
