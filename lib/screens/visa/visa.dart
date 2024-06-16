import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/models/destination.dart';
import 'package:skywander_app/models/visa.dart';
import 'package:skywander_app/services/database/firestore_service.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/destination_card.dart';
import 'package:skywander_app/widgets/visa_countries.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({super.key});

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  List<Map<dynamic, dynamic>> filteredCountries = [];
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Application'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getVisaCountries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred. Please try again later.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> visaCountriesDocs =
                    snapshot.data?.docs ?? [];

                if (visaCountriesDocs.isEmpty) {
                  return const Center(
                    child: Text('No countries found.'),
                  );
                }

                return ListView.builder(
                  itemCount: visaCountriesDocs.length,
                  itemBuilder: (context, index) {
                    Visa visaCountry = visaCountriesDocs[index].data() as Visa;

                    return FutureBuilder<QuerySnapshot>(
                      future: _firestoreService
                          .getDestinationFromReference(
                            visaCountry.destination,
                          )
                          .first,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                'An error occurred. Please try again later.'),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<DocumentSnapshot> destinationDocs =
                            snapshot.data?.docs ?? [];

                        if (destinationDocs.isEmpty) {
                          return const Center(
                            child: Text('No destinations found.'),
                          );
                        }

                        Destination destination =
                            snapshot.data!.docs.first.data() as Destination;

                        return DestinationCard(
                          name: destination.name,
                          imageUrl: destination.image,
                          onTap: () {
                            GoRouter.of(context).push(
                              '/visa-details',
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
