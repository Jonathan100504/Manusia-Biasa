import 'package:flutter/material.dart';
import 'package:project/halaman/pencarian.dart';
import 'package:project/halaman/cart.dart';
import 'package:project/halaman/home.dart';
import 'package:project/halaman/profile.dart';
import 'package:project/halaman/add.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class botNavBar extends StatefulWidget {
  const botNavBar({Key? key}) : super(key: key);

  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<botNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Pencarian(),
    Keranjang(),
    Profil()
  ];

  List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.shopping_cart_outlined,
    Icons.person,
  ];

  List<Color> _colors = [
    Color.fromRGBO(6, 131, 106, 1),
    Color.fromRGBO(7, 160, 129, 1),
    Color.fromRGBO(7, 160, 129, 1),
    Color.fromRGBO(7, 160, 129, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Color.fromARGB(255, 33, 33, 33);
        Color backgroundColor = theme.isDark ? Color.fromARGB(255, 33, 33, 33) : Colors.white;
        List<Color> iconColors = List.generate(
          _icons.length,
          (index) => _selectedIndex == index ? Colors.white : textColor,
        );

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: null,
            notchMargin: 0,
            color: backgroundColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_icons.length, (index) {
                return IconButton(
                  icon: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? _colors[index] : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      _icons[index],
                      color: iconColors[index],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              }),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Tambah();
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(7, 160, 129, 1),
            foregroundColor: Colors.white,
            shape: CircleBorder(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
