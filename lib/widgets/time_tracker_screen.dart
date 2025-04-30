import 'package:flutter/material.dart';
import 'package:flutter_project/timer_service.dart';
import 'package:flutter_project/widgets/start_timer_page.dart';

class ParticipantProgressScreen extends StatefulWidget {
  const ParticipantProgressScreen({super.key});

  @override
  State<ParticipantProgressScreen> createState() =>
      _ParticipantProgressScreenState();
}

class _ParticipantProgressScreenState extends State<ParticipantProgressScreen> {
  final Map<String, Duration> stageTimestamps = {};

  void _recordStage(String stage) {
    final current = TimerService().elapsed.value;
    setState(() {
      stageTimestamps[stage] = current;
    });
  }

  Widget _buildStageRow(String stage) {
    final time = stageTimestamps[stage];
    return ListTile(
      title: Text(stage),
      trailing: Text(
        time != null
            ? formatDuration(time)
            : "--:--:--:--",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Participant Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Live timer at the top
            ValueListenableBuilder<Duration>(
              valueListenable: TimerService().elapsed,
              builder: (context, duration, child) {
                return Text(
                  formatDuration(duration),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Progress recording buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                    onPressed: () => _recordStage("Swim End"),
                    child: const Text("Finish Swimming")),
                ElevatedButton(
                    onPressed: () => _recordStage("Cycle Start"),
                    child: const Text("Start Cycling")),
                ElevatedButton(
                    onPressed: () => _recordStage("Cycle End"),
                    child: const Text("End Cycling")),
                ElevatedButton(
                    onPressed: () => _recordStage("Run Start"),
                    child: const Text("Start Running")),
                ElevatedButton(
                    onPressed: () => _recordStage("Run End"),
                    child: const Text("End Running")),
              ],
            ),
            const SizedBox(height: 20),
            // Display timestamps
            Expanded(
              child: ListView(
                children: [
                  _buildStageRow("Swim End"),
                  _buildStageRow("Cycle Start"),
                  _buildStageRow("Cycle End"),
                  _buildStageRow("Run Start"),
                  _buildStageRow("Run End"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
