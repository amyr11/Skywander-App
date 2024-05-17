import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/itenerary.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TourDetailsScreen extends StatefulWidget {
  const TourDetailsScreen({super.key});

  @override
  _TourDetailsScreenState createState() => _TourDetailsScreenState();
}

class _TourDetailsScreenState extends State<TourDetailsScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<Map<String, String>> _fetchTourDetails() async {
    return {
      'inclusions': '''
- 4 nights room accommodation with daily hotel breakfast on twin sharing.
- Sightseeing tours as specified included all entrance fees needed.
- Private coach with English speaking tour guide.
- Meals as listed.
- Roundtrip airfare via Cebu Pacific (7kg hand carry only).
- Korea group E-Visa.
      ''',
      'exclusions': '''
- Expenses of a personal nature like telephone calls, mini bars, etc.
- Tips for driver/guide: Php 1,200 per pax.
- Philippine travel tax: Php 1,620 per pax.
- Single supplement.
- Travel insurance.
- Covid related procedures.
- Extra baggage allowance.
- Korea visa.
      ''',
    };
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tour Details'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, String>>(
          future: _fetchTourDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading tour details'));
            } else {
              final tourDetails = snapshot.data!;
              return SingleChildScrollView(
                padding: EdgeInsets.all(0), // Remove padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TourImageCarousel(),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Daebak Korea',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 8.0),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 2.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFAE9F84),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.white,
                                                size: 16.0),
                                            SizedBox(width: 4.0),
                                            Text(
                                              '4.5',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Manila - Seoul 4D 4N Tour',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'from',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[700]),
                                  ),
                                  Text(
                                    'P 33,999',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '/ all in per person',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 0.0),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(text: 'Overview'),
                              Tab(text: 'Itinerary'),
                              // Tab(text: 'Hotel'),
                              // Tab(text: 'Reviews'),
                            ],
                          ),
                          SizedBox(
                            height:
                                500.0, // Set an appropriate height for the TabBarView
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildOverviewTab(tourDetails),
                                _buildItineraryTab(),
                                // _buildHotelDetailsTab(),
                                // _buildReviewsTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildOverviewTab(Map<String, String> tourDetails) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0), // Remove padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Dates',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'March 23 - 27 (+3000 per pax)\n'
                  'March 30 - April 03\n'
                  'March 31 - April 04\n'
                  'April 01 - April 05',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Tour Inclusions',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                MarkdownBody(data: tourDetails['inclusions'] ?? ''),
                SizedBox(height: 16.0),
                Text(
                  'Tour Exclusions',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                MarkdownBody(data: tourDetails['exclusions'] ?? ''),
                SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFAE9F84)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0)),
                    ),
                    onPressed: () {
                      GoRouter.of(context).push('/tour-booking');
                    },
                    child: Text('Book Now',
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItineraryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItineraryDay(
            day: 'DAY 1',
            description: 'Check in at Samwon Plaza Hotel',
            mealIcons: ['breakfast', 'lunch', 'dinner'],
            imageURL: 'https://placehold.co/600x300/png',
            details: '''
- Arrive the airport, meet the tour guide
- Transfer to Chuncheon
- Nami Island with ferry ride
- Petite France, Italian Village
- Transfer to Seoul
- Seokchon Lake (cherry blossom)
- Transfer to hotel and check in
ETA: 5J186 MNL-ICN 0250-0805
          ''',
          ),
          ItineraryDay(
            day: 'DAY 2',
            description: 'Check in at Golden City Hotel Dongdaemun or similar',
            mealIcons: ['breakfast', 'lunch', 'dinner'],
            imageURL: 'https://placehold.co/600x300/png',
            details: '''
- Everland Theme Park
- Coex Starfield Library
- Kpop Road
- Cosmetic Outlet
- Transfer to hotel and check in.
          ''',
          ),
          ItineraryDay(
            day: 'DAY 3',
            description: 'Check in at Golden City Hotel Dongdaemun or similar',
            mealIcons: ['breakfast', 'lunch', 'dinner'],
            imageURL: 'https://placehold.co/600x300/png',
            details: '''
- Blue House (pass by)
- Gyeongbokgung Palace (cherry blossom)
- National Folk Museum
- Ginseng Gallery, Red Pine Gallery
- NSeoul Tower by Public E-V shuttle Bus (exclude lift)
- Lotte Duty Free
- Patisser’s Shop
- Free shopping at Myeongdong Street.
- Transfer back to hotel.
          ''',
          ),
          ItineraryDay(
            day: 'DAY 4',
            description: 'Check in at Golden City Hotel Dongdaemun or similar',
            mealIcons: ['breakfast', 'lunch', 'dinner'],
            imageURL: 'https://placehold.co/600x300/png',
            details: '''
- Hanbok wearing experience at Seaweed Museum
- Free time for shopping at Hongdae
- Transfer to Incheon airport for flight back to Manila
ETA: 5J187 ICN-MNL 0040-0400
          ''',
          ),
          SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFAE9F84)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
              ),
              onPressed: () {
                GoRouter.of(context).push('/tour-booking');
              },
              child: Text('Book Now',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hotel details go here',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFAE9F84)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
              ),
              onPressed: () {
                GoRouter.of(context).push('/tour-booking');
              },
              child: Text('Book Now',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews go here',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFAE9F84)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
              ),
              onPressed: () {
                GoRouter.of(context).push('/tour-booking');
              },
              child: Text('Book Now',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class TourImageCarousel extends StatefulWidget {
  @override
  _TourImageCarouselState createState() => _TourImageCarouselState();
}

class _TourImageCarouselState extends State<TourImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0, // Height of the carousel
            enlargeCenterPage: true,
            viewportFraction: 0.9, // Adjust this value to control the gap
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: [
            'assets/images/korea1.jpg',
            'assets/images/korea2.jpg', // Add more image paths as needed
            'assets/images/korea3.jpg',
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0), // Control the gap between images
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20.0), // Round the edges of the image
                    child: Image.asset(
                      i,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width, // Full width
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 8.0),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: 3, // Number of images
          effect: ScrollingDotsEffect(
            activeDotColor: Color(0xFFAE9F84),
            dotHeight: 12,
            dotWidth: 12,
          ),
        ),
      ],
    );
  }
}
