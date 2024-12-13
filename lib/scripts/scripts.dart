import 'package:flutter/material.dart';

Map<String, dynamic> datetime_difference(DateTime time,
    [bool largest = false]) {
  final now = DateTime.now();
  final diff = time.difference(now);

  if (largest) {
    int value = 0;
    String type = "minutes";

    if (diff.inDays != 0) {
      value = diff.inDays;
      type = "days";
    } else if (diff.inHours != 0) {
      value = diff.inHours;
      type = "hours";
    } else if (diff.inMinutes != 0) {
      value = diff.inMinutes;
      type = "minutes";
    } else {
      value = 0;
      type = "zero";
    }

    return {
      "difference": value,
      "type": type,
    };
  } else {
    Map<String, dynamic> result = {};

    if (diff.inDays != 0) {
      result["days"] = diff.inDays;
      result["hours"] = diff.inHours - diff.inDays * 24;
      result["minutes"] = diff.inMinutes - diff.inHours * 60;
    } else if (diff.inHours != 0) {
      result["hours"] = diff.inHours;
      result["minutes"] = diff.inMinutes - diff.inHours * 60;
    } else if (diff.inMinutes != 0) {
      result["minutes"] = diff.inMinutes;
    } else {
      result["zero"] = 0;
    }

    return result;
  }
}


String create_short_time_message(DateTime time){
  final date_map = datetime_difference(time,true);

  final String difference = date_map["difference"].toString();
  final String type = date_map["type"][0];
  return difference + type;
}


String create_full_difference_message(DateTime time){
  String msg = "";
  final data_map = datetime_difference(time);

  data_map.forEach((key, value){
    msg += value.toString() + key[0] + " ";
  });

  return msg;
}


Color create_time_color(BuildContext context, String msg){
  return (msg[0] != "-") ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary;
}