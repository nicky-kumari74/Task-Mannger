extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return this.year == now.year && this.month == now.month && this.day == now.day;
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    return this.year == yesterday.year && this.month == yesterday.month && this.day == yesterday.day;
  }
}