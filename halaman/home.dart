import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:project/data.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> combinedList = [];

  @override
  void initState() {
    super.initState();
    _combineImages();
  }

  Future<void> _refreshData() async {
    // Simulasi delay untuk loading
    await Future.delayed(Duration(seconds: 2));
    
    // Hanya mengocok ulang daftar gambar saat refresh
    setState(() {
      _shuffleAndCombineImages();
    });
  }

  void _combineImages() {
    // Menggabungkan gambar dari ImageData dan ProfileProvider
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    combinedList = [
      ...ImageData.imagePaths.map((image) => image[1]),
      ...profileProvider.posts.map((post) => post.imageURL),
    ];
  }

  void _shuffleAndCombineImages() {
    // Menggabungkan dan mengacak gambar dari ImageData dan ProfileProvider
    _combineImages();
    combinedList.shuffle(); // Acak gambar
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

    List<String> options = ['Animal', 'City', 'Plant', 'Model', 'Other'];

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            imageUrl: combinedList[index],
                            options: options,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(combinedList[index], fit: BoxFit.cover),
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
