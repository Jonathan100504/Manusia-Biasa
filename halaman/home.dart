import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/data.dart';
import 'package:project/halaman/detail.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showAppbar = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'PhotoGal',
              style: GoogleFonts.getFont(
                'Poppins',
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            centerTitle: true,
            floating: true,
            snap: _showAppbar,
            backgroundColor: Color.fromRGBO(7, 160, 129, 1),
            elevation: 0,
          ),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                sliver: SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl = index < ImageData.imagePaths.length
                        ? ImageData.imagePaths[index][1]
                        : profileProvider
                            .posts[index - ImageData.imagePaths.length]
                            .imageURL;
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImageDialog(
                              imageUrl: imageUrl,
                              category: index < ImageData.imagePaths.length
                                  ? ImageData.imagePaths[index][0]
                                  : profileProvider
                                      .posts[
                                          index - ImageData.imagePaths.length]
                                      .category,
                            );
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(imageUrl, fit: BoxFit.cover),
                      ),
                    );
                  },
                  itemCount: ImageData.imagePaths.length +
                      profileProvider.posts.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
