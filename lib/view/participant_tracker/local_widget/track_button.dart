part of '../participant_tracker_view.dart';

class _TrackButton extends StatelessWidget {
  final Duration? time;
  final VoidCallback onPressed;
  final VoidCallback onReset;
  final String bibNumber;

  const _TrackButton({
    required this.onPressed,
    required this.bibNumber,
    required this.onReset,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final bool eventStarted = TimerService().isRunning;
    final bool isTracked = time != null && time != Duration.zero;
    final bool isButtonDisabled = !eventStarted || isTracked;

    final Color buttonColor =
        isButtonDisabled ? Colors.grey : const Color(0xFF123B77);

    return ElevatedButton(
      onPressed: isButtonDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child:
          isTracked
              ? Stack(
                children: [
                  if (eventStarted)
                    Positioned(
                      top: 2,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.restart_alt),
                        color: Theme.of(context).primaryColor,
                        iconSize: 30,
                        onPressed: onReset,
                      ),
                    ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          bibNumber,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          formatTotalTime(time!),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : Text(
                bibNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }
}
