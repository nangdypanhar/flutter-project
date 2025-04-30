
import 'package:flutter/material.dart';
import 'package:flutter_project/timer_service.dart';

/// Helper function to convert a Duration to HH:MM:SS:CS format.
String formatDuration(Duration duration) {
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes % 60;
  final int seconds = duration.inSeconds % 60;
  // Calculate centiseconds (1 centisecond = 10 milliseconds)
  final int centiseconds = (duration.inMilliseconds ~/ 10) % 100;
  return '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}:'
      '${centiseconds.toString().padLeft(2, '0')}';
}

class StartTimerScreen extends StatefulWidget {
  const StartTimerScreen({super.key});

  @override
  State<StartTimerScreen> createState() => _StartTimerScreenState();
}

class _StartTimerScreenState extends State<StartTimerScreen> {
  // Local variable to track if the timer is paused (for toggling the button text).
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Timer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            tooltip: "Stop Race",
            onPressed: () {
              TimerService().stop();
              setState(() {
                isPaused = false;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the timer using a ValueListenableBuilder.
              ValueListenableBuilder<Duration>(
                valueListenable: TimerService().elapsed,
                builder: (context, duration, child) {
                  return Text(
                    formatDuration(duration),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  TimerService().start();
                  setState(() {
                    isPaused = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "Tap here to start All Participants",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (TimerService().isRunning) {
                        TimerService().pause();
                        setState(() {
                          isPaused = true;
                        });
                      } else {
                        if (TimerService().elapsed.value > Duration.zero) {
                          TimerService().resume();
                          setState(() {
                            isPaused = false;
                          });
                        }
                      }
                    },
                    child: Text(TimerService().isRunning ? "Pause" : "Resume"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      TimerService().reset();
                      setState(() {
                        isPaused = false;
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
