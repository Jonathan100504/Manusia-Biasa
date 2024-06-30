import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/provider.dart';
import 'package:project/data.dart';

class DetailPage extends StatefulWidget {
  final String imageUrl;
  final List<String> options;

  DetailPage({
    Key? key,
    required this.imageUrl,
    required this.options,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = _getSelectedOption(widget.imageUrl, widget.options);
  }

  String _getSelectedOption(String imageUrl, List<String> options) {
    for (var imagePath in ImageData.imagePaths) {
      if (imageUrl == imagePath[1]) {
        return imagePath[0];
      }
    }
    return 'Other';
  }

  bool _shouldHideOption(String option) {
    const List<String> hiddenOptions = ['animal', 'city', 'model', 'food']; // Daftar kategori yang ingin Anda sembunyikan
    return hiddenOptions.contains(option.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Colors.black;
        Color chipColor = theme.isDark ? Color.fromRGBO(7, 160, 129, 1) : Color.fromRGBO(7, 160, 129, 1);
        Color chipBorderColor = theme.isDark ? Color.fromRGBO(7, 160, 129, 1) : Color.fromRGBO(7, 160, 129, 1);
        Color chipTextColor = theme.isDark ? Colors.white : Colors.white; 
        Color backgroundColor = theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;

        return Scaffold(
          appBar: AppBar(
            title: Text('Nama Pengguna', style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: textColor),
          ),
          body: Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                  Center(
                    child: AspectRatio(
                      aspectRatio: 4 / 4,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 500), 
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Consumer<LoveProvider>(
                          builder: (context, loveProvider, _) {
                            final isLiked = loveProvider.lovedImages.containsKey(widget.imageUrl)
                                ? loveProvider.lovedImages[widget.imageUrl]!
                                : false;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  loveProvider.toggleLove(widget.imageUrl);
                                });
                              },
                              child: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                size: 32,
                                color: isLiked ? Colors.red : textColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 12),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share, size: 32, color: textColor),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Visibility(
                              visible: !_shouldHideOption(selectedOption),
                              child: Chip(
                                label: Text(
                                  selectedOption,
                                  style: TextStyle(fontSize: 18, color: chipTextColor),
                                ),
                                backgroundColor: chipColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: chipBorderColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/fotoprofil.jpg'),
                    ),
                    title: Text(
                      'Nama Pengguna',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      '666 Followers . 66 Uploads',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
