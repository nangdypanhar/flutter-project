import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/service/timer_service.dart';

part 'local_widget/tm_button.dart';

class TimeTrackerView extends StatefulWidget {
  const TimeTrackerView({super.key});

  @override
  State<TimeTrackerView> createState() => _TimeTrackerViewState();
}

class _TimeTrackerViewState extends State<TimeTrackerView> {
  final TimerService _timerService = TimerService();

  void _handleStartOrFinish() {
    final isStarted = _timerService.elapsed.value > Duration.zero;
    if (!isStarted) {
      _timerService.start();
    } else {
      _timerService.finish();
    }
  }

  String _pauseResumeLabel(bool isRunning, bool isStarted) {
    if (isRunning) return "Pause";
    return isStarted ? "Resume" : "Pause";
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

          ValueListenableBuilder<Duration>(
            valueListenable: _timerService.elapsed,
            builder: (context, duration, _) {
              final started = duration > Duration.zero;
              final isDisabled = !started;
              final isRunning = _timerService.isRunning;

              return Column(
                children: [
                  Container(
                    width: 350,
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      formatDuration(duration),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  _TmButton(
                    icon: started ? Icons.stop : Icons.play_arrow,
                    label: started ? "Finish Race" : "Start Race",
                    onPressed: _handleStartOrFinish,
                    color: started ? Colors.red : Colors.green,
                  ),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _TmButton(
                        icon: isRunning ? Icons.pause : Icons.play_arrow,
                        label: _pauseResumeLabel(isRunning, started),
                        onPressed:
                            isDisabled
                                ? null
                                : () {
                                  if (isRunning) {
                                    _timerService.pause();
                                  } else {
                                    _timerService.resume();
                                  }
                                },
                        color: Colors.orange,
                      ),
                      _TmButton(
                        icon: Icons.replay,
                        label: "Reset",
                        onPressed: isDisabled ? null : _timerService.reset,
                        color: Colors.blueGrey,
                      ),
                    ],
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
