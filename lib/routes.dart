import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/constants.dart';
import 'package:skywander_app/screens/app.dart';
import 'package:skywander_app/screens/onboarding.dart';
import 'package:skywander_app/screens/settings/settings.dart';

/*
This file contains all the routes used in the app. You can add more routes here and delete the /sample route.
*/

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
        redirect: (context, state) => FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/onboarding',
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
    )
  ],
);
