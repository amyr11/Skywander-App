import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class VisaApplicationFormScreen extends StatefulWidget {
  const VisaApplicationFormScreen({super.key});

  @override
  _VisaApplicationFormScreenState createState() =>
      _VisaApplicationFormScreenState();
}

class _VisaApplicationFormScreenState extends State<VisaApplicationFormScreen> {
  String _selectedPaymentMethod = 'cash';
  String? _selectedFileName;
  bool _isFileUploaded = false;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          _selectedFileName = file.name;
          _isFileUploaded = false; // Reset upload status
        });

        // Handle file processing here
        print('Selected file: ${file.name}');
      } else {
        // User canceled the picker
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _deleteFile() {
    setState(() {
      _selectedFileName = null;
      _isFileUploaded = false; // Reset upload status
    });
  }

  void _uploadFile() {
    setState(() {
      _isFileUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD6CDBC),
        centerTitle: true,
        title: Text(
          'Visa Application',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Download link for APP-FORM-JAPAN-VISA.pdf
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('APP-FORM-JAPAN-VISA.pdf'),
              trailing: IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  // Handle download
                },
              ),
            ),
          ),
          Divider(color: Colors.black),
          SizedBox(height: 16),

          // Display chosen file with CANCEL and UPLOAD buttons
          if (_selectedFileName != null && !_isFileUploaded) ...[
            Card(
              color: Color.fromARGB(193, 253, 253, 253),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: Colors.red, size: 32.0),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _selectedFileName!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: _deleteFile,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _deleteFile,
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _uploadFile,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFFB89F76),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                          child: Text('UPLOAD'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],

          // Display uploaded file
          if (_isFileUploaded && _selectedFileName != null) ...[
            Card(
              elevation: 0,
              child: ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(_selectedFileName!),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _deleteFile,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],

          // Initial state: Upload a file here
          if (_selectedFileName == null || !_isFileUploaded) ...[
            Card(
              color: Color.fromARGB(193, 253, 253, 253),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.upload_file, color: Colors.black, size: 32.0),
                    SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Upload a file here\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: '(PDF file type only and maximum of 1GB)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 116, 115, 115),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _pickFile,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFFAE9F84),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 1.0),
                            ),
                            child: Text('Choose a file'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],

          // Additional content (Japan Tourist Visa, Payment Method)
          Card(
            color: Color.fromARGB(193, 253, 253, 253),
            elevation: 2,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  'Japan Tourist Visa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Visa Fee'),
                            Text('₱10,000'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax & Charges'),
                            Text('₱500'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text('₱10,500'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Color.fromARGB(193, 253, 253, 253),
            elevation: 2,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  'Payment Method',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 'cash',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value.toString();
                            });
                          },
                          title: Text('Cash'),
                        ),
                        RadioListTile(
                          value: 'gcash',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value.toString();
                            });
                          },
                          title: Text('GCash'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '₱10,500',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle pay button press
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFB89F76),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 5.0),
                ),
                child: Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VisaApplicationFormScreen(),
  ));
}
