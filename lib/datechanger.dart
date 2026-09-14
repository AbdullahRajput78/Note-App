import 'package:intl/intl.dart';

class DateHelper {
  static String timeAgo(String dateString) {
    final date = DateTime.parse(dateString);
    final difference = DateTime.now().difference(date);

    if (difference.inDays == 0) {
      return DateFormat('dd MMM yyyy • h:mm a').format(date);
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return DateFormat('dd MMM yyyy • h:mm a').format(date);
    }
  }
}