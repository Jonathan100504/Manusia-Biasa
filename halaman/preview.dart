import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';
import 'package:project/halaman/payment.dart';

class PreviewPage extends StatelessWidget {
  final List<String> imageList;
  final String description;
  final String additionalDescription;
  final String price;

  PreviewPage({
    required this.imageList,
    required this.description,
    required this.additionalDescription,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Colors.black;
        Color backColor = theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Toko Preset',
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            backgroundColor: Color.fromRGBO(7, 160, 129, 1), 
            iconTheme: IconThemeData(color: Colors.white), 
          ),
          body: Container(
            color: backColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                    ),
                    items: imageList.map((String imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Text(
                                    imageList.indexOf(imagePath) == 0 ? 'Before' : 'After',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          additionalDescription,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentProcessPage(
                                description: description,
                                price: price,
                                imageList: imageList, 
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.green),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                        ),
                        child: Text(
                          'Beli Sekarang',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
