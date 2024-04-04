extension MyDurations on num {
  Duration get seconds => Duration(seconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());
}
