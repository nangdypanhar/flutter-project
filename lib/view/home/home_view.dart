import 'package:flutter/material.dart';
import 'package:flutter_project/view/participant/participant_view.dart';
import 'package:flutter_project/view/result/result_view.dart';
import 'package:flutter_project/view/participant_tracker/participant_tracker_view.dart';
import 'package:flutter_project/view/time_tracker/time_tracker_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static final List<String> _titles = [
    'Participants',
    'Time Tracker',
    'Participant Tracker',
    'Result',
  ];

  static final List<Widget> _screens = [
    ParticipantView(),
    TimeTrackerView(),
    ParticipantTrackerView(),
    ResultView(),
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(height: 1.0, color: const Color(0xFFD1D1D6)),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Participants",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search),
            label: "Tracker",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: "Result",
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
