import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentTheme = 0;
  int _currentColor = 0;

  List<Widget> tabs = [];
  List<String> tabsNames = ["Início", "Inventário", "Combate", "Perfil"];

  @override
  void initState() {
    super.initState();
    _currentTheme = 0;
    _currentColor = 0;
    // isUser = Provider.of<LoginProvider>(context, listen: false).userLogged;
    // if (isUser == null) {
    //   Navigator.pop(context);
    // }
    // loadUser();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "João Pedro",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          leading: ClipRRect(
            borderRadius:
                BorderRadius.circular(100.0), // Adjust the radius as needed
            child: Image.asset('assets/img/eu.jpg'),
          )),
      body: const Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}
