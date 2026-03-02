namespace TimetableService {
  model TimetableItem {
    id: string;
    subjectId: string;
    dayOfWeek: DottoFoundationV1.DayOfWeek;
    period: DottoFoundationV1.Period;
    roomId: string;
  }
}
