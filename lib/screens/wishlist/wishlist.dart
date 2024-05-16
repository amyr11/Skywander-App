import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/tour_card_wide.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(kDefaultSpace),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return TourCardWide(
              rating: 4.5,
              imageUrl: "https://placehold.co/600x400/png",
              title: 'Daebak Korea',
              subtitle: '5 days · 3 nights',
              details: 'Experience the best of Korea in 5 days and 3 nights',
              location: 'South Korea',
              price: '₱ 10,000 / pax',
              isFavorite: true,
              onFavorite: () {},
              onTap: () {
                GoRouter.of(context).push('/tour-details');
              },
            );
          },
        ),
      ),
    );
  }
}
