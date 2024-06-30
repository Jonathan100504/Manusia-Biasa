import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/provider.dart';
import 'package:project/sidepage/setting.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final isDarkMode = Provider.of<ChangeTheme>(context).isDark;
        final Color textColor = isDarkMode ? Colors.white : Color.fromARGB(255, 33, 33, 33);
        final Color backgroundColor = isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white;
        final Color appBarColor = isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Color.fromRGBO(255, 255, 255, 1);

        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: appBarColor,
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
                          color: textColor,
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
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Setting(),
                        ),
                      );
                    },
                    icon: Icon(Icons.settings, color: textColor),
                  )
                ],
                toolbarHeight: 30,
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
                        if (index < profileProvider.posts.length) {
                          final imageURL = profileProvider.posts[index].imageURL;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(imageURL, fit: BoxFit.cover),
                            ),
                          );
                        } else {
                          final additionalImageIndex = index - profileProvider.posts.length;
                          final additionalImageURL = additionalImages[additionalImageIndex];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(additionalImageURL, fit: BoxFit.cover),
                            ),
                          );
                        }
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
