import 'package:flutter/material.dart';
import 'package:skywander_app/styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _xPositionOrange = 0;
  double _yPositionOrange = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNeutralVariant95,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: _xPositionOrange,
              top: _yPositionOrange,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _xPositionOrange += details.delta.dx;
                    _yPositionOrange += details.delta.dy;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  color: kLightPrimaryContainer,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 0),
                const SizedBox(height: 90),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Sky W. Ander',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Traveler',
                        style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Fueled by love and passion for traveling!',
                        style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    'ACCOUNT SETTINGS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      color: kNeutral22,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildButtonRow(
                        icon: Icons.lock,
                        title: 'Change Password',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 0),
                      _buildButtonRow(
                        icon: Icons.person,
                        title: 'Update My Details',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    'SYSTEM SETTINGS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      color: kNeutral22,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildButtonRow(
                        icon: Icons.payment,
                        title: 'Change Payment Method',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 0),
                      _buildButtonRow(
                        icon: Icons.help,
                        title: 'FAQS',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                _buildButtonRow(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onPressed: () {
                    // Implement log out functionality here
                  },
                  iconColor: kLightOnPrimaryContainer,
                  labelColor: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width - 68) / 2,
              top: 64,
              child: const CircleAvatar(
                radius: 34,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow({required IconData icon, required String title, required VoidCallback onPressed, Color? iconColor, Color? labelColor}) {
    return Padding(
      padding: title != 'Log Out' ? const EdgeInsets.only(bottom: 10) : const EdgeInsets.only(bottom: 10, left: 70), // Add additional padding for "Log Out" button
      child: title != 'Log Out' ? ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: kLightOnPrimaryContainer),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: labelColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ) : GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.onPrimaryContainer),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
