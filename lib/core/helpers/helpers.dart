class Helpers {
  /// Formats a [Duration] object as a string in the format "HH:MM:SS".
  /// This method takes a [Duration] object and returns a string representation of
  /// the duration in the format "HH:MM:SS", where:
  /// - "HH" is the number of hours, padded with a leading zero if necessary
  /// - "MM" is the number of minutes, padded with a leading zero if necessary
  /// - "SS" is the number of seconds, padded with a leading zero if necessary
  /// For example, a [Duration] of 1 hour, 15 minutes, and 30 seconds would be
  /// formatted as "01:15:30".
  ///
  /// This method is useful for displaying durations in a user-friendly format.
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

}
