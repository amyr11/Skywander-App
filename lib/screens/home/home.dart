import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/models/destination.dart';
import 'package:skywander_app/models/tour.dart';
import 'package:skywander_app/services/database/firestore_service.dart';
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
  final FirestoreService _firestoreService = FirestoreService();

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
                context, 'Destination', selectedCategory == 'Destination'),
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
      case 'Destination':
        return _buildDestinationsView(context);
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
    return _buildSection(
      context,
      title: 'Latest tours',
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getLatestTours(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading tours'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> tourDocs = snapshot.data?.docs ?? [];
          if (tourDocs.isEmpty) {
            return const Center(
              child: Text('No tours available'),
            );
          }

          return _buildVerticalList(
            itemCount: tourDocs.length,
            itemBuilder: (context, index) {
              Tour tour = tourDocs[index].data() as Tour;

              return TourCardWide(
                title: tour.title,
                subtitle: tour.subtitle,
                details: '${tour.days} days · ${tour.nights} nights',
                location: tour.origin,
                price: '₱${tour.basePrice} / pax',
                isFavorite: false,
                imageUrl: tour.image,
                rating: 5.0,
                onFavorite: () {},
                onTap: () {
                  GoRouter.of(context).push('/tour-details');
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDestinationsView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getDestinations(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading destinations'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> destDocs = snapshot.data?.docs ?? [];
        if (destDocs.isEmpty) {
          return const Center(
            child: Text('No destinations available'),
          );
        }

        return _buildVerticalList(
          itemCount: destDocs.length,
          itemBuilder: (context, index) {
            Destination dest = destDocs[index].data() as Destination;

            return DestinationCard(
              name: dest.name,
              imageUrl: dest.image,
              onTap: () {
                GoRouter.of(context).push('/tours-in-country');
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAllView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getTours(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading tours'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> tourDocs = snapshot.data?.docs ?? [];
        if (tourDocs.isEmpty) {
          return const Center(
            child: Text('No tours available'),
          );
        }

        return _buildVerticalList(
          itemCount: tourDocs.length,
          itemBuilder: (context, index) {
            Tour tour = tourDocs[index].data() as Tour;

            return TourCardWide(
              title: tour.title,
              subtitle: tour.subtitle,
              details: '${tour.days} days · ${tour.nights} nights',
              location: tour.origin,
              price: '₱${tour.basePrice} / pax',
              isFavorite: false,
              imageUrl: tour.image,
              rating: 5.0,
              onFavorite: () {},
              onTap: () {
                GoRouter.of(context).push('/tour-details');
              },
            );
          },
        );
      },
    );
  }

  Widget _buildRecommended(BuildContext context) {
    return _buildSection(
      context,
      title: 'Recommended tours',
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getRecommendedTours(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading tours'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> tourDocs = snapshot.data?.docs ?? [];
          if (tourDocs.isEmpty) {
            return const Center(
              child: Text('No tours available'),
            );
          }

          return _buildHorizontalList(
            height: 311.0,
            itemCount: tourDocs.length,
            itemBuilder: (context, index) {
              Tour tour = tourDocs[index].data() as Tour;

              return FutureBuilder<QuerySnapshot>(
                future: _firestoreService
                    .getDestinationsFromReferences(tour.destinations)
                    .first,
                builder: (context, destSnapshot) {
                  if (destSnapshot.hasError) {
                    return const Center(
                      child: Text('Error loading destinations'),
                    );
                  }

                  if (destSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<DocumentSnapshot> destDocs =
                      destSnapshot.data?.docs ?? [];
                  List<String> destNames =
                      destDocs.map((doc) => doc['name'] as String).toList();

                  return TourCard(
                    title: tour.title,
                    subtitle: tour.subtitle,
                    location: destNames.join(', '),
                    price: '₱${tour.basePrice} / pax',
                    isFavorite: false,
                    imageUrl: tour.image,
                    rating: 5.0,
                    onFavorite: () {},
                    onTap: () {
                      GoRouter.of(context).push('/tour-details');
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPopular(BuildContext context) {
    return _buildSection(
      context,
      title: 'Popular destinations',
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getPopularDestinations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading destinations'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> destDocs = snapshot.data?.docs ?? [];
          if (destDocs.isEmpty) {
            return const Center(
              child: Text('No destinations available'),
            );
          }

          return _buildHorizontalList(
            height: 150.0,
            itemCount: destDocs.length,
            itemBuilder: (context, index) {
              Destination dest = destDocs[index].data() as Destination;

              return DestinationCard(
                name: dest.name,
                imageUrl: dest.image,
                onTap: () {
                  GoRouter.of(context).push('/tours-in-country');
                },
              );
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
