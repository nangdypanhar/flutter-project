import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/participant_content.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Swimming Event", style: TextStyle(color: Colors.black)),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: 22),

            tabs: [
              Tab(child: Text("Race", style: TextStyle(fontSize: 15))), // replace this with race_content
              Tab(child: Text("Timer", style: TextStyle(fontSize: 15))), // replace this with time_content
              Tab(child: Text("Participants", style: TextStyle(fontSize: 15))),
              Tab(child: Text("Result", style: TextStyle(fontSize: 15))),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("This is the event overview")),
            Center(child: Text("List of participants goes here")),
            ParticipantContent(),
            Center(child: Text("Another Participants view")),
          ],
        ),
      ),
    );
  }
}
