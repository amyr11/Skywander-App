import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MaterialApp(home: OnboardingScreen()));
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _showSplashScreen = true;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page?.round() ?? 0;
      });
    });
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSplashScreen = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFDDDA),
      body: _showSplashScreen
          ? const SplashPage()
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => OnboardingPage(
                    pageIndex: index,
                    currentPageIndex: _currentPageIndex,
                    pageController: _pageController,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildButtonsRow(context, _currentPageIndex),
                ),
              ],
            ),
    );
  }

  Widget _buildButtonsRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: index < 2
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _skipToLastPage,
                  child: const Text('Skip',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato')),
                ),
                ElevatedButton(
                  onPressed: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFAE9F84)),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(50))),
                  child: const Text('Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato')),
                ),
              ],
            )
          : ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/home');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFAE9F84)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(120, 50))),
              child: const Text('Get Started',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato')),
            ),
    );
  }

  void _skipToLastPage() => _pageController.animateToPage(2,
      duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/skywander-logo.png',
                width: 200, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
                color: Color.fromARGB(255, 136, 129, 129)),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final int pageIndex;
  final int currentPageIndex;
  final PageController pageController;

  const OnboardingPage(
      {Key? key,
      required this.pageIndex,
      required this.currentPageIndex,
      required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFDFDDDA)),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.38),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      child: Image.asset(_getImagePath(pageIndex),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderText(pageIndex),
                        _buildDescriptionText(pageIndex, context),
                        const SizedBox(height: 16),
                        if (pageIndex != 2) _buildPageIndicator(pageIndex),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/Onboarding1.jpg';
      case 1:
        return 'assets/images/Onboarding2.jpg';
      case 2:
        return 'assets/images/Onboarding3.jpg';
      default:
        return '';
    }
  }

  Widget _buildHeaderText(int index) {
    switch (index) {
      case 0:
        return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Avail Tour Packages',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Lato'),
                textAlign: TextAlign.center));
      case 1:
        return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Hassle-Free\nVisa Processing',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Lato'),
                textAlign: TextAlign.center));
      case 2:
        return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Your All-in-One\nTravel Buddy',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Lato'),
                textAlign: TextAlign.center));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDescriptionText(int index, BuildContext context) {
    switch (index) {
      case 0:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                    "Dive into a world of adventure with Sky Wander's extensive selection of tour packages tailored to suit every traveler's desires. From exotic getaways to cultural immersions, we have something for everyone",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7C7B79),
                        fontFamily: 'Lato'))));
      case 1:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                child: const Text(
                    "Say goodbye to the stress of visa applications. With Sky Wander, enjoy smooth and hassle-free visa processing, ensuring that your travel plans are executed seamlessly without any bureaucratic hurdles",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7C7B79),
                        fontFamily: 'Lato'))));
      case 2:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                    "Access everything you need for your journey, from booking flights and accommodations to discovering hidden gems and navigating new destinations—all conveniently in one place",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7C7B79),
                        fontFamily: 'Lato'))));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPageIndicator(int index) {
    if (index == 0) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/plane-w-shadow-icon.png'),
                            fit: BoxFit.cover)))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/dot-icon.png'),
                            fit: BoxFit.cover))))
          ]));
    } else if (index == 1) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/dot-icon.png'),
                            fit: BoxFit.cover)))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/plane-w-shadow-icon.png'),
                            fit: BoxFit.cover))))
          ]));
    } else {
      return const SizedBox.shrink();
    }
  }
}
