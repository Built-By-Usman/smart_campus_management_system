import 'package:CampusX/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class AdminSettingScreen extends StatelessWidget {
  const AdminSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// App Info Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("App Name"),
              subtitle: Text("CampusX Admin"),
            ),
          ),

          const SizedBox(height: 12),

          /// App Version (Hardcoded)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.system_update),
              title: Text("App Version"),
              subtitle: Text("1.0.0"),
            ),
          ),

          const SizedBox(height: 12),

          /// Privacy Policy (Static Text Only)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text("Privacy Policy"),
              subtitle: Text("Available in Play Store listing"),
            ),
          ),

          const SizedBox(height: 12),

          /// Developer Info
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text("Developer"),
              subtitle: Text("Built by CampusX Team"),
            ),
          ),

          const SizedBox(height: 30),

          /// Static Footer Text
          Center(
            child: Text(
              "© 2026 CampusX. All rights reserved.",
              style: TextStyle(
                color: AppColor.subHeading,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}