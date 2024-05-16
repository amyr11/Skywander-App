import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:skywander_app/styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kNeutralVariant95,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultSpace),
        child: Column(
          children: [
            _buildProfileContainer(context),
            SizedBox(height: kDefaultSpace),
            _buildSection(
              title: 'ACCOUNT',
              child: _buildButtonsContainer(
                children: [
                  _buildButtonRow(
                    onTap: () =>
                        GoRouter.of(context).push('/settings/change-password'),
                    context: context,
                    iconData: Icons.lock_outline,
                    title: 'Change password',
                  ),
                  _buildButtonRow(
                    onTap: () =>
                        GoRouter.of(context).push('/settings/change-details'),
                    context: context,
                    iconData: Icons.person_outline,
                    title: 'Update my details',
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultSpace),
            _buildSection(
              title: 'SYSTEM',
              child: _buildButtonsContainer(
                children: [
                  _buildButtonRow(
                    onTap: () =>
                        GoRouter.of(context).push('/settings/select-payment'),
                    context: context,
                    iconData: Icons.account_balance_wallet_outlined,
                    title: 'Change payment methods',
                  ),
                  _buildButtonRow(
                    onTap: () => GoRouter.of(context).push('/settings/faq'),
                    context: context,
                    iconData: Icons.help_outline,
                    title: 'FAQs',
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultSpace),
            _buildButtonsContainer(
              hasColor: false,
              children: [
                _buildButtonRow(
                  onTap: () {
                    FirebaseUIAuth.signOut(
                      context: context,
                      auth: FirebaseAuth.instance,
                    );
                    GoRouter.of(context).go('/sign-in');
                  },
                  context: context,
                  iconData: Icons.exit_to_app_outlined,
                  showTrailing: false,
                  title: 'Sign out',
                ),
              ],
            ),
            SizedBox(height: kDefaultSpace),
            Text(
              'Made with ❤️ by App Dharma Down',
              style: kLabelExtraSmallSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(kDefaultSpace),
          child: Text(title),
        ),
        child,
      ],
    );
  }

  Widget _buildButtonsContainer({
    required List<Widget> children,
    bool hasColor = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
      child: Material(
        color: !hasColor ? Colors.transparent : null,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(kContainerBorderRadius),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildButtonRow({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required Function() onTap,
    bool showTrailing = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(kDefaultSpace),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: kDefaultSpace),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            showTrailing
                ? Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContainer(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    String imageUrl = user.photoURL ?? 'https://placehold.co/96x96';
    ImageProvider image = NetworkImage(imageUrl);
    String name = user.displayName ?? 'Unknown User';
    DateTime dateJoined = user.metadata.creationTime!;
    List<String> quotes = [
      'Fueled by love and passion for travelling',
      'Travel is the only thing you buy that makes you richer',
      'Travel far enough, you meet yourself',
    ];
    String quote = quotes[DateTime.now().day % quotes.length];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultSpace),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 48.0),
            padding: EdgeInsets.fromLTRB(
                kDefaultSpace, 64.0, kDefaultSpace, kDefaultSpace),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(kContainerBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: kLabelLarge,
                ),
                Text(
                  'Joined in ${dateJoined.year}',
                  textAlign: TextAlign.center,
                  style: kLabelSmallSecondary,
                ),
                SizedBox(height: kDefaultSpace),
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: kLabelSmallSecondary.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundImage: image,
              radius: 48,
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}
