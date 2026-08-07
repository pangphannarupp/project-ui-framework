class KhmerDateInfo {
  final String lunarDay;
  final String lunarMonth;
  final String lunarYear;
  final String zodiacYear;
  final String stem;
  final int lunarDayNumber;
  final String ms;
  final String cs;
  final int lunarYearInt;

  KhmerDateInfo({
    required this.lunarDay,
    required this.lunarMonth,
    required this.lunarYear,
    required this.zodiacYear,
    required this.stem,
    required this.lunarDayNumber,
    required this.ms,
    required this.cs,
    required this.lunarYearInt,
  });
}

class KhmerDate {
  static const Map<String, String> khmerDayString = {
    '1': '១កើត', '2': '២កើត', '3': '៣កើត', '4': '៤កើត', '5': '៥កើត',
    '6': '៦កើត', '7': '៧កើត', '8': '៨កើត', '9': '៩កើត', '10': '១០កើត',
    '11': '១១កើត', '12': '១២កើត', '13': '១៣កើត', '14': '១៤កើត', '15': '១៥កើត',
    '16': '១រោច', '17': '២រោច', '18': '៣រោច', '19': '៤រោច', '20': '៥រោច',
    '21': '៦រោច', '22': '៧រោច', '23': '៨រោច', '24': '៩រោច', '25': '១០រោច',
    '26': '១១រោច', '27': '១២រោច', '28': '១៣រោច', '29': '១៤រោច', '30': '១៥រោច'
  };

  static const Map<String, String> khmerDigits = {
    '0': '០', '1': '១', '2': '២', '3': '៣', '4': '៤',
    '5': '៥', '6': '៦', '7': '៧', '8': '៨', '9': '៩'
  };

  static const List<String> KHMER_NORMAL_MONTHS = [
    'មិគសិរ', 'បុស្ស', 'មាឃ', 'ផល្គុន', 'ចេត្រ', 'ពិសាខ', 'ជេស្ឋ', 'អាសាឍ', 'ស្រាពណ៍', 'ភទ្របទ', 'អស្សុជ', 'កត្តិក'
  ];

  static const List<String> KHMER_LEAP_MONTHS = [
    'មិគសិរ', 'បុស្ស', 'មាឃ', 'ផល្គុន', 'ចេត្រ', 'ពិសាខ', 'ជេស្ឋ', 'បឋមាសាឍ', 'ទុតិយាសាឍ', 'ស្រាពណ៍', 'ភទ្របទ', 'អស្សុជ', 'កត្តិក'
  ];

  static const List<String> KHMER_ZODIAC = [
    'ជូត', 'ឆ្លូវ', 'ខាល', 'ថោះ', 'រោង', 'ម្សាញ់',
    'មមី', 'មមែ', 'វក', 'រកា', 'ច', 'កុរ'
  ];

  static const List<String> KHMER_STEMS = [
    'ឯកស័ក', 'ទោស័ក', 'ត្រីស័ក', 'ចត្វាស័ក', 'បញ្ចស័ក',
    'ឆស័ក', 'សប្តស័ក', 'អដ្ឋស័ក', 'នព្វស័ក', 'សំរឹទ្ធិស័ក'
  ];

