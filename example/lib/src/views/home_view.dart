import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CameraX'),
      ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(40.0),
      //     child: Text(
      //       'Click the camera button at bottom to start scan:)',
      //       style: TextStyle(fontSize: 20.0),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Container(
          width: 200.0,
          height: 100.0,
          color: Colors.amber,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.of(context).pushNamed('analyze'),
        child: Icon(
          Icons.camera,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
