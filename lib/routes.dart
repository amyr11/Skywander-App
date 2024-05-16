import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/screens/app.dart';
import 'package:skywander_app/screens/home/tour_result.dart';
import 'package:skywander_app/screens/home/tour_filter.dart';
import 'package:skywander_app/screens/onboarding.dart';
import 'package:skywander_app/screens/payments/select_mode_of_payment.dart';
import 'package:skywander_app/screens/settings/change_details.dart';
import 'package:skywander_app/screens/settings/change_password.dart';
import 'package:skywander_app/screens/settings/faq.dart';
import 'package:skywander_app/screens/settings/settings.dart';
import 'package:skywander_app/screens/home/tours_in_country.dart';
import 'package:skywander_app/screens/tours/tour_details.dart';
import 'package:skywander_app/screens/visa/visa.dart';
import 'package:skywander_app/screens/visa/visa_details.dart';

/*
This file contains all the routes used in the app. You can add more routes here and delete the /sample route.
*/

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) => FirebaseAuth.instance.currentUser == null
          ? '/sign-in'
          : '/onboarding',
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => firebase_ui_auth.SignInScreen(
        actions: [
          firebase_ui_auth.AuthStateChangeAction<firebase_ui_auth.SignedIn>(
              (context, _) {
            GoRouter.of(context).pushReplacement("/onboarding");
          }),
        ],
        showPasswordVisibilityToggle: true,
        headerBuilder: (context, constraints, _) => Container(
          constraints: constraints,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Center(
            child: Image.asset(
              'assets/images/skywander-logo.png',
              width: constraints.maxWidth * 0.5,
            ),
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/app',
      builder: (context, state) => const AppLayout(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/settings/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/settings/change-details',
      builder: (context, state) => const ChangeDetailsScreen(),
    ),
    GoRoute(
      path: '/settings/select-payment',
      builder: (context, state) => const SelectModeOfPaymentScreen(),
    ),
    GoRoute(
      path: '/settings/faq',
      builder: (context, state) => const FAQScreen(),
    ),
    GoRoute(
      path: '/tours-in-country',
      builder: (context, state) => ToursInCountryScreen(),
    ),
    GoRoute(
      path: '/tour-details',
      builder: (context, state) => TourDetailsScreen(),
    ),
    GoRoute(
      path: '/tour-filter',
      builder: (context, state) => TourFilterScreen(),
    ),
    GoRoute(
        path: '/tour-search-result',
        builder: (context, state) => const TourResultScreen()),
    GoRoute(
      path: '/visa',
      builder: (context, state) => const VisaScreen(),
    ),
    GoRoute(
      path: '/visa-details',
      builder: (context, state) => const VisaDetailsScreen(),
    ),
  ],
);
