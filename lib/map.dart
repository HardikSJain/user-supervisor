import 'package:flutter/material.dart';

import 'package:usersupervisor/map.dart';
import 'package:usersupervisor/register.dart';
import 'package:usersupervisor/supervisor.dart';
import 'package:usersupervisor/user.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Map"),
          ],
        ),
      ),
    );
  }
}
