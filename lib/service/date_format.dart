import 'package:intl/intl.dart';

class CustomFunction {
  static String formatDateTime(DateTime dateTime) {
    // Format time as hh:mm AM/PM
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    // Format date as dd/MM/yyyy
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    // Combine time and date
    String result = '$formattedTime $formattedDate';

    return result;
  }
}
