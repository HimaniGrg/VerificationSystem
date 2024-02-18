import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

class DashboardPageScreen extends StatefulWidget {
  const DashboardPageScreen({super.key});

  @override
  State<DashboardPageScreen> createState() => _DashboardPageScreenState();
}

class _DashboardPageScreenState extends State<DashboardPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('Welcome to the Dashboard'),
                subtitle: Text('Explore the features below.'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('Profile'),
                subtitle: Text('View and edit your profile.'),
                leading: Icon(Icons.person),
                onTap: () {
                  // Navigate to the profile page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('Notifications'),
                subtitle: Text('Check your notifications.'),
                leading: Icon(Icons.notifications),
                onTap: () {
                  // Navigate to the notifications page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
                },
              ),
            ),
            Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('Verification'),
                subtitle: Text('Start your document verification.'),
                leading: Icon(Icons.checklist),
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.startVerificationScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
