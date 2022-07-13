enum PeriodStatus {
  isDay, isWeek, isMonth, isYear
}

extension PeriodStatusExtension on PeriodStatus {
  static const Map<PeriodStatus, String> _names = {
    PeriodStatus.isDay: 'За день',
    PeriodStatus.isWeek: 'За неделю',
    PeriodStatus.isMonth: 'За месяц',
    PeriodStatus.isYear: 'За год'
  };

  String get name => _names[this] ?? 'Неизвестно';
}

