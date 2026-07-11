export interface IKhmerDate {
  lunarDay: string;
  lunarMonth: string;
  lunarYear: string;
  zodiacYear: string;
  stem: string;
  lunarDayNumber: number;
  ms: string;
  cs: string;
  lunarYearInt: number;
}

const khmerDayString: Record<string, string> = {
  '1': '១កើត', '2': '២កើត', '3': '៣កើត', '4': '៤កើត', '5': '៥កើត',
  '6': '៦កើត', '7': '៧កើត', '8': '៨កើត', '9': '៩កើត', '10': '១០កើត',
  '11': '១១កើត', '12': '១២កើត', '13': '១៣កើត', '14': '១៤កើត', '15': '១៥កើត',
  '16': '១រោច', '17': '២រោច', '18': '៣រោច', '19': '៤រោច', '20': '៥រោច',
  '21': '៦រោច', '22': '៧រោច', '23': '៨រោច', '24': '៩រោច', '25': '១០រោច',
  '26': '១១រោច', '27': '១២រោច', '28': '១៣រោច', '29': '១៤រោច', '30': '១៥រោច'
};


const khmerDigits: Record<string, string> = {
  '0': '០', '1': '១', '2': '២', '3': '៣', '4': '៤',
  '5': '៥', '6': '៦', '7': '៧', '8': '៨', '9': '៩'
};


const KHMER_NORMAL_MONTHS = [
  'មិគសិរ', 'បុស្ស', 'មាឃ', 'ផល្គុន', 'ចេត្រ', 'ពិសាខ', 'ជេស្ឋ', 'អាសាឍ', 'ស្រាពណ៍', 'ភទ្របទ', 'អស្សុជ', 'កត្តិក'
];

const KHMER_LEAP_MONTHS = [
  'មិគសិរ', 'បុស្ស', 'មាឃ', 'ផល្គុន', 'ចេត្រ', 'ពិសាខ', 'ជេស្ឋ', 'បឋមាសាឍ', 'ទុតិយាសាឍ', 'ស្រាពណ៍', 'ភទ្របទ', 'អស្សុជ', 'កត្តិក'
];

const KHMER_ZODIAC = [
  'ជូត', 'ឆ្លូវ', 'ខាល', 'ថោះ', 'រោង', 'ម្សាញ់',
  'មមី', 'មមែ', 'វក', 'រកា', 'ច', 'កុរ'
];

const KHMER_STEMS = [
  'ឯកស័ក', 'ទោស័ក', 'ត្រីស័ក', 'ចត្វាស័ក', 'បញ្ចស័ក',
  'ឆស័ក', 'សប្តស័ក', 'អដ្ឋស័ក', 'នព្វស័ក', 'សំរឹទ្ធិស័ក'
];

function replaceAll(text: string, dic: Record<string, string>): string {
  let result = text;
  for (const [key, value] of Object.entries(dic)) {
    result = result.replace(new RegExp(key, 'g'), value);
  }
  return result;
}

function isGregorianLeapYear(year: number): boolean {
  return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
}

function getGregorianYearDays(year: number): number {
  return isGregorianLeapYear(year) ? 366 : 365;
}

function getDaysSinceStartOfYear(day: number, month: number, year: number): number {
  const date1 = new Date(year, month - 1, day, 0, 0, 0, 0);
  const date2 = new Date(year, 0, 1, 0, 0, 0, 0);
  const diff = date1.getTime() - date2.getTime();
  return Math.floor(diff / 86400000);
}

function getBuddhistEraYearForCalculation(year: number): number {
  return year + 544;
}

function getAharkun(year: number): number {
  return Math.floor((getBuddhistEraYearForCalculation(year) * 292207.0 + 499.0) / 800.0) + 4;
}

function getAvoman(year: number): number {
  return (11 * getAharkun(year) + 25) % 692;
}

function getBodithey(year: number): number {
  const aharkun = getAharkun(year);
  return (Math.floor((11.0 * aharkun + 25.0) / 692.0) + aharkun + 29) % 30;
}

