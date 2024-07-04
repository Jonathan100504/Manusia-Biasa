import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';
import 'package:project/sidepage/setting.dart';
import 'package:provider/provider.dart';
import 'package:project/sidepage/bookmark.dart';
import 'package:project/sidepage/favorite.dart';

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
    if (_scrollController.offset > 100 &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _showAppbar = false;
      });
    } else if (_scrollController.offset <= 100 &&
        !_scrollController.position.outOfRange) {
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
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                    ),
                  ),
                ),
              ),
              Divider(),
              Wrap(
                children: <Widget>[
                  Consumer<ChangeTheme>(
                    builder: (context, theme, child) {
                      return SwitchListTile(
                        title: Row(
                          children: [
                            Icon(Icons.dark_mode, color: Colors.black), // Icon added here
                            SizedBox(width: 10),
                            Text('Dark Mode', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        value: theme.isDark,
                        onChanged: (bool val) {
                          setState(() {
                            theme.change(val);
                          });
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorite'),
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
                    leading: Icon(Icons.bookmark),
                    title: Text('Bookmark'),
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
                    leading: Icon(Icons.info),
                    title: Text('About Us'),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('About Us'),
                            content: Text(
                              'This app is designed to showcase various presets for editing photos. It provides users with a platform to explore different photo editing styles and purchase presets they like. Feel free to explore and enjoy!',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Colors.white,
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
                          'Kami hanyalah sekelompok/ sekumpulan/ segerombong/ \nsekawan yang berusaha untuk mengejar cita-cita kami, \ndengan langkah kecil yaitu menyelesaikan UTS ini. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ],
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
                      itemCount: profileProvider.posts.length +
                          additionalImages.length,
                      itemBuilder: (context, index, _) {
                        final imageURL = index < profileProvider.posts.length
                            ? profileProvider.posts[index].imageURL
                            : additionalImages[
                                index - profileProvider.posts.length];
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(imageURL, fit: BoxFit.cover),
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
