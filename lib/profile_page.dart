import 'package:flutter/material.dart';

// REPLACE THESE PLACEHOLDERS with your own information:
//   YOUR STUDENT ID  -> your actual student ID
//   YOUR EMAIL       -> your actual email address
const String studentName = 'Angelo Ranes';
const String studentId = '534229';
const String studentCourse = 'BSIT';
const String studentSection = 'CCE106L(3450)';
const String studentEmail = 'a.ranes.534229@umindanao.edu.ph';

// The profile page showing the student's information.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            studentName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('Student ID'),
                  subtitle: Text(studentId),
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Course and Section'),
                  subtitle: Text('$studentCourse — $studentSection'),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(studentEmail),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
