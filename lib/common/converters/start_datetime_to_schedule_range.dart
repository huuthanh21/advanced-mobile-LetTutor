import 'package:intl/intl.dart';

/// Formats a time range string from a given start time and an optional duration.
///
/// The function takes a [DateTime] object as the start time and an optional [Duration] object.
/// If no duration is provided, it defaults to 25 minutes.
///
/// The function returns a string in the format 'HH:mm - HH:mm', representing the start and end times of the range.
///
/// Example:
/// ```
/// DateTime startTime = DateTime.now();
/// String timeRange = formatTimeRange(startTime);
/// print(timeRange);  // Outputs: '14:30 - 14:55' (assuming the current time is 14:30)
/// ```
///
/// [time]: The start time of the range.
///
/// [duration]: The duration of the range. Defaults to 25 minutes if not provided.
String formatDateTimeToTimeRange(DateTime time, [Duration? duration]) {
  duration ??= const Duration(minutes: 25);

  final startTime = DateFormat('HH:mm').format(time);
  final endTime = DateFormat('HH:mm').format(time.add(duration));
  return '$startTime - $endTime';
}
