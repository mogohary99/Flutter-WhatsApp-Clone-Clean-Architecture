
class DateConverter{

  static String getChatContactTime(DateTime dateTime){
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return dateConverterHoursAmPmMode(dateTime);
    }
    else if (localDateTime.day == yesterday.day && localDateTime.month == yesterday.month && localDateTime.year == yesterday.year) {
      return 'Yesterday';
    }else{
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  static String getChatDayTime(DateTime dateTime){
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'Today';
    }
    else if (localDateTime.day == yesterday.day && localDateTime.month == yesterday.month && localDateTime.year == yesterday.year) {
      return 'Yesterday';
    }else{
      return dateConverterMonth(dateTime.toString());
    }
  }
  static String getLastSeenDayTime(DateTime dateTime){
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'today';
    }
    else if (localDateTime.day == yesterday.day && localDateTime.month == yesterday.month && localDateTime.year == yesterday.year) {
      return 'yesterday';
    }else{
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  static bool isSameDay(DateTime nowTime,DateTime priviesTime){
    DateTime now = nowTime.toLocal();
    DateTime privies = priviesTime.toLocal();
    if(now.day ==privies.day && now.month == privies.month && now.year == privies.year){
      return true;
    }
    return false;
  }

  //2022-12-07 12:01:17.696
  static String dateConverterHoursAmPmMode(DateTime dateTime){
    String string = dateTime.toString();
    int i = 0;
    String s = "";
    int mode = int.parse(string[11] + string[12]);
    List<String> duration = ['am', 'pm'];


    if(mode > 11) {
      if(mode != 12) mode -= 12;

      mode < 10 ? s += '0$mode' : s += '$mode' ;

      for (i = 13; i < 16; ++i) {
        s += string.split('')[i];
      }

      s += ' ${duration[1]}';

    }
    else{

      for (i = 11; i < 16; ++i) {
        s += string.split('')[i];
      }

      s += ' ${duration[0]}';
    }

    return s;
  }
  //2022-12-07 12:01:17.696
  static String dateConverterMonth(String string){
    int i = 0;
    String s = "";
    String monthNum = string.split('')[5] + string.split('')[6];
    String dayNum = string.split('')[8] + string.split('')[9];

    List <String> m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    List <String> mN = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];

    for (i = 0; i < 12; ++i) {
      if (monthNum == mN[i]) {
        s = '$dayNum ${m[i]} ';
        break;
      }
    }

    for (i = 0; i < 4; ++i) {
      s += string.split('')[i];
    }

    return s;
  }

  static String dateConverterMonthNum(String string){
    int i = 0;
    String s = "";
    String monthNum = string.split('')[5] + string.split('')[6];
    String dayNum = string.split('')[8] + string.split('')[9];

    List <String> m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    List <String> mN = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];

    for (i = 0; i < 12; ++i) {
      if (monthNum == mN[i]) {
        s = '$dayNum/${mN[i]}/';
        break;
      }
    }

    for (i = 2; i < 4; ++i) {
      s += string.split('')[i];
    }

    return s;
  }

  static String dateConverterOnly(String string) {
    String s = "";
    s = string.split("T")[0];
    return s;
  }

  static String dateConverterSince(String string){
    String s = "";
    int apiDay = int.parse(string.split("")[8] + string.split("")[9]);
    int currentDay = DateTime.now().day;

    if(currentDay == apiDay) s = "Today";
    else if(currentDay == apiDay + 1) s = "Yesterday";
    else if(currentDay > apiDay + 1) s = "Since ${currentDay - apiDay} days";

    return s;
  }

  static String dateConverterHours24Mode(String string){
    int i = 0;
    String s = "";

    for (i = 11; i < 16; ++i) {
      s += string.split('')[i];
    }

    return s;
  }


}