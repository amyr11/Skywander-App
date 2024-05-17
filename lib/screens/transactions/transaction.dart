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

  bool _isTripPackagesExpanded = true;
  bool _isCompletedTripPackagesExpanded = true;
  bool _isTripCancelledPackagesExpanded = true;
  bool _isVisaSectionExpanded = true; 
  bool _isCompletedVisaSectionExpanded = true;

  @override
Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(),
  body: SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(height: 20),
        _buildSegmentedControl(),
        SizedBox(height: 20),
        _selectedIndex == 0
            ? Column(
                children: [
                  _buildTripPackages(),
                  _buildVisaSection(),
                ],
              )
            :_selectedIndex == 1
                ? Column(
                    children: [
                      _buildCompletedTripPackages(),
                      _buildVisaSection(),
                    ],
                  )
            : _selectedIndex == 2
            ? Column(
                children: [
                  _buildCancelledTripPackages(),
                  _buildCompletedVisaSection(),
                ],
              )
             : _buildCompletedTransactionList(),
      ],
    ),
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
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
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
                      style: TextStyle(fontSize: 16), // Set font size to 14
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

  
Widget _buildVisaSection() {
  // This is a placeholder for displaying visa details
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Visa Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isVisaSectionExpanded = !_isVisaSectionExpanded;
                });
              },
              icon: Icon(
                _isVisaSectionExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      if (_isVisaSectionExpanded) ...[
        _buildVisaDetailsCard(
          'SK Tourist Visa',
          'Issued on: Metro Manila',        ),
        // Add more visa details cards as needed
      ],
    ],
  );
}

Widget _buildVisaDetailsCard(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFFDFDDDA),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(description, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20), // Add space between the title/description and the text row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category Type',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Entry Level',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5), // Add space between the text row and the new row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9(A) - Pleasure & Business',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 95, // Adjust the width as needed
                      child: Text(
                        'Single',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Add space between the new row and the button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button tap
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAE9F84), // Set button color
                  ),
                  child: Text(
                    'View Summary',
                    style: TextStyle(color: Colors.white), // Set text color
                  ),
                ),
              ),
              SizedBox(height: 10), // Add space between the button and the bottom of the card
            ],
          ),
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
                  'https://cdn.britannica.com/49/1949-004-8818300C/Flag-South-Korea.jpg', // Image URL
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
        ],
      ),
    ),
  );
}

Widget _buildCompletedTripPackages() {
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
                      _isCompletedTripPackagesExpanded = !_isCompletedTripPackagesExpanded;
                    });
                  },
                  icon: Icon(
                    _isCompletedTripPackagesExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (_isCompletedTripPackagesExpanded) ...[
        _buildTripCompletedDetailsCard('Daebak Korea', 'Manila South Korea'),
        // Add more trip details cards as needed
      ],
    ],
  );
}


Widget _buildTripCompletedDetailsCard(String title, String description) {
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
                      style: TextStyle(fontSize: 16), // Set font size to 14
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
                          'Review',
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

Widget _buildCancelledTripPackages() {
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
                      _isTripCancelledPackagesExpanded = !_isTripCancelledPackagesExpanded;
                    });
                  },
                  icon: Icon(
                    _isTripCancelledPackagesExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (_isTripCancelledPackagesExpanded) ...[
        _buildTripCancelledDetailsCard('Daebak Korea', 'Manila South Korea'),
        // Add more trip details cards as needed
      ],
    ],
  );
}


Widget _buildTripCancelledDetailsCard(String title, String description) {
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
                      style: TextStyle(fontSize: 16), // Set font size to 14
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
                
                Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button tap
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAE9F84), // Set button color
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(color: Colors.white), // Set text color
                  ),
                ),
              ),
              SizedBox(height: 10), // Add space between the button and the bottom of the card
            ],
          ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCompletedVisaSection() {
  // This is a placeholder for displaying visa details
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Visa Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isCompletedVisaSectionExpanded = !_isCompletedVisaSectionExpanded;
                });
              },
              icon: Icon(
                _isCompletedVisaSectionExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      if (_isCompletedVisaSectionExpanded) ...[
        _buildCompletedVisaDetailsCard(
          'SK Tourist Visa',
          'Issued on: Metro Manila',        ),
        // Add more visa details cards as needed
      ],
    ],
  );
}

Widget _buildCompletedVisaDetailsCard(String title, String description) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFFDFDDDA),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(description, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20), // Add space between the title/description and the text row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category Type',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Entry Level',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5), // Add space between the text row and the new row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9(A) - Pleasure & Business',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 95, // Adjust the width as needed
                      child: Text(
                        'Single',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Add space between the new row and the bottom of the card
            ],
          ),
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
                  'https://cdn.britannica.com/49/1949-004-8818300C/Flag-South-Korea.jpg', // Image URL
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
        ],
      ),
    ),
  );
}


  Widget _buildCompletedTransactionList() {
    return Center(
      child: Text(
        'Display transactions for: ${_statusOptions[2]}',
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
