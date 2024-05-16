import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int _selectedIndex = 0;
  static const List<String> _statusOptions = ['Upcoming', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildSegmentedControl(),
          SizedBox(height: 20),
          _selectedIndex == 0 ? _buildTripPackages() : _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _statusOptions.length * 2 - 1, // Account for dividers
            (index) {
              if (index.isEven) {
                int buttonIndex = index ~/ 2;
                return _buildSegmentedButton(_statusOptions[buttonIndex], buttonIndex);
              } else {
                return Container(
                  width: 1, // Adjust the width as needed
                  height: 30, // Adjust the height as needed
                  color: Colors.grey,
                );
              }
            },
          ),
        ),
      ),
    );
  }

Widget _buildSegmentedButton(String label, int index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedIndex = index;
      });
    },
    child: Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: _selectedIndex == index ? Color(0xFFAE9F84) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Color(0xFF565140) : Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}



bool _isTripPackagesExpanded = true;

Widget _buildTripPackages() {
  // This is a placeholder for displaying trip packages
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Trip Packages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isTripPackagesExpanded = !_isTripPackagesExpanded;
                    });
                  },
                  icon: Icon(
                    _isTripPackagesExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (_isTripPackagesExpanded) ...[
        _buildTripDetailsCard('Daebak Korea', 'Manila South Korea'),
        // Add more trip details cards as needed
      ],
    ],
  );
}



Widget _buildTripDetailsCard(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFFDFDDDA), // Set card color to DFDDDA
      borderRadius: BorderRadius.circular(15), // Add border radius to make rounded corners
      border: Border.all(
        color: Colors.grey.withOpacity(0.5), // Set border color with opacity
        width: 1, // Set border width
      ),
    ),
    child: Card(
      elevation: 0, // Remove the elevation of the card
      color: Colors.transparent, // Set card color to transparent to allow the container color to show
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Set border radius to match the container
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5, // Adjust the top position as needed
            right: 15, // Adjust the right position as needed
            child: Container(
              width: 120, // Set the width of the image container
              height: 70, // Set the height of the image container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Set border radius to make rounded corners
                border: Border.all(
                  color: Colors.grey, // Set border color
                  width: 1, // Set border width
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Clip the image with rounded corners
                child: Image.network(
                  'https://images6.alphacoders.com/874/874982.jpg', // Image URL
                  fit: BoxFit.cover, // Cover the container with the image
                  width: 120, // Set the width of the image
                  height: 70, // Set the height of the image
                ),
              ),
            ),
          ),
          Positioned(
            top: 85, // Adjust the top position to align with the bottom of the photo with some space
            right: 10, // Adjust the right position as needed
            child: Container(
              width: 130, // Set the width to match the photo width
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Set border color
                    width: 1, // Set border width
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Set font size to 16 and bold
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Manila ',
                      style: TextStyle(fontSize: 16), // Set font size to 14
                    ),
                    Transform.rotate(
                      angle: 1.6, // Rotate the airplane icon clockwise (in radians)
                      child: Icon(Icons.airplanemode_active), // Airplane icon
                    ),
                    Text(
                      ' South Korea',
                      style: TextStyle(fontSize: 14), // Set font size to 14
                    ),
                  ],
                ),
                SizedBox(height: 35),
                // New Row added before displaying dates
                Row(
                  children: [
                    
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Feb 03, 2024', // Left alignment
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Set font size to 16 and bold
                    ),
                    Text(
                      'Feb 07, 2024', // Right alignment
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Set font size to 16 and bold
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '5 Days',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), // Set font size to 16 and bold
                    ),
                  ],
                ),
                SizedBox(height: 5), // Increase the height between "5 Days" and "Saturday" rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align both texts to the start
                  children: [
                    Text(
                      'Saturday', // Left alignment
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Set font size to 16 and bold
                    ),
                    SizedBox(width: 150), // Add space between "Saturday" and "Wednesday"
                    Text(
                      'Wednesday', // Right alignment
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Set font size to 16 and bold
                    ),
                  ],
                ),
                SizedBox(height: 10), // Add space between "Wednesday" and buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle view ticket button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFAE9F84), // Set view ticket button color
                        ),
                        child: Text(
                          'View Ticket',
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add space between the two buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle reminder button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB3261E), // Set reminder button color
                        ),
                        child: Text(
                          'Reminder',
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}





  Widget _buildTransactionList() {
    // Here you can implement logic to display transactions based on the selected index
    // For now, let's just display a placeholder text
    return Center(
      child: Text(
        'Display transactions for: ${_statusOptions[_selectedIndex]}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TransactionScreen(),
    theme: ThemeData(
    scaffoldBackgroundColor:  Color(0xFFF7F5F1),
  ),
  ));
}
