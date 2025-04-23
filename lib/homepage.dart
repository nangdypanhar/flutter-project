import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/event_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RaceTracker")),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: EventCard(),
          );
        },
      ),
    );
  }
}
