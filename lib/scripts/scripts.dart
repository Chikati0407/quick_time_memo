Map<String, dynamic> datetime_difference(DateTime time,[bool largest = false]){
  final now = DateTime.now();
  final diff = time.difference(now);

  if (largest) {
    int value = 0;
    String type = "minutes";

    if (diff.inDays != 0) {
      value = diff.inDays;
      type = "days";

    } else if (diff.inHours != 0){
      value = diff.inHours;
      type = "hours";

    } else if (diff.inMinutes != 0){
      value = diff.inMinutes;
      type = "minutes";

    }

    return {
      "difference": value,
      "type": type,
    };

  } else {
    Map<String, dynamic> result = {};

    if (diff.inDays != 0){
      result["days"] = diff.inDays;
      result["hours"] = diff.inHours - diff.inDays * 24;
      result["minutes"] = diff.inMinutes - diff.inHours * 60;

    } else if (diff.inHours != 0){
      result["hours"] = diff.inHours;
      result["minutes"] = diff.inMinutes - diff.inHours * 60;

    } else if (diff.inMinutes != 0){
      result["minutes"] = diff.inMinutes;

    }

    return result;
  }


}
