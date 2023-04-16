import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usersupervisor/login.dart';
import 'package:url_launcher/url_launcher.dart';

class SupervisorPage extends StatefulWidget {
  const SupervisorPage({super.key});

  @override
  State<SupervisorPage> createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supervisor"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      // list of users in the database with the navigation icon when clicked will open the map with the user's location
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'User')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['address']),
                      Text(user['phone']),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      launch(
                          'https://www.google.com/maps/search/?api=1&query=${user['latitude']},${user['longitude']}');
                    },
                    icon: Icon(
                      Icons.navigation,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
