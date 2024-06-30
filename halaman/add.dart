import 'package:flutter/material.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';

class Tambah extends StatefulWidget {
  const Tambah({Key? key}) : super(key: key);

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final TextEditingController _imageURLController = TextEditingController();
  String _selectedCategory = 'Other'; 

  @override
  void dispose() {
    _imageURLController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(
      builder: (context, theme, child) {
        Color textColor = theme.isDark ? Colors.white : Colors.black;
        Color backColor = theme.isDark ? Colors.black : Colors.white;
        return AlertDialog(
          backgroundColor: backColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Post',
                style: TextStyle(color: textColor),
              ),
              IconButton(
                icon: Icon(Icons.close, color: textColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _imageURLController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                dropdownColor: theme.isDark ? Colors.black : Colors.white, 
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>['Animal', 'City', 'Plant', 'Model', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: theme.isDark ? Colors.white : Colors.black, 
                      ),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: textColor),
                ),
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Post',
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                String imageURL = _imageURLController.text.trim();
                if (imageURL.isEmpty) {
                } else {
                  Provider.of<ProfileProvider>(context, listen: false).addPost(
                    imageURL: imageURL,
                    category: _selectedCategory,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