function isKhmerSolarLeapYear(year: number): boolean {
  const aharkunMod = (getBuddhistEraYearForCalculation(year) * 292207 + 499) % 800;
  return 800 - aharkunMod <= 207;
}

function getBoditheyLeapType(year: number): number {
  const avoman = getAvoman(year);
  const bodithey = getBodithey(year);
  let hasLeapMonth = bodithey >= 25 || bodithey <= 5;
  let hasLeapDay = false;
  if (isKhmerSolarLeapYear(year)) {
    hasLeapDay = avoman <= 126;
  } else if (avoman <= 137) {
    hasLeapDay = getAvoman(year + 1) !== 0;
  }
  if (bodithey === 25 && getBodithey(year + 1) === 5) hasLeapMonth = false;
  if (bodithey === 24 && getBodithey(year + 1) === 6) hasLeapMonth = true;
  
  if (hasLeapMonth && hasLeapDay) return 3;
  if (hasLeapMonth) return 1;
  if (hasLeapDay) return 2;
  return 0;
}

function getKhmerYearType(year: number): string {
  const boditheyLeapType = getBoditheyLeapType(year);
  if (boditheyLeapType === 3 || boditheyLeapType === 1) return 'leap-month';
  if (boditheyLeapType === 2 || getBoditheyLeapType(year - 1) === 3) return 'leap-day';
  return 'normal';
}

function getKhmerYearDays(year: number): number {
  const yearType = getKhmerYearType(year);
  if (yearType === 'leap-month') return 384;
  return yearType === 'leap-day' ? 355 : 354;
}

function normalizeKhmerMonthNumber(month: number, year: number): number {
  const monthCount = getKhmerYearType(year) === 'leap-month' ? 13 : 12;
  return ((month - 1) % monthCount + monthCount) % monthCount + 1;
}

function getKhmerMonthName(month: number, year: number): string {
  const normalizedMonth = normalizeKhmerMonthNumber(month, year);
  const yearType = getKhmerYearType(year);
  if (yearType === 'leap-month') {
    return KHMER_LEAP_MONTHS[normalizedMonth - 1];
  }
  return KHMER_NORMAL_MONTHS[normalizedMonth - 1];
}

function getKhmerMonthLength(month: number, year: number): number {
  const normalizedMonth = normalizeKhmerMonthNumber(month, year);
  const yearType = getKhmerYearType(year);
  if (yearType === 'leap-month') {
    if (normalizedMonth === 8 || normalizedMonth === 9) return 30;
    const normalMonthNumber = normalizedMonth > 9 ? normalizedMonth - 1 : normalizedMonth;
    return normalMonthNumber % 2 === 0 ? 30 : 29;
  }
  if (normalizedMonth === 7) return yearType === 'leap-day' ? 30 : 29;
  return normalizedMonth % 2 === 0 ? 30 : 29;
}

