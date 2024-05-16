import 'package:flutter/material.dart';
import 'package:skywander_app/widgets/tour_card_wide.dart';
import 'package:skywander_app/screens/app.dart';

class ToursInCountryScreen extends StatelessWidget {
  const ToursInCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Korea'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(22),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return tourCardWide(
                  image: 'assets/images/korea_pic.png',
                  title: 'Daebak Korea',
                  days: '5 days/3 nights',
                  place: 'South Korea',
                  price: '₱ 10,000/pax',
                  rate: 5.0,
                  size: 96);
            },
          ),
        )),
        bottomNavigationBar: AppLayout());
  }
}

Widget bottomNavBar() {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: 'Home',
        backgroundColor: const Color(0xffE4E3E1),
        activeIcon: Container(
          height: 30,
          width: 60,
          decoration: const BoxDecoration(
              color: Color(0xffBDB7A5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Icon(Icons.home),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.airplanemode_active),
        label: 'Visa',
        activeIcon: Container(
          height: 30,
          width: 60,
          decoration: const BoxDecoration(
              color: Color(0xffBDB7A5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Icon(Icons.airplanemode_active),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite),
        label: 'Wishlist',
        activeIcon: Container(
          height: 30,
          width: 60,
          decoration: const BoxDecoration(
              color: Color(0xffBDB7A5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Icon(Icons.favorite),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.payments),
        label: 'Transaction',
        activeIcon: Container(
          height: 30,
          width: 60,
          decoration: const BoxDecoration(
              color: Color(0xffBDB7A5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Icon(Icons.payments),
        ),
      ),
    ],
    selectedItemColor: Color(0xff6E6853),
    selectedIconTheme: IconThemeData(color: Color(0xff5A5A58)),
    unselectedItemColor: Color(0xff6E6853),
    unselectedLabelStyle: TextStyle(color: Color(0xff6E6853)),
    showUnselectedLabels: true,
  );
}
