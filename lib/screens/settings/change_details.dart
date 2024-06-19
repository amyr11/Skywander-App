import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class ChangeDetailsScreen extends StatefulWidget {
  const ChangeDetailsScreen({Key? key}) : super(key: key);

  @override
  _ChangeDetailsScreenState createState() => _ChangeDetailsScreenState();
}

class _ChangeDetailsScreenState extends State<ChangeDetailsScreen> {
  // Variables to store user details
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _selectedCountryRegion = 'Select Country Region';

  // Function to handle saving changes
  void _saveChanges() {
    // Implement saving changes logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44, // Changed to 44 for 88x88 size
                    backgroundImage: AssetImage('assets/default_avatar.png'), // Provide default image path
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        // Implement logic to pick image from gallery or camera
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24, // Changed font size to 24
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed font color to black
                  fontFamily: 'Lato',
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Changed font color to black
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Adjust spacing between label and text field
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Changed font color to black
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Adjust spacing between label and text field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Changed font color to black
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Adjust spacing between label and text field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country/Region',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Changed font color to black
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Adjust spacing between label and dropdown field
            DropdownButtonFormField<String>(
              value: _selectedCountryRegion,
              onChanged: (value) {
                setState(() {
                  _selectedCountryRegion = value!;
                });
              },
              items: <String>[
                'Select Country Region',
                'New Zealand',
                'Philippines',
                'USA',
                // Add more countries as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAE9F84)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('Save Changes'),
                  ),
                ),
                SizedBox(width: 16), // Adjust spacing between buttons
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Implement cancel logic here
                    },
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}