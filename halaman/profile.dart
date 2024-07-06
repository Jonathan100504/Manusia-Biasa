import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';
import 'package:project/sidepage/bookmark.dart';
import 'package:project/sidepage/favorite.dart';
import 'package:project/autentikasi/login.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppbar = true;

  List<String> additionalImages = [
    'https://cdn.pixabay.com/photo/2024/03/09/12/48/water-8622588_640.png',
    'https://cdn.pixabay.com/photo/2018/06/22/08/24/emotions-3490223_640.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset > 100 && !_scrollController.position.outOfRange) {
      setState(() {
        _showAppbar = false;
      });
    } else if (_scrollController.offset <= 100 && !_scrollController.position.outOfRange) {
      setState(() {
        _showAppbar = true;
      });
    }
  }

  void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      // Menggunakan Consumer untuk mendengarkan perubahan tema
      return Consumer<ChangeTheme>(
        builder: (context, theme, child) {
          final isDarkMode = theme.isDark; // Periksa apakah dark mode aktif
          return Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(color: isDarkMode ? Colors.white54 : Colors.black54),
                Wrap(
                  children: <Widget>[
                    SwitchListTile(
                      title: Row(
                        children: [
                          Icon(Icons.dark_mode, color: isDarkMode ? Colors.white : Colors.black),
                          SizedBox(width: 10),
                          Text('Dark Mode', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                      value: theme.isDark,
                      onChanged: (bool val) {
                        theme.change(val); // Mengubah tema
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite, color: isDarkMode ? Colors.white : Colors.black),
                      title: Text('Favorite', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.bookmark, color: isDarkMode ? Colors.white : Colors.black),
                      title: Text('Bookmark', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookmarkPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info, color: isDarkMode ? Colors.white : Colors.black),
                      title: Text('About Us', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white,
                              title: Text(
                                'About Us',
                                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                              ),
                              content: Text(
                                'This app is designed to showcase various presets for editing photos. It provides users with a platform to explore different photo editing styles and purchase presets they like. Feel free to explore and enjoy!',
                                style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: isDarkMode ? Colors.white : Colors.black),
                      title: Text('Logout', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ChangeTheme>(context).isDark;
    final Color scaffoldBackgroundColor =
        isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Color.fromRGBO(255, 255, 255, 1),
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          foregroundImage: AssetImage('assets/fotoprofil.jpg'),
                          radius: 60,
                        ),
                      ),
                      Text(
                        'Manusia Biasa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                          shadows: [
                            Shadow(
                              color: isDarkMode ? Colors.black : Colors.white,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Kami hanyalah sekelompok/ sekumpulan/ segerombong/ \nsekawan yang berusaha untuk mengejar cita-cita kami, \ndengan langkah kecil yaitu menyelesaikan UAS ini. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    icon: Icon(Icons.menu),
                    iconSize: 35,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )
                ],
                toolbarHeight: 50,
                floating: true,
                snap: _showAppbar,
                elevation: 0,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      itemCount: profileProvider.posts.length + additionalImages.length,
                      itemBuilder: (context, index, _) {
                        final imageURL = index < profileProvider.posts.length
                            ? profileProvider.posts[index].imageURL
                            : additionalImages[index - profileProvider.posts.length];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ImageDialog(
                                  imageUrl: imageURL,
                                  category: index < profileProvider.posts.length
                                      ? profileProvider.posts[index].category
                                      : 'No Category',
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(imageURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
