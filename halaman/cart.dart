import 'package:flutter/material.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';
import 'package:project/halaman/preview.dart';
import 'package:google_fonts/google_fonts.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({Key? key}) : super(key: key);

  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> with SingleTickerProviderStateMixin {
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
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color backColor = theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;
        return Scaffold(
          backgroundColor: backColor,
          appBar: _showAppbar
              ? AppBar(
                  title: Text(
                    "PhotoGal",
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
                  backgroundColor: Color.fromRGBO(7, 160, 129, 1),
                  elevation: 0,
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size(0.0, 0.0),
                ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreviewPage(
                        imageList: ['assets/citybefore.jpg', 'assets/city.jpg'],
                        description: 'City Photography Preset',
                        additionalDescription: 'Dengan menggunakan preset foto ini, dapat merubah foto kamu yang awalnya gelap menjadi terang.',
                        price: 'IDR 80.000',
                      )),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    height: MediaQuery.of(context).size.height * 0.3, 
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/city.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red, 
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '20% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'City Photography Preset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'IDR 100.000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildImageWithText('assets/nature.jpg', 'Nature Preset', 'IDR 20.000', 'assets/naturebefore.jpg', 'assets/nature.jpg', 'Dengan preset alam ini, gambar alam Anda akan terlihat lebih hidup dengan warna yang kaya.'),
                    buildImageWithText('assets/bnw.jpg', 'Black & White Preset', 'IDR 20.000', 'assets/bnwbefore.jpg', 'assets/bnw.jpg', 'Preset ini akan mengubah gambar Anda menjadi hitam putih, memberikan kesan klasik dan artistik.'),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildImageWithText(String imagePath, String text, String price, String beforeImagePath, String afterImagePath, String additionalDescription) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PreviewPage(
            imageList: [beforeImagePath, afterImagePath],
            description: text,
            additionalDescription: additionalDescription,
            price: price,
          )),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3, // 30% of the screen height
        width: MediaQuery.of(context).size.width * 0.4, // 40% of the screen width
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
