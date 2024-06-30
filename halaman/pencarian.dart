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
  final List<List<String>> _filteredList = ImageData.imagePaths;
  final List<String> options = ['Animal', 'City', 'Plant', 'Model', 'Other'];
  String selectedOption = '';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void filterResults(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Colors.black;
        Color backgroundColor =
            theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _searchController,
                    onChanged: filterResults,
                    decoration: InputDecoration(
                      hintText: "Cari sesuatu...",
                      prefixIcon: Icon(Icons.search, color: textColor),
                      hintStyle: TextStyle(color: textColor),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),
                floating: true,
                snap: true,
                backgroundColor: backgroundColor,
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: options.map((option) {
                      return ChoiceChip(
                        label: Text(
                          option,
                          style: TextStyle(
                            color: selectedOption == option
                                ? Colors.white
                                : theme.isDark
                                    ? Colors.white
                                    : const Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                        selected: selectedOption == option,
                        selectedColor: theme.isDark
                            ? const Color.fromRGBO(7, 160, 129, 1)
                            : const Color.fromRGBO(7, 160, 129, 1), 
                        backgroundColor: theme.isDark
                            ? const Color.fromARGB(255, 40, 40, 40)
                            : const Color.fromARGB(255, 255, 255, 255), 
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: theme.isDark
                                ? Colors.white.withOpacity(0.3)
                                : const Color.fromARGB(255, 180, 180, 180),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedOption = selected ? option : '';
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
                    ..._filteredList.map(
                        (item) => Post(imageURL: item[1], category: item[0]))
                  ];
                  List<Post> filteredPosts = allPosts.where((post) {
                    final categoryMatches = post.category.toLowerCase().contains(searchQuery);
                    final optionMatches = selectedOption.isEmpty || post.category.contains(selectedOption);
                    return categoryMatches && optionMatches;
                  }).toList();
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: filteredPosts.isNotEmpty
                        ? selectedOption.isEmpty
                            ? SliverStaggeredGrid.countBuilder(
                                crossAxisCount: 2,
                                itemCount: filteredPosts.length,
                                itemBuilder: (BuildContext context, int index) =>
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                imageUrl: filteredPosts[index].imageURL,
                                                options: options,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                              filteredPosts[index].imageURL),
                                        ),
                                      ),
                                    ),
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.fit(1),
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              imageUrl: filteredPosts[index].imageURL,
                                              options: options,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            filteredPosts[index].imageURL,
                                            fit: BoxFit.cover,
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
                              child: Text('No results found', style: TextStyle(color: textColor)),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
