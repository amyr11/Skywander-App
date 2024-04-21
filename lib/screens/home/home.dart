import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildHeader(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String name = 'John';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultSpace),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: kDefaultSpace),
            child: CircleAvatar(
              radius: 24,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: kLabelSmallSecondary,
              ),
              Text(
                name,
                style: kLabelLarge,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => GoRouter.of(context).push('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