  static String replaceAll(String text, Map<String, String> dic) {
    String result = text;
    for (var entry in dic.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  static bool isGregorianLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  static int getGregorianYearDays(int year) {
    return isGregorianLeapYear(year) ? 366 : 365;
  }

  static int getDaysSinceStartOfYear(int day, int month, int year) {
    final date1 = DateTime(year, month, day);
    final date2 = DateTime(year, 1, 1);
    final diff = date1.difference(date2);
    return diff.inDays;
  }

  static int getBuddhistEraYearForCalculation(int year) {
    return year + 544;
  }

  static int getAharkun(int year) {
    return ((getBuddhistEraYearForCalculation(year) * 292207.0 + 499.0) / 800.0).floor() + 4;
  }

  static int getAvoman(int year) {
    return (11 * getAharkun(year) + 25) % 692;
  }

  static int getBodithey(int year) {
    final aharkun = getAharkun(year);
    return (((11.0 * aharkun + 25.0) / 692.0).floor() + aharkun + 29) % 30;
  }

  static bool isKhmerSolarLeapYear(int year) {
    final aharkunMod = (getBuddhistEraYearForCalculation(year) * 292207 + 499) % 800;
    return 800 - aharkunMod <= 207;
  }

  static int getBoditheyLeapType(int year) {
    final avoman = getAvoman(year);
    final bodithey = getBodithey(year);
    bool hasLeapMonth = bodithey >= 25 || bodithey <= 5;
    bool hasLeapDay = false;
    
    if (isKhmerSolarLeapYear(year)) {
      hasLeapDay = avoman <= 126;
    } else if (avoman <= 137) {
      hasLeapDay = getAvoman(year + 1) != 0;
    }
    
    if (bodithey == 25 && getBodithey(year + 1) == 5) hasLeapMonth = false;
    if (bodithey == 24 && getBodithey(year + 1) == 6) hasLeapMonth = true;
    
    if (hasLeapMonth && hasLeapDay) return 3;
    if (hasLeapMonth) return 1;
    if (hasLeapDay) return 2;
    return 0;
  }

  static String getKhmerYearType(int year) {
    final boditheyLeapType = getBoditheyLeapType(year);
    if (boditheyLeapType == 3 || boditheyLeapType == 1) return 'leap-month';
    if (boditheyLeapType == 2 || getBoditheyLeapType(year - 1) == 3) return 'leap-day';
    return 'normal';
  }

  static int getKhmerYearDays(int year) {
    final yearType = getKhmerYearType(year);
    if (yearType == 'leap-month') return 384;
    return yearType == 'leap-day' ? 355 : 354;
  }

  static int normalizeKhmerMonthNumber(int month, int year) {
    final monthCount = getKhmerYearType(year) == 'leap-month' ? 13 : 12;
    return ((month - 1) % monthCount + monthCount) % monthCount + 1;
  }

  static String getKhmerMonthName(int month, int year) {
    final normalizedMonth = normalizeKhmerMonthNumber(month, year);
    final yearType = getKhmerYearType(year);
    if (yearType == 'leap-month') {
      return KHMER_LEAP_MONTHS[normalizedMonth - 1];
    }
    return KHMER_NORMAL_MONTHS[normalizedMonth - 1];
  }

  static int getKhmerMonthLength(int month, int year) {
    final normalizedMonth = normalizeKhmerMonthNumber(month, year);
    final yearType = getKhmerYearType(year);
    if (yearType == 'leap-month') {
      if (normalizedMonth == 8 || normalizedMonth == 9) return 30;
      final normalMonthNumber = normalizedMonth > 9 ? normalizedMonth - 1 : normalizedMonth;
      return normalMonthNumber % 2 == 0 ? 30 : 29;
    }
    if (normalizedMonth == 7) return yearType == 'leap-day' ? 30 : 29;
    return normalizedMonth % 2 == 0 ? 30 : 29;
  }

  static final Map<int, List<int>> _yearStartCache = {};

  static List<int> getKhmerCivilDateAtGregorianYearStart(int year) {
    if (_yearStartCache.containsKey(year)) {
      return _yearStartCache[year]!;
    }

    int month = 2;
    int day = 1;
    for (int currentYear = 1900; currentYear < year; currentYear++) {
      day += getGregorianYearDays(currentYear) - getKhmerYearDays(currentYear);
      while (day > getKhmerMonthLength(month, currentYear)) {
        day -= getKhmerMonthLength(month, currentYear);
        month = normalizeKhmerMonthNumber(month + 1, currentYear);
      }
      while (day <= 0) {
        month = normalizeKhmerMonthNumber(month - 1, currentYear);
        day += getKhmerMonthLength(month, currentYear);
      }
    }
    
    final result = [month, day];
    _yearStartCache[year] = result;
    return result;
  }

  static List<int> advanceKhmerCivilDate(int month, int day, int year, int days) {
    int currentMonth = month;
    int currentDay = day;
    for (int i = 0; i < days; i++) {
      currentDay += 1;
      if (currentDay > getKhmerMonthLength(currentMonth, year)) {
        currentDay = 1;
        currentMonth = normalizeKhmerMonthNumber(currentMonth + 1, year);
      }
    }
    return [currentMonth, currentDay];
  }

  static DateTime findBuddhistEraBoundary(int year) {
    const targetKhmerMonth = 6;
    const targetMonthDay = 16;
    
    DateTime cursor = DateTime(year, 4, 10);
    DateTime end = DateTime(year, 5, 31);
    
    while (cursor.compareTo(end) <= 0) {
      final yearStart = getKhmerCivilDateAtGregorianYearStart(year);
      final daysSinceStart = getDaysSinceStartOfYear(cursor.day, cursor.month, year);
      final civilDate = advanceKhmerCivilDate(yearStart[0], yearStart[1], year, daysSinceStart);
      
      if (civilDate[0] == targetKhmerMonth && civilDate[1] == targetMonthDay) {
        return cursor;
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    
    return DateTime(year, 5, 15);
  }

  static String getKhmerZodiacYear(int year) {
    return KHMER_ZODIAC[((year - 2020) % 12 + 12) % 12];
  }

  static String getKhmerStem(int year) {
    return KHMER_STEMS[((year - 2019) % 10 + 10) % 10];
  }

  final int day;
  final int month;
  final int year;

  KhmerDate({required this.day, required this.month, required this.year});

  factory KhmerDate.fromDate(DateTime date) {
    return KhmerDate(day: date.day, month: date.month, year: date.year);
  }

  static final Map<String, KhmerDateInfo> _lunarCache = {};

  KhmerDateInfo toLunar() {
    final cacheKey = '$year-$month-$day';
    if (_lunarCache.containsKey(cacheKey)) {
      return _lunarCache[cacheKey]!;
    }

    final yearStart = getKhmerCivilDateAtGregorianYearStart(this.year);
    final daysSinceStart = getDaysSinceStartOfYear(this.day, this.month, this.year);
    final civilDate = advanceKhmerCivilDate(yearStart[0], yearStart[1], this.year, daysSinceStart);
    
    final khmerMonthName = getKhmerMonthName(civilDate[0], this.year);
    final monthDay = civilDate[1];
    
    final targetDate = DateTime(this.year, this.month, this.day);
    final refYear = (this.month > 5 || (this.month == 5 && this.day >= 14)) ? this.year : this.year - 1;

    final zodiacYear = getKhmerZodiacYear(refYear);
    final stem = getKhmerStem(refYear);

    final boundary = findBuddhistEraBoundary(this.year);
    int buddhistEraYear = this.year + 543;
    if (targetDate.compareTo(boundary) >= 0) {
      buddhistEraYear = this.year + 544;
    }

    final lunarYearInt = buddhistEraYear;
    final lunarYearStr = replaceAll(lunarYearInt.toString(), khmerDigits);
    
    final msYear = lunarYearInt - 621;
    final csYear = lunarYearInt - 1181;
    final ms = replaceAll(msYear.toString(), khmerDigits);
    final cs = replaceAll(csYear.toString(), khmerDigits);

    final result = KhmerDateInfo(
      lunarDay: khmerDayString[monthDay.toString()] ?? '',
      lunarMonth: khmerMonthName,
      lunarYear: lunarYearStr,
      zodiacYear: zodiacYear,
      stem: stem,
      lunarDayNumber: monthDay,
      ms: ms,
      cs: cs,
      lunarYearInt: lunarYearInt,
    );
    
    _lunarCache[cacheKey] = result;
    return result;
  }
}
