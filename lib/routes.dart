import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/constants.dart';
import 'package:skywander_app/styles.dart';

/*
This file contains all the routes used in the app. You can add more routes here and delete the /sample route.
*/

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(
        providers: [
          EmailAuthProvider(),
          GoogleProvider(clientId: GOOGLE_CLIENT_ID),
        ],
        actions: [
          AuthStateChangeAction<SignedIn>((context, _) {
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
        builder: (context, state) => ProfileScreen(
              actions: [
                SignedOutAction((context) {
                  GoRouter.of(context).pushReplacement("/");
                }),
              ],
            )),
  ],
);
