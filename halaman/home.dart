import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:project/data.dart'; // Replace with actual data import
import 'package:project/halaman/detail.dart'; // Replace with actual detail page import
import 'package:project/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> combinedList = [];

  @override
  void initState() {
    super.initState();
    _shuffleAndCombinePosts();
  }

  Future<void> _refreshData(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    Provider.of<ProfileProvider>(context, listen: false).shufflePosts();

    setState(() {
      _shuffleAndCombinePosts();
    });
  }

  void _shuffleAndCombinePosts() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    setState(() {
      combinedList = [
        ...ImageData.imagePaths.map((image) => Post(imageURL: image[1], category: image[0])),
        ...profileProvider.posts,
      ];
      combinedList.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ChangeTheme>(context).isDark;
    final Color appBarTextColor = isDarkMode ? Colors.white : Colors.white;
    final Color appBarBackgroundColor = isDarkMode
        ? Color.fromRGBO(7, 160, 129, 1)
        : Color.fromRGBO(7, 160, 129, 1);
    final Color scaffoldBackgroundColor =
        isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'PhotoGal',
                style: GoogleFonts.getFont(
                  'Poppins',
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: appBarTextColor,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 5, offset: Offset(1, 1)),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              floating: true,
              backgroundColor: appBarBackgroundColor,
              elevation: 0,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ImageDialog(
                            imageUrl: combinedList[index].imageURL,
                            category: combinedList[index].category,
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(combinedList[index].imageURL, fit: BoxFit.cover),
                    ),
                  );
                },
                itemCount: combinedList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
