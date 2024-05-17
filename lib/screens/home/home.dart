import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/destination_card.dart';
import 'package:skywander_app/widgets/tour_card.dart';
import 'package:skywander_app/widgets/tour_card_wide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'For you';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    String imageUrl = user.photoURL ?? 'https://placehold.co/96x96';
    String name = user.displayName?.split(' ')[0] ?? 'Wanderer';
    ImageProvider image = NetworkImage(imageUrl);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultSpace),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: kDefaultSpace),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: image,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Where to now,',
                style: kLabelSmallSecondary,
              ),
              Text(
                '$name?',
                style: kLabelLarge,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => GoRouter.of(context).push('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(context),
          SizedBox(height: kDefaultSpace),
          _buildCategories(context),
          SizedBox(height: kDefaultSpace),
          _buildView(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(100),
        color: getTheme().colorScheme.surfaceContainer,
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.search),
                ),
                Text(
                  'Search for destinations',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: getTheme().colorScheme.secondary,
                      ),
                ),
                const Spacer(),
                Container(
                  color: getTheme().colorScheme.surfaceContainerHighest,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push('/tour-filter');
                    },
                    icon: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
        child: Row(
          children: [
            _buildCategory(context, 'For you', selectedCategory == 'For you'),
            _buildCategory(context, 'Latest', selectedCategory == 'Latest'),
            _buildCategory(
                context, 'Countries', selectedCategory == 'Countries'),
            _buildCategory(context, 'All', selectedCategory == 'All'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = title;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isSelected ? getTheme().colorScheme.secondaryContainer : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? getTheme().colorScheme.onPrimaryFixedVariant
                : getTheme().colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    switch (selectedCategory) {
      case 'For you':
        return _buildForYouView(context);
      case 'Latest':
        return _buildLatestView(context);
      case 'Countries':
        return _buildCountriesView(context);
      case 'All':
        return _buildAllView(context);
      default:
        return _buildForYouView(context);
    }
  }

  Widget _buildForYouView(BuildContext context) {
    return Column(
      children: [
        _buildRecommended(context),
        SizedBox(height: kDefaultSpace),
        _buildPopular(context),
        SizedBox(height: kDefaultSpace),
      ],
    );
  }

  Widget _buildLatestView(BuildContext context) {
    List dummyMap = [
      {
        'title': 'Trip to Japan',
        'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'details': '5 days · 4 nights',
        'location': 'Japan',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 5.0,
      },
      {
        'title': 'Trip to Paris',
        'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'details': '5 days · 4 nights',
        'location': 'Paris',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 4.8,
      },
    ];

    return _buildVerticalList(
      itemCount: dummyMap.length,
      itemBuilder: (context, index) {
        return TourCardWide(
          title: dummyMap[index]['title'],
          subtitle: dummyMap[index]['subtitle'],
          details: dummyMap[index]['details'],
          location: dummyMap[index]['location'],
          price: dummyMap[index]['price'],
          isFavorite: dummyMap[index]['isFavorite'],
          imageUrl: dummyMap[index]['imageUrl'],
          rating: dummyMap[index]['rating'],
          onFavorite: () {},
          onTap: () {
            GoRouter.of(context).push('/tour-details');
          },
        );
      },
    );
  }

  Widget _buildCountriesView(BuildContext context) {
    List dummyMap = [
      {
        'destination': '🇯🇵 Japan',
        'imageURL':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNQXkHPjenNtb0rxeCdeb0uFdP1JqBGmFjFDtd3UVMQg&s'
      },
      {
        'destination': '🇫🇷 Paris',
        'imageURL':
            'https://lp-cms-production.imgix.net/2021-05/shutterstockRF_1321418885.jpg?auto=format&fit=crop&ar=1:1&q=75&w=1200'
      },
    ];

    return _buildVerticalList(
      itemCount: dummyMap.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 150,
          child: DestinationCard(
            name: dummyMap[index]['destination'],
            imageUrl: dummyMap[index]['imageURL'],
            onTap: () {
              GoRouter.of(context).push('/tours-in-country');
            },
          ),
        );
      },
    );
  }

  Widget _buildAllView(BuildContext context) {
    List dummyMap = [
      {
        'title': 'Trip to Japan',
        'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'details': '5 days · 4 nights',
        'location': 'Japan',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 5.0,
      },
      {
        'title': 'Trip to Paris',
        'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'details': '5 days · 4 nights',
        'location': 'Paris',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 4.8,
      },
    ];

    return _buildVerticalList(
      itemCount: dummyMap.length,
      itemBuilder: (context, index) {
        return TourCardWide(
          title: dummyMap[index]['title'],
          subtitle: dummyMap[index]['subtitle'],
          details: dummyMap[index]['details'],
          location: dummyMap[index]['location'],
          price: dummyMap[index]['price'],
          isFavorite: dummyMap[index]['isFavorite'],
          imageUrl: dummyMap[index]['imageUrl'],
          rating: dummyMap[index]['rating'],
          onFavorite: () {},
          onTap: () {
            GoRouter.of(context).push('/tour-details');
          },
        );
      },
    );
  }

  Widget _buildRecommended(BuildContext context) {
    List dummyMap = [
      {
        'title': 'Trip to Japan',
        'subtitle': '5 days · 4 nights',
        'location': 'Japan',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 5.0,
      },
      {
        'title': 'Trip to Paris',
        'subtitle': '5 days · 4 nights',
        'location': 'Paris',
        'price': '₱50,000 / pax',
        'isFavorite': false,
        'imageUrl': 'https://placehold.co/600x400/png',
        'rating': 4.8,
      },
    ];

    return _buildSection(
      context,
      title: 'Recommended tours',
      child: _buildHorizontalList(
        height: 311.0,
        itemCount: dummyMap.length,
        itemBuilder: (context, index) {
          return TourCard(
            title: dummyMap[index]['title'],
            subtitle: dummyMap[index]['subtitle'],
            location: dummyMap[index]['location'],
            price: dummyMap[index]['price'],
            isFavorite: dummyMap[index]['isFavorite'],
            imageUrl: dummyMap[index]['imageUrl'],
            rating: dummyMap[index]['rating'],
            onFavorite: () {},
            onTap: () {
              GoRouter.of(context).push('/tour-details');
            },
          );
        },
      ),
    );
  }

  Widget _buildPopular(BuildContext context) {
    List dummyMap = [
      {
        'destination': '🇯🇵 Japan',
        'imageURL':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNQXkHPjenNtb0rxeCdeb0uFdP1JqBGmFjFDtd3UVMQg&s'
      },
      {
        'destination': '🇫🇷 Paris',
        'imageURL':
            'https://lp-cms-production.imgix.net/2021-05/shutterstockRF_1321418885.jpg?auto=format&fit=crop&ar=1:1&q=75&w=1200'
      },
    ];

    return _buildSection(
      context,
      title: 'Popular destinations',
      child: _buildHorizontalList(
        height: 200,
        itemCount: dummyMap.length,
        itemBuilder: (context, index) {
          return DestinationCard(
            name: dummyMap[index]['destination'],
            imageUrl: dummyMap[index]['imageURL'],
            onTap: () {
              GoRouter.of(context).push('/tours-in-country');
            },
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(height: kDefaultSpace * 0.5),
        child,
      ],
    );
  }

  Widget _buildHorizontalList({
    required Function(BuildContext, int) itemBuilder,
    required int itemCount,
    required double height,
  }) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) {
          return SizedBox(width: kDefaultSpace * 0.5);
        },
        itemBuilder: (context, index) => itemBuilder(context, index),
      ),
    );
  }

  Widget _buildVerticalList({
    required Function(BuildContext, int) itemBuilder,
    required int itemCount,
  }) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        return SizedBox(width: kDefaultSpace * 0.5);
      },
      itemBuilder: (context, index) => itemBuilder(context, index),
    );
  }
}
