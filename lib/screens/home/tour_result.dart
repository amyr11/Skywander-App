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
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                const Text(
                  'Manila' + ' to ' + 'Korea' + ' | ' + 'Feb 03, 2024',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return TourCardWide(
                      rating: 4.5,
                      imageUrl: "https://placehold.co/600x400/png",
                      title: 'Daebak Korea',
                      subtitle: '5 days · 3 nights',
                      details:
                          'Experience the best of Korea in 5 days and 3 nights',
                      location: 'South Korea',
                      price: '₱ 10,000 / pax',
                      isFavorite: false,
                      onFavorite: () {},
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        )));
  }
}
