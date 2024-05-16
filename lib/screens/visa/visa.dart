import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/destination_card.dart';
import 'package:skywander_app/widgets/visa_countries.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  List<Map<String, String>> dummyMap = [
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

  List<Map<String, String>> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = dummyMap;
    searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    setState(() {
      filteredCountries = dummyMap
          .where((country) => country['destination']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Application'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: kDefaultSpace),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for countries',
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: kDefaultSpace),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                return SizedBox(
                  height: 150,
                  child: DestinationCard(
                    name: country['destination']!,
                    imageUrl: country['imageURL']!,
                    onTap: () {
                      GoRouter.of(context).push('/visa-details');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
