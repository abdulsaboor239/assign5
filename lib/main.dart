import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Fruit List/Date_screen.dart';
import 'Fruit List/Honeydrew_screen.dart';
import 'Fruit List/apple_screen.dart';
import 'Fruit List/banana_screen.dart';
import 'Fruit List/coconut_screen.dart';
import 'Fruit List/grapes_screen.dart';
import 'Fruit List/jackfruit_screen.dart';
import 'Fruit List/kiwi_screen.dart';
import 'Fruit List/oranges_screen.dart';
import 'Fruit List/watermelon_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    'Apple',
    'Banana',
    'Coconut',
    'Date',
    'Kiwi',
    'Oranges',
    'Grape',
    'Honeydew',
    'Watermelon',
    'Jackfruit'
  ];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      items = (prefs.getStringList('items') ?? items);
    });
  }

  void _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', items);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Items saved successfully!'),
      ),
    );
  }

  void _navigateToDetail(String fruit, BuildContext context) {
    Widget screen;
    switch (fruit) {
      case 'Apple':
        screen = AppleScreen();
        break;
      case 'Banana':
        screen = BananaScreen();
        break;
      case 'Coconut':
        screen = CoconutScreen();
        break;
      case 'Grape':
        screen = GrapesScreen();
        break;
      case 'Date':
        screen = DateScreen();
        break;
      case 'Jackfruit':
        screen = JackfruitScreen();
        break;
      case 'Kiwi':
        screen = KiwiScreen();
        break;
      case 'Oranges':
        screen = OrangesScreen();
        break;
      case 'Honeydew':
        screen = HoneydrewScreen();
        break;
      case 'Watermelon':
        screen = WatermelonScreen();
        break;
      default:
        screen = Scaffold(
          body: Center(child: Text('No details available')),
        );
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Fruits'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.rotationX(0),
            child: GestureDetector(
              onTap: () {
                _navigateToDetail(items[index], context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  items[index],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveItems,
        tooltip: 'Save Items',
        child: Icon(Icons.save),
      ),
    );
  }
}
