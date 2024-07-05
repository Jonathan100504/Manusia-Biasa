import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/provider.dart';

class PaymentProcessPage extends StatefulWidget {
  final String description;
  final String price;
  final List<String> imageList;

  PaymentProcessPage({
    required this.description,
    required this.price,
    required this.imageList,
  });

  @override
  _PaymentProcessPageState createState() => _PaymentProcessPageState();
}

class _PaymentProcessPageState extends State<PaymentProcessPage> {
  String _paymentMethod = 'Pilih Metode Pembayaran';
  String _selectedBank = 'Pilih Bank';
  TextEditingController _creditCardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String afterImage = widget.imageList.length > 1 ? widget.imageList[1] : widget.imageList[0];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proses Pembayaran',
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
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.description}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${widget.price}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        afterImage,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showPaymentMethods(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _paymentMethod == 'Pilih Metode Pembayaran'
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : Colors.black,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: _paymentMethod == 'Pilih Metode Pembayaran'
                      ? Colors.white
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: _paymentMethod == 'Pilih Metode Pembayaran' ? 0.5 : 1.0,
                      child: Text(
                        '$_paymentMethod',
                        style: TextStyle(
                          color: _paymentMethod == 'Pilih Metode Pembayaran'
                              ? Colors.black
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              SizedBox(height: 30),
              if (_paymentMethod == 'Kartu Kredit') _buildCreditCardForm(),
              if (_paymentMethod == 'Dompet Digital') _buildDigitalWalletForm(),
              if (_paymentMethod == 'Transfer Bank') _buildBankTransferForm(),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_paymentMethod == 'Pilih Metode Pembayaran') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Text('Harap pilih metode pembayaran terlebih dahulu.'),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (_formKey.currentState?.validate() ?? false) {
                        _showSuccessDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
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
  }

  Widget _buildCreditCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masukkan Kartu Kredit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _creditCardNumberController,
          decoration: InputDecoration(
            labelText: 'Nomor Kartu Kredit',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan nomor kartu kredit';
            }
            if (value.length != 16) {
              return 'Nomor kartu kredit harus 16 digit';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Kadaluarsa (MM/YY)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan tanggal kadaluarsa';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kode CVV';
                  }
                  if (value.length != 3) {
                    return 'CVV harus 3 digit';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDigitalWalletForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masukkan Nomor HP',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _phoneNumberController,
          decoration: InputDecoration(
            labelText: 'Nomor HP',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan nomor HP';
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Nomor HP hanya boleh berisi angka';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBankTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Bank',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            _showBankSelectionBottomSheet(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Nama Bank',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedBank),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _accountNumberController,
          decoration: InputDecoration(
            labelText: 'Nomor Rekening',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan nomor rekening';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(), // Divider hanya untuk memisahkan judul dari pilihan
            ListTile(
              title: Center(child: Text('Kartu Kredit')),
              onTap: () {
                setState(() {
                  _paymentMethod = 'Kartu Kredit';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(child: Text('Dompet Digital')),
              onTap: () {
                setState(() {
                  _paymentMethod = 'Dompet Digital';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(child: Text('Transfer Bank')),
              onTap: () {
                setState(() {
                  _paymentMethod = 'Transfer Bank';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showBankSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  'Pilih Bank',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(), // Divider hanya untuk memisahkan judul dari pilihan
            ListTile(
              title: Center(child: Text('Bank Mandiri')),
              onTap: () {
                setState(() {
                  _selectedBank = 'Bank Mandiri';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(child: Text('Bank BCA')),
              onTap: () {
                setState(() {
                  _selectedBank = 'Bank BCA';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(child: Text('Bank BRI')),
              onTap: () {
                setState(() {
                  _selectedBank = 'Bank BRI';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(child: Text('Bank BNI')),
              onTap: () {
                setState(() {
                  _selectedBank = 'Bank BNI';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Berhasil'),
          content: Text('Terima kasih atas pembayaran Anda.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