function getKhmerCivilDateAtGregorianYearStart(year: number): [number, number] {
  let month = 2;
  let day = 1;
  for (let currentYear = 1900; currentYear < year; currentYear++) {
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
  return [month, day];
}

function advanceKhmerCivilDate(month: number, day: number, year: number, days: number): [number, number] {
  let currentMonth = month;
  let currentDay = day;
  for (let i = 0; i < days; i++) {
    currentDay += 1;
    if (currentDay > getKhmerMonthLength(currentMonth, year)) {
      currentDay = 1;
      currentMonth = normalizeKhmerMonthNumber(currentMonth + 1, year);
    }
  }
  return [currentMonth, currentDay];
}

function findBuddhistEraBoundary(year: number): Date {
  const targetKhmerMonth = 6;
  const targetMonthDay = 16;
  
  let cursor = new Date(year, 3, 10, 0, 0, 0, 0);
  const end = new Date(year, 4, 31, 0, 0, 0, 0);
  
  while (cursor.getTime() <= end.getTime()) {
    const yearStart = getKhmerCivilDateAtGregorianYearStart(year);
    const daysSinceStart = getDaysSinceStartOfYear(cursor.getDate(), cursor.getMonth() + 1, year);
    const civilDate = advanceKhmerCivilDate(yearStart[0], yearStart[1], year, daysSinceStart);
    
    if (civilDate[0] === targetKhmerMonth && civilDate[1] === targetMonthDay) {
      return new Date(cursor);
    }
    cursor.setDate(cursor.getDate() + 1);
  }
  
  return new Date(year, 4, 15, 0, 0, 0, 0);
}

function getKhmerZodiacYear(year: number): string {
  return KHMER_ZODIAC[((year - 2020) % 12 + 12) % 12];
}

function getKhmerStem(year: number): string {
  return KHMER_STEMS[((year - 2019) % 10 + 10) % 10];
}

export class KhmerDate {
  private day: number;
  private month: number;
  private year: number;

  constructor(day?: number | Date, month?: number, year?: number) {
    if (day instanceof Date) {
      this.day = day.getDate();
      this.month = day.getMonth() + 1;
      this.year = day.getFullYear();
    } else if (typeof day === 'number' && typeof month === 'number' && typeof year === 'number') {
      this.day = day;
      this.month = month;
      this.year = year;
    } else {
      const now = new Date();
      this.day = now.getDate();
      this.month = now.getMonth() + 1;
      this.year = now.getFullYear();
    }
  }

  toLunar(): IKhmerDate {
    const yearStart = getKhmerCivilDateAtGregorianYearStart(this.year);
    const daysSinceStart = getDaysSinceStartOfYear(this.day, this.month, this.year);
    const civilDate = advanceKhmerCivilDate(yearStart[0], yearStart[1], this.year, daysSinceStart);
    
    const khmerMonthName = getKhmerMonthName(civilDate[0], this.year);
    const monthDay = civilDate[1];
    
    const targetDate = new Date(this.year, this.month - 1, this.day, 0, 0, 0, 0);
    const refYear = (this.month > 4 || (this.month === 4 && this.day >= 14)) ? this.year : this.year - 1;

    const zodiacYear = getKhmerZodiacYear(refYear);
    const stem = getKhmerStem(refYear);

    const boundary = findBuddhistEraBoundary(this.year);
    let buddhistEraYear = this.year + 543;
    if (targetDate.getTime() >= boundary.getTime()) {
      buddhistEraYear = this.year + 544;
    }

    const lunarYearInt = buddhistEraYear;
    const lunarYearStr = replaceAll(lunarYearInt.toString(), khmerDigits);
    
    const msYear = lunarYearInt - 621;
    const csYear = lunarYearInt - 1181;
    const ms = replaceAll(msYear.toString(), khmerDigits);
    const cs = replaceAll(csYear.toString(), khmerDigits);

    return {
      lunarDay: khmerDayString[monthDay.toString()] || '',
      lunarMonth: khmerMonthName,
      lunarYear: lunarYearStr,
      zodiacYear: zodiacYear,
      stem: stem,
      lunarDayNumber: monthDay,
      ms: ms,
      cs: cs,
      lunarYearInt: lunarYearInt
    };
  }
}

// Calendar Logic

export interface CalendarDay {
  date: Date;
  gregorianDay: number;
  isCurrentMonth: boolean;
  isToday: boolean;
  khmerDate: IKhmerDate;
  isSunday: boolean;
  isEnabled: boolean;
  isHidden: boolean;
  isSpecial: boolean;
}

export type SelectionMode = 'Single' | 'Range' | 'Week';

export interface CalendarConfig {
  firstDayOfWeek?: number; // 0 = Sunday, 1 = Monday
  showAdjacentMonths?: boolean;
  extraWeeksBefore?: number;
  extraWeeksAfter?: number;
  fixedWeekCount?: number | null;
  minDate?: Date | null;
  maxDate?: Date | null;
  selectionMode?: SelectionMode;
  specialDates?: Date[];
}

export class CalendarState {
  private config: Required<CalendarConfig>;
  private cache: Record<string, CalendarDay[]> = {};

  constructor(config: CalendarConfig = {}) {
    this.config = {
      firstDayOfWeek: config.firstDayOfWeek ?? 1,
      showAdjacentMonths: config.showAdjacentMonths ?? true,
      extraWeeksBefore: config.extraWeeksBefore ?? 0,
      extraWeeksAfter: config.extraWeeksAfter ?? 0,
      fixedWeekCount: config.fixedWeekCount !== undefined ? config.fixedWeekCount : 6,
      minDate: config.minDate || null,
      maxDate: config.maxDate || null,
      selectionMode: config.selectionMode || 'Single',
      specialDates: config.specialDates || []
    };
  }

  private isSameDay(date1: Date, date2: Date): boolean {
    return date1.getFullYear() === date2.getFullYear() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getDate() === date2.getDate();
  }

  public generateDaysForMonth(year: number, month: number): CalendarDay[] {
    const cacheKey = `${year}-${month}`;
    if (this.cache[cacheKey]) {
      return this.cache[cacheKey];
    }

    const days: CalendarDay[] = [];
    const cal = new Date(year, month - 1, 1, 0, 0, 0, 0);
    
    const dayOfWeek = cal.getDay(); // 0 = Sunday, 1 = Monday
    
    let offset = 0;
    if (this.config.firstDayOfWeek === 1) {
      offset = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    } else {
      offset = dayOfWeek;
    }
    
    cal.setDate(cal.getDate() - offset - (this.config.extraWeeksBefore * 7));
    
    const endCal = new Date(year, month, 0, 0, 0, 0, 0); // Last day of month
    const endDayOfWeek = endCal.getDay();
    let endOffset = 0;
    if (this.config.firstDayOfWeek === 1) {
      endOffset = endDayOfWeek === 0 ? 0 : 7 - endDayOfWeek;
    } else {
      endOffset = endDayOfWeek === 6 ? 0 : 6 - endDayOfWeek;
    }
    
    endCal.setDate(endCal.getDate() + endOffset + (this.config.extraWeeksAfter * 7));
    
    let totalDays = 0;
    const temp = new Date(cal.getTime());
    temp.setHours(12, 0, 0, 0);
    const tempEnd = new Date(endCal.getTime());
    tempEnd.setHours(12, 0, 0, 0);
    
    while (temp.getTime() <= tempEnd.getTime()) {
      totalDays++;
      temp.setDate(temp.getDate() + 1);
    }
    
    if (this.config.fixedWeekCount !== null) {
      const targetDays = this.config.fixedWeekCount * 7;
      if (totalDays < targetDays) {
        const daysToPad = targetDays - totalDays;
        const weeksToPad = daysToPad / 7;
        const padBeforeWeeks = (offset === 0 && weeksToPad >= 1) ? 1 : Math.floor(weeksToPad / 2);
        cal.setDate(cal.getDate() - (padBeforeWeeks * 7));
        totalDays = targetDays;
      }
    }
    
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const minTime = this.config.minDate ? new Date(this.config.minDate).setHours(0,0,0,0) : null;
    const maxTime = this.config.maxDate ? new Date(this.config.maxDate).setHours(23,59,59,999) : null;
    
    for (let i = 0; i < totalDays; i++) {
      const d = cal.getDate();
      const m = cal.getMonth() + 1;
      const y = cal.getFullYear();
      const isCurrentMonth = m === month;
      
      const isToday = this.isSameDay(cal, today);
      const isSunday = cal.getDay() === 0;
      
      const khmerDate = new KhmerDate(d, m, y).toLunar();
      
      let isEnabled = true;
      const t = cal.getTime();
      if (minTime !== null && t < minTime) isEnabled = false;
      if (maxTime !== null && t > maxTime) isEnabled = false;
      
      const isHidden = !isCurrentMonth && !this.config.showAdjacentMonths;
      const isSpecial = this.config.specialDates.some(sd => this.isSameDay(sd, cal));
      
      days.push({
        date: new Date(cal),
        gregorianDay: d,
        isCurrentMonth,
        isToday,
        khmerDate,
        isSunday,
        isEnabled,
        isHidden,
        isSpecial
      });
      
      cal.setDate(cal.getDate() + 1);
    }
    
    this.cache[cacheKey] = days;
    return days;
  }
}
