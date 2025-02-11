import 'package:admin_english_app/utils/local_storage.dart';
import 'package:admin_english_app/view/add_video_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedIndex;
  List<Widget> listPage = <Widget>[
    const AddVideoScreen(),
    const Text("Home")
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin English App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await logout();
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: const Text('Go to the next page'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Course'),
              selected: selectedIndex == 0,
              onTap: () {
                onItemTapped(0);
                Navigator.pushNamed(context, '/add-video');
              },
            ),
            ListTile(
              title: const Text('Add Course'),
              selected: selectedIndex == 1,
              onTap: () {
                onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
