import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/data.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';
import 'package:project/halaman/detail.dart';
import 'dart:ui';

class Pencarian extends StatefulWidget {
  const Pencarian({Key? key}) : super(key: key);

  @override
  State<Pencarian> createState() => _PencarianState();
}

class _PencarianState extends State<Pencarian> {
  List<List<String>> _filteredList = [];
  List<String> options = ['Animal', 'City', 'Plant', 'Model', 'Other'];
  String selectedOption = '';
  String searchQuery = '';
  final _searchController = TextEditingController();

  void filterResults(String query) {
    setState(() {
      searchQuery = query;
      _filteredList = ImageData.imagePaths
          .where((item) =>
              item[0].toLowerCase().contains(query.toLowerCase()) &&
              (selectedOption.isEmpty
                  ? true
                  : item[0].contains(selectedOption)))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredList = ImageData.imagePaths;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ChangeTheme>(context);
    bool isDarkMode = themeProvider.isDark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: _searchController,
            onChanged: filterResults,
            style: TextStyle(color: isDarkMode ? Colors.white : Color.fromARGB(255, 33, 33, 33)),
            decoration: InputDecoration(
              hintText: "Cari sesuatu...",
              prefixIcon: Icon(
                Icons.search,
                color: isDarkMode ? Colors.white : Color.fromARGB(255, 33, 33, 33),
              ),
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.white70 : Color.fromARGB(255, 33, 33, 33),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Color.fromARGB(255, 33, 33, 33)),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 5, 
                runSpacing: 5, 
                children: options.map((option) {
                  return RawChip(
                    label: Text(
                      option,
                      style: TextStyle(
                        fontSize: 12, 
                        color: selectedOption == option
                            ? Colors.white
                            : isDarkMode ? Colors.white : Color.fromARGB(255, 33, 33, 33),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                    selected: selectedOption == option,
                    selectedColor: Color.fromRGBO(7, 160, 129, 1),
                    backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 33, 33) : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 180, 180, 180)),
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    showCheckmark: false, // Hilangkan centang
                    onSelected: (selected) {
                      setState(() {
                        selectedOption = selected ? option : '';
                        filterResults(searchQuery);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              List<Post> allPosts = [
                ...profileProvider.posts,
                ...ImageData.imagePaths
                    .map((item) => Post(imageURL: item[1], category: item[0]))
                    .toList()
              ];
              List<Post> filteredPosts = allPosts
                  .where((post) =>
                      post.category
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) &&
                      (selectedOption.isEmpty
                          ? true
                          : post.category.contains(selectedOption)))
                  .toList();
              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                sliver: selectedOption.isEmpty
                    ? SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        itemCount: filteredPosts.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ImageDialog(
                                          imageUrl: filteredPosts[index].imageURL,
                                          category: filteredPosts[index].category,
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        filteredPosts[index].imageURL,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      )
                    : filteredPosts.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ImageDialog(
                                            imageUrl:
                                                filteredPosts[index].imageURL,
                                            category:
                                                filteredPosts[index].category,
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.network(
                                            filteredPosts[index].imageURL,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: filteredPosts.length,
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: Text('No results found'),
                            ),
                          ),
              );
            },
          ),
        ],
      ),
    );
  }
}
