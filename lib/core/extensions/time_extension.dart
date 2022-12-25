import '/core/functions/date_converter.dart';

extension DateUtil on DateTime {
  String get lastSeen {
    return 'last seen ${DateConverter.getLastSeenDayTime(this)} at ${DateConverter.dateConverterHoursAmPmMode(this)}';
  }
  String get amPmMode{
    return DateConverter.dateConverterHoursAmPmMode(this);
  }
  String get chatDayTime{
    return DateConverter.getChatDayTime(this);
  }
  String get chatContactTime{
    return DateConverter.getChatContactTime(this);
  }
  bool isSameDay(DateTime day2){
    return DateConverter.isSameDay(this, day2);
  }
}