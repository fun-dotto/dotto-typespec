namespace TimetableService {
  model Item {
    id: string;
    subjectId: string;
    dayOfWeek: DottoFoundationV1.DayOfWeek;
    period: DottoFoundationV1.Period;
    roomId: string;
  }
}
