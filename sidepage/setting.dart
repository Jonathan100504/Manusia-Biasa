import 'package:flutter/material.dart';
import 'package:project/provider.dart';
import 'package:project/sidepage/bookmark.dart';
import 'package:project/sidepage/favorite.dart';
import 'package:provider/provider.dart';
import 'package:project/autentikasi/login.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Colors.black;
        Color backColor =
            theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;
        return Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(color: textColor),
            ),
            backgroundColor: backColor,
            foregroundColor: textColor,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: Text(
                    theme.isDark ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(color: textColor),
                  ),
                  value: theme.isDark,
                  onChanged: (bool val) {
                    setState(() {
                      theme.change(val);
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritePage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: textColor,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: backColor,
                        child: Text(
                          'Favorite',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarkPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: textColor,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: backColor,
                        child: Text(
                          'Bookmark',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/qoutes.jpg',
                  width: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'This app is designed to showcase various presets for editing photos. It provides users with a platform to explore different photo editing styles and purchase presets they like. Feel free to explore and enjoy!',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
