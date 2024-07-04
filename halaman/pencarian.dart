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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _searchController,
                onChanged: filterResults,
                decoration: const InputDecoration(
                  hintText: "Cari sesuatu...",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
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
                            : Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    selected: selectedOption == option,
                    selectedColor: Color.fromRGBO(7, 160, 129, 1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 180, 180, 180)),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
