import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.0 * 6,
            ),
            Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(height: 10),
            ),
            Row(
              children: [
                SizedBox(width: 16.0), // Empty space before label
                Text(
                  'Current Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter current password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 8), // Space after text field
            Row(
              children: [
                SizedBox(width: 16.0), // Empty space before label
                Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter new password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 8), // Space after text field
            Row(
              children: [
                SizedBox(width: 16.0), // Empty space before label
                Text(
                  'Confirm New Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter new password again',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 8), // Space after text field
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Change password logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFAE9F84)),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 50)),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }
}
