import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/service/timer_service.dart';

class ParticipantTracker extends StatefulWidget {
  const ParticipantTracker({super.key});

  @override
  State<ParticipantTracker> createState() =>
      _ParticipantTrackerState();
}

class _ParticipantTrackerState extends State<ParticipantTracker> {
  final Map<String, Duration> stageTimestamps = {};
  String currentSegment = "Swimming";
  String? selectedParticipant;

  void _recordStage(String segment) {
    if (selectedParticipant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a participant first")),
      );
      return;
    }

    final current = TimerService().elapsed.value;

    setState(() {
      currentSegment = segment;
      stageTimestamps["${segment} End"] = current;
    });
  }

  // Inside _ParticipantTrackerState:

  // Function to get the text style for each segment based on the current selection
  TextStyle _getSegmentTextStyle(String segment) {
    return currentSegment == segment
        ? const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
        : const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.white60,
        );
  }

  // Updated segment button factory:
  Widget _segmentButton(String label, Color color, VoidCallback onPressed) {
    final bool isSelected = label == currentSegment;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? color.withOpacity(1.0) : color.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding:
            isSelected
                ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)
                : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
      onPressed: onPressed,
      child: Text(label, style: _getSegmentTextStyle(label)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Timer",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<Duration>(
            valueListenable: TimerService().elapsed,
            builder: (context, duration, child) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer, color: Colors.white, size: 36),
                      const SizedBox(width: 8),
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Segment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _segmentButton(
                "Swimming",
                Colors.green.shade300,
                () => _recordStage("Swimming"),
              ),
              const SizedBox(width: 8),
              _segmentButton(
                "Cycling",
                Colors.orange.shade200,
                () => _recordStage("Cycling"),
              ),
              const SizedBox(width: 8),
              _segmentButton(
                "Running",
                Colors.purple.shade200,
                () => _recordStage("Running"),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 16)),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Participants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: 10, // Change to your actual participant count
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final number = index + 1;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123B77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedParticipant = '$number';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$number',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$currentSegment Start',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
