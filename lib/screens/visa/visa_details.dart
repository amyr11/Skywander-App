import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class VisaDetailsScreen extends StatelessWidget {
  const VisaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example markdown content for demonstration
    // In a real application, you would fetch this content from a backend service like Firebase
    const String touristVisaMarkdown = ('''
# Tourist Visa
A tourist visa is your passport to adventure and exploration in a foreign land. It's a key that unlocks the doors to new experiences, cultures, and sights waiting to be discovered. With a tourist visa, you're granted permission to temporarily visit another country for leisure, sightseeing, or simply soaking up the local vibes. Immerse yourself in new landscapes, taste exotic cuisines, and make unforgettable memories. So, whether you're planning a solo journey of self-discovery or embarking on a family escapade, a tourist visa is your ticket to embark on the journey of a lifetime. Go ahead, pack your bags, and let the world become your playground!
''');

    const String requirementsMarkdown = ('''
## Requirements
- Accomplished Tourist Visa Application Form
- 1 pc of passport size colored picture
- Passport (Original and Photocopy)
- PSA Birth Certificate
- Marriage Certificate (if married)
- Certification of Employment
- Income Tax Return (ITR)
- Bank Certificate
''');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Japan',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network('https://placehold.co/600x300/png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarkdownBody(data: touristVisaMarkdown),
                  const SizedBox(height: 16),
                  MarkdownBody(data: requirementsMarkdown),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => GoRouter.of(context).push('/visa-application'),
          style: ElevatedButton.styleFrom(
            backgroundColor: getTheme().colorScheme.tertiary,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: const Text(
            'Request Visa',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white, // Changes text color to white
            ),
          ),
        ),
      ),
    );
  }
}
