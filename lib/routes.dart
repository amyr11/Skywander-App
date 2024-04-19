import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/constants.dart';
import 'package:skywander_app/screens/home/home.dart';
import 'package:skywander_app/screens/onboarding.dart';
import 'package:skywander_app/screens/home/tours_in_country.dart';

/*
This file contains all the routes used in the app. You can add more routes here and delete the /sample route.
*/

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
        redirect: (context, state) => FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/onboarding',
      redirect: (context, state) =>
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => firebase_ui_auth.SignInScreen(
        providers: [
          firebase_ui_auth.EmailAuthProvider(),
          GoogleProvider(clientId: GOOGLE_CLIENT_ID),
        ],
        actions: [
          firebase_ui_auth.AuthStateChangeAction<firebase_ui_auth.SignedIn>((context, _) {
            GoRouter.of(context).pushReplacement("/onboarding");
          firebase_ui_auth.AuthStateChangeAction<firebase_ui_auth.SignedIn>(
              (context, _) {
            GoRouter.of(context).pushReplacement("/profile");
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
        path: '/profile',
        builder: (context, state) => firebase_ui_auth.ProfileScreen(
              actions: [
                firebase_ui_auth.SignedOutAction((context) {
                  GoRouter.of(context).pushReplacement("/");
                }),
              ],
            )),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        path: '/tour-tab-tours-in-country',
        builder: (context, state) => ToursInCountryScreen()),
  ],
);
