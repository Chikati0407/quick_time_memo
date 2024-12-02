Map<String, dynamic> datetime_difference(DateTime time,bool largest){
  final now = DateTime.now();

  if (largest) {
    time.difference(now).inHours;
  } else {

  }

  return {
    "difference": 1,
  };
}

