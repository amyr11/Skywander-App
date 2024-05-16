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
        title: Text('Transaction Screen'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildSegmentedControl(),
          SizedBox(height: 20),
          _buildTransactionList(),
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.brown : Colors.black,
          ),
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
  ));
}
