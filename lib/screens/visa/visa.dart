import 'package:flutter/material.dart';
import 'package:skywander_app/widgets/visa_countries.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  final List<Map<String, String>> countries = [
    {'name': 'Australia', 'image': 'assets/images/australia.jpg'},
    {'name': 'Canada', 'image': 'assets/images/canada.jpg'},
    {'name': 'Japan', 'image': 'assets/images/japan.jpg'},
    {'name': 'South Korea', 'image': 'assets/images/south_korea.jpg'},
    {'name': 'China', 'image': 'assets/images/china.jpg'},
  ];
  List<Map<String, String>> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = countries;
    searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    setState(() {
      filteredCountries = countries
          .where((country) => country['name']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for places...',
                  prefixIcon: Icon(Icons.menu),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xffBDB7A5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey.shade700,
                    ),
                  ),
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
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return VisaCountryCard(
                    countryName: country['name']!,
                    imagePath: country['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
