part of '../participant_tracker_view.dart';

enum TrackType {
  start('Start'),
  finish('Finish');

  final String label;

  const TrackType(this.label);
}

class _TrackButton extends StatelessWidget {
  final String label;
  final Duration? time;
  final VoidCallback onPressed;
  final String bibNumber;
  final Duration? started;

  const _TrackButton({
    required this.label,
    required this.onPressed,
    required this.bibNumber,
    required this.started,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final bool eventStarted = TimerService().isRunning;
    final bool isButtonDisabled = !eventStarted;

    final bool isFinishButtonDisabled =
        label == TrackType.finish.label &&
        (started == null || started == Duration.zero);

    final Color buttonColor =
        isButtonDisabled || isFinishButtonDisabled
            ? Colors.grey
            : const Color(0xFF123B77);

    return ElevatedButton(
      onPressed:
          (isButtonDisabled || isFinishButtonDisabled) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child:
          (time != null && time != Duration.zero)
              ? Text(
                formatDuration(time!),
                style: const TextStyle(color: Colors.white),
              )
              : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$bibNumber ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                      text: label,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
    );
  }
}
