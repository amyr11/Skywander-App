import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Item> _data = generateItems(); // Custom data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false), // Remove the back button
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'FAQS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.0), // Space between header and the first question
              ..._data.map((item) => _buildPanel(item)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel(Item item) {
    return Column(
      children: [
        ListTile(
          title: Text(
            item.headerValue,
            style: TextStyle(fontSize: 16),
          ),
          trailing: IconButton(
            icon: Icon(
              item.isExpanded ? Icons.remove : Icons.add,
              color: Colors.grey, // Changed color to light grey
            ),
            onPressed: () {
              setState(() {
                item.isExpanded = !item.isExpanded;
              });
            },
          ),
        ),
        if (item.isExpanded)
          Container(
            color: Color(0xFFD6CDBC),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.expandedValue,
              style: TextStyle(fontSize: 14),
            ),
          ),
        Divider(),
      ],
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(headerValue: 'About the company', expandedValue: 'Skywander Travel & Co, from the name itself, is a travel agency based here at Bataan. We provide Visa assistance, ticket booking, land arrangements as well as tour packages.'),
    Item(headerValue: 'When is your company established', expandedValue: 'Skywander Travel & Co was established in 2018. We have been providing travel services for 6 years to travel enthusiasts.'),
    Item(headerValue: 'What services do you offer?', expandedValue: 'Skywander Travel & Co offer various travel and tour services. We provide Visa assistance, ticket booking, land arrangements as well as tour packages.'),
    Item(headerValue: 'What is land arrangement?', expandedValue: 'Land arrangement refers all the land-based components of a trip. This typically includes accommodations, transfers or transportation, activities, and tours.'),
    Item(headerValue: 'How to avail tour package?', expandedValue: 'To avail a tour package, you can contact us through our website or visit our office.'),
    Item(headerValue: 'Do you have domestic tours?', expandedValue: 'Skywander offers both domestic and international tours. To view all the list of our tours, refer to Tours <link> '),
    Item(headerValue: 'How to apply for visa?', expandedValue: 'Visa application can be done through via our Application Form. Kindly access it here <link/hyperlink> '),
  ];
}
