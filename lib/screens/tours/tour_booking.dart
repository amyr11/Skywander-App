import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:skywander_app/styles.dart';
import 'package:skywander_app/widgets/itenerary.dart';

class TourBookingScreen extends StatefulWidget {
  const TourBookingScreen({super.key});

  @override
  State<TourBookingScreen> createState() => _TourBookingScreenState();
}

class _TourBookingScreenState extends State<TourBookingScreen> {
  String overviewMarkdown = '''
# Overview
- **Tour Name:** Daebak Korea
- **Destination:** South Korea
''';
  List availableDates = [
    {
      'start_date': '2022-12-01',
      'end_date': '2022-12-10',
      'additional_fee': 0,
    },
    {
      'start_date': '2022-12-15',
      'end_date': '2022-12-24',
      'additional_fee': 0,
    },
    {
      'start_date': '2022-12-25',
      'end_date': '2023-01-03',
      'additional_fee': 100,
    },
  ];
  late dynamic selectedDate;
  late dynamic _selectedPaymentMethod;
  List itineraries = [
    {
      'day': 'DAY 1',
      'description': 'Check in at Samwon Plaza Hotel',
      'meals': ['breakfast', 'lunch', 'dinner'],
      'imageURL': 'https://placehold.co/600x300/png',
      'details': '''
- Arrive the airport, meet the tour guide
- Transfer to Chuncheon
- Nami Island with ferry ride
- Petite France, Italian Village
- Transfer to Seoul
- Seokchon Lake (cherry blossom)
- Transfer to hotel and check in
ETA: 5J186 MNL-ICN 0250-0805
          ''',
    },
  ];
  double basePrice = 10000;
  double additionalFee = 0;
  List<String> _selectedFileNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = availableDates[0];
    _selectedPaymentMethod = 'cash';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kDefaultSpace),
          child: Column(
            children: [
              _buildSelectedTour(
                context,
                imageURL: 'https://placehold.co/200x50/png',
                title: 'Daebak Korea',
                from: 'Manila',
                to: 'South Korea',
              ),
              SizedBox(height: kDefaultSpace),
              _buildSelectAvailableDates(
                context,
                availableDates: availableDates,
              ),
              SizedBox(height: kDefaultSpace),
              _buildUploadPassports(context),
              SizedBox(height: kDefaultSpace),
              _buildOverview(
                context,
                overview: overviewMarkdown,
              ),
              SizedBox(height: kDefaultSpace),
              _buildItinerary(
                context,
                itineraries: itineraries,
              ),
              SizedBox(height: kDefaultSpace),
              _buildPriceBreakdown(
                context,
                base: basePrice,
                additional: additionalFee,
              ),
              SizedBox(height: kDefaultSpace),
              _buildPaymentMethod(context),
              SizedBox(height: kDefaultSpace),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: kDefaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: \$${(basePrice + additionalFee).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Payment Method: ${_selectedPaymentMethod.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 116, 115, 115),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Only show the pay button if a file is uploaded
            Padding(
              padding: EdgeInsets.only(right: kDefaultSpace),
              child: ElevatedButton(
                onPressed: _selectedFileNames.isNotEmpty ? _uploadFiles : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                ),
                child: Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadFiles() {}

  Widget _buildPaymentMethod(BuildContext context) {
    return CustomExpansionTile(
      title: 'Payment Method',
      child: Column(
        children: [
          RadioListTile(
            value: 'cash',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value.toString();
              });
            },
            title: Text('Cash'),
          ),
          RadioListTile(
            value: 'gcash',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value.toString();
              });
            },
            title: Text('GCash'),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(
    BuildContext context, {
    required double base,
    required double additional,
  }) {
    return CustomExpansionTile(
      title: 'Price Breakdown',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Base Price'),
              Text('\$${base.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Additional Fee'),
              Text('\$${additional.toStringAsFixed(2)}'),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${(base + additional).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItinerary(BuildContext context, {required List itineraries}) {
    return CustomExpansionTile(
      title: 'Itinerary',
      child: Column(
        children: itineraries.map((itinerary) {
          return ItineraryDay(
            day: itinerary['day'],
            description: itinerary['description'],
            mealIcons: itinerary['meals'],
            imageURL: itinerary['imageURL'],
            details: itinerary['details'],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOverview(BuildContext context, {required String overview}) {
    return CustomExpansionTile(
      title: 'Overview',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: overview,
          ),
        ],
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        _selectedFileNames.add(result.files.single.name);
      });
    }
  }

  void _deleteFile(String fileName) {
    setState(() {
      _selectedFileNames.remove(fileName);
    });
  }

  Widget _buildUploadPassports(BuildContext context) {
    return CustomExpansionTile(
      title: 'Upload Passport/s',
      child: Column(
        children: [
          // Display chosen file with CANCEL button
          if (_selectedFileNames.isNotEmpty) ...[
            for (String fileName in _selectedFileNames)
              Card(
                color: Color.fromARGB(193, 253, 253, 253),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf, color: Colors.red, size: 32.0),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          fileName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          _deleteFile(fileName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],

          // show/hide "Upload a file" container
          // Upload a file container
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.black, size: 32.0),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Upload passport here\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: '(Image file type only)',
                              style: TextStyle(
                                color: Color.fromARGB(255, 116, 115, 115),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _pickFile,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 1.0),
                        ),
                        child: Text('Choose a file'),
                      ),
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

  Widget _buildSelectAvailableDates(
    BuildContext context, {
    required List availableDates,
  }) {
    return CustomExpansionTile(
      title: 'Select Available Dates',
      child: Column(
        children: availableDates.map((date) {
          return RadioListTile(
            title: Text(
              '${date['start_date']} - ${date['end_date']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: date['additional_fee'] == 0
                ? null
                : Text(
                    'Additional fee: \$${date['additional_fee']}',
                  ),
            value: date,
            groupValue: selectedDate,
            onChanged: (value) {
              setState(() {
                selectedDate = value;
                additionalFee = value['additional_fee'].toDouble();
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectedTour(
    BuildContext context, {
    required String imageURL,
    required String title,
    required String from,
    required String to,
  }) {
    return CustomExpansionTile(
      title: 'Selected Tour',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 50,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: kDefaultSpace),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      from,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.flight_takeoff,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      to,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets? padding;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(193, 253, 253, 253),
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: padding == null
                  ? EdgeInsets.only(
                      left: kDefaultSpace,
                      right: kDefaultSpace,
                      bottom: kDefaultSpace,
                    )
                  : padding!,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
