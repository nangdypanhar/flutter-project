import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/service/timer_service.dart';
import 'package:provider/provider.dart';

part 'local_widget/track_button.dart';

enum SegmentType {
  swimming('Swimming'),
  running('Running'),
  cycling('Cycling');

  final String label;

  const SegmentType(this.label);
}

class ParticipantTrackerView extends StatefulWidget {
  const ParticipantTrackerView({super.key});

  @override
  State<ParticipantTrackerView> createState() => _ParticipantTrackerViewState();
}

class _ParticipantTrackerViewState extends State<ParticipantTrackerView> {
  SegmentType currentSegment = SegmentType.swimming;

  TextStyle _getSegmentTextStyle(SegmentType segment) {
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

  Widget _segmentButton(
    SegmentType segment,
    Color color,
    VoidCallback onPressed,
  ) {
    final bool isSelected = segment == currentSegment;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : color.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
      onPressed: onPressed,
      child: Text(segment.label, style: _getSegmentTextStyle(segment)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text('');

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final participants = provider.userList;

        if (provider.isLoading) {
          content = Center(child: CircularProgressIndicator());
        } else {
          content = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                            const Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 36,
                            ),
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
                      SegmentType.swimming,
                      Colors.green.shade300,
                      () {
                        setState(() => currentSegment = SegmentType.swimming);
                      },
                    ),
                    const SizedBox(width: 8),
                    _segmentButton(
                      SegmentType.running,
                      Colors.orange.shade200,
                      () {
                        setState(() => currentSegment = SegmentType.running);
                      },
                    ),
                    const SizedBox(width: 8),
                    _segmentButton(
                      SegmentType.cycling,
                      Colors.purple.shade200,
                      () {
                        setState(() => currentSegment = SegmentType.cycling);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Participants',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      final user = participants[index];
                      final startTime = _getStartTimeForSegment(user);
                      final finishTime = _getFinishTimeForSegment(user);

                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: _TrackButton(
                                started: startTime,
                                bibNumber: user.bibNumber,
                                label: TrackType.start.label,
                                time: startTime,
                                onPressed:
                                    () => provider.updateParticipantStage(
                                      userId: user.id,
                                      segment: currentSegment,
                                      time: TimerService().elapsed.value,
                                      trackType: TrackType.start,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TrackButton(
                                started: startTime,
                                bibNumber: user.bibNumber,
                                label: TrackType.finish.label,
                                time: finishTime,
                                onPressed:
                                    () => provider.updateParticipantStage(
                                      userId: user.id,
                                      segment: currentSegment,
                                      time: TimerService().elapsed.value,
                                      trackType: TrackType.finish,
                                    ),
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

        return content;
      },
    );
  }

  Duration _getStartTimeForSegment(User user) {
    switch (currentSegment) {
      case SegmentType.swimming:
        return user.swimStartAt!;
      case SegmentType.running:
        return user.runStartAt!;
      case SegmentType.cycling:
        return user.cyclingStartAt!;
    }
  }

  Duration _getFinishTimeForSegment(User user) {
    switch (currentSegment) {
      case SegmentType.swimming:
        return user.swimFinishAt!;
      case SegmentType.running:
        return user.runFinishAt!;
      case SegmentType.cycling:
        return user.cyclingFinishAt!;
    }
  }
}
