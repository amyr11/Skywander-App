import 'package:flutter/material.dart';
import 'package:skywander_app/widgets/tour_card_wide.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Wishlist'),
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
                size: 96);
          },
        ),
      )),
    );
  }
}
