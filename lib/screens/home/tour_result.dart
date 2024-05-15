import 'package:flutter/material.dart';
import 'package:skywander_app/widgets/tour_card_wide.dart';

class TourResultScreen extends StatefulWidget {
  const TourResultScreen({super.key});

  @override
  State<TourResultScreen> createState() => _TourResultScreenState();
}

class _TourResultScreenState extends State<TourResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Available Package'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.filter_list))
          ],
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
                  isStarred: true,
                  size: 96);
            },
          ),
        )));
  }
}
