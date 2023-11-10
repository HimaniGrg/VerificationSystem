import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:verification_system/Pages/citizenshipupload.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CitizenshipUpload()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
