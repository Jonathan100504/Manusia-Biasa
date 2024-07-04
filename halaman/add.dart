import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class Tambah extends StatefulWidget {
  const Tambah({Key? key}) : super(key: key);

  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final TextEditingController _imageURLController = TextEditingController();
  String _selectedCategory = 'Other';
  Uint8List? _pickedImage;

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List pic = await image.readAsBytes();
      setState(() {
        _pickedImage = pic;
        _imageURLController.text = image.path; // Assigning path to controller
      });
    }
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Uint8List pic = await image.readAsBytes();
      setState(() {
        _pickedImage = pic;
        _imageURLController.text = image.path; // Assigning path to controller
      });
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Enter URL'),
                onTap: () {
                  Navigator.pop(context);
                  _showManualImageURLDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showManualImageURLDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Image URL'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _imageURLController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      // Remove the last added post
                      Provider.of<ProfileProvider>(context, listen: false)
                          .removeLastPost();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      String enteredURL = _imageURLController.text.trim();
                      if (enteredURL.isNotEmpty) {
                        _loadImageFromUrl(enteredURL); // Load image from URL
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadImageFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _pickedImage = response.bodyBytes; // Set picked image from URL
      });
    } else {
      // Handle error cases here if needed
      print('Failed to load image from URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 254, 254),
              shadows: [
                Shadow(color: Colors.black, blurRadius: 5, offset: Offset(1, 1)),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(7, 160, 129, 1),
        elevation: 1,
        centerTitle: true,
      ),
      body: Consumer<ChangeTheme>(
        builder: (context, theme, child) {
          Color textColor = Colors.black;
          Color backColor = Colors.white;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: backColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showImagePickerOptions(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: MemoryImage(_pickedImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _pickedImage == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: backColor,
                    value: _selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: <String>[
                      'Animal',
                      'City',
                      'Plant',
                      'Model',
                      'Other'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: textColor.withOpacity(1), 
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.5)), 
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pickedImage == null && _imageURLController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Masukkan gambar terlebih dahulu'),
                          ),
                        );
                      } else {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .addPost(
                          imageURL: _imageURLController.text.isNotEmpty
                              ? _imageURLController.text.trim()
                              : '',
                          category: _selectedCategory,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post added'),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'CANCEL',
                              onPressed: () {
                                Provider.of<ProfileProvider>(context, listen: false)
                                    .removeLastPost();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                        setState(() {
                          _pickedImage = null; // Reset picked image after post is added
                        });
                        // Navigate back to Home page
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                    },
                    child: Text('Share', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(7, 160, 129, 1),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}