import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/service/timer_service.dart';
import 'package:flutter_project/view/time_tracker/local_widget/tm_button.dart';

class TimeTrackerView extends StatefulWidget {
  const TimeTrackerView({super.key});

  @override
  State<TimeTrackerView> createState() => _TimeTrackerViewState();
}

class _TimeTrackerViewState extends State<TimeTrackerView> {
  final TimerService _timerService = TimerService();

  bool get isStarted => _timerService.elapsed.value > Duration.zero;

  String get _pauseResumeLabel {
    if (_timerService.isRunning) return "Pause";
    return isStarted ? "Resume" : "Pause";
  }

  void _handleStartOrFinish() {
    if (!isStarted) {
      _timerService.start();
    } else {
      _timerService.finish();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Race Timer",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 40),

          Container(
            width: 350,
            height: 100,
            alignment: Alignment.center,
            child: ValueListenableBuilder<Duration>(
              valueListenable: _timerService.elapsed,
              builder: (context, duration, _) {
                return Text(
                  formatDuration(duration),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),

          TmButton(
            icon: isStarted ? Icons.stop : Icons.play_arrow,
            label: isStarted ? "Finish Race" : "Start Race",
            onPressed: _handleStartOrFinish,
            color: isStarted ? Colors.red : Colors.green,
          ),
          const SizedBox(height: 30),

          ValueListenableBuilder<Duration>(
            valueListenable: _timerService.elapsed,
            builder: (context, duration, _) {
              final isDisabled = duration == Duration.zero;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TmButton(
                    icon: _timerService.isRunning ? Icons.pause : Icons.play_arrow,
                    label: _pauseResumeLabel,
                    onPressed: isDisabled
                        ? null
                        : () {
                            if (_timerService.isRunning) {
                              _timerService.pause();
                            } else {
                              _timerService.resume();
                            }
                            setState(() {});
                          },
                    color: Colors.orange,
                  ),
                  TmButton(
                    icon: Icons.replay,
                    label: "Reset",
                    onPressed: isDisabled
                        ? null
                        : () {
                            _timerService.reset();
                            setState(() {});
                          },
                    color: Colors.blueGrey,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
