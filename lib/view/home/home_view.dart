import 'package:flutter/material.dart';
import 'package:flutter_project/view/participant/participant_view.dart';
import 'package:flutter_project/view/result/result_view.dart';
import 'package:flutter_project/view/time_stater/time_starter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static final List<String> _title = ['Participants', 'Time Tracker', 'Result'];
  static final List<Widget> _widgetOptions = [
    ParticipantView(),
    TimeStarter(),
    ResultView(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_selectedIndex]),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Color(0xFFD1D1D6), height: 1.0),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Participants",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: "Time Tracker",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Result",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
