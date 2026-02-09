namespace AdminBFFService {
  model Announcement {
    id: string;
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }

  model AnnouncementRequest {
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }

  model Faculty {
    id: string;
    name: string;
    email: string;
  }

  model FacultyRequest {
    name: string;
    email: string;
  }

  enum CoursePeriod {
    /**
     * 通年
     */
    AllYear,

    /**
     * 前期
     */
    H1,

    /**
     * 後期
     */
    H2,

    /**
     * 第1クオーター
     */
    Q1,

    /**
     * 第2クオーター
     */
    Q2,

    /**
     * 第3クオーター
     */
    Q3,

    /**
     * 第4クオーター
     */
    Q4,

    /**
     * 夏期集中
     */
    SummerIntensive,

    /**
     * 冬期集中
     */
    WinterIntensive,
  }

  /**
   * 授業時間
   */
  model TimetableSlot {
    id: string;

    /**
     * 時限
     *
     * 1: 1限
     * 2: 2限
     * 3: 3限
     * 4: 4限
     * 5: 5限
     * 6: 6限
     */
    slot: integer;

    startTimeOfDay: plainTime;
    endTimeOfDay: plainTime;
  }

  /**
   * 曜日ごとの授業時間
   */
  model DayOfWeekTimetableSlot {
    id: string;

    /**
     * 曜日
     *
     * 0: 日曜日
     * 1: 月曜日
     * 2: 火曜日
     * 3: 水曜日
     * 4: 木曜日
     * 5: 金曜日
     * 6: 土曜日
     */
    dayOfWeek: integer;

    timetableSlot: TimetableSlot;
  }

  enum RequirementType {
    /**
     * 必修
     */
    Required,

    /**
     * 選択
     */
    Optional,
  }

  /**
   * コース
   */
  model Course {
    id: string;
    name: string;
  }

  /**
   * 学年
   */
  enum Grade {
    B1,
    B2,
    B3,
    B4,
    M1,
    M2,
    D1,
    D2,
    D3,
  }

  /**
   * クラス
   */
  enum Class {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
  }

  model EligibleAttribute {
    grade: Grade;

    /**
     * 修士課程・博士課程対象の場合はnull
     */
    class: Class | null;

    /**
     * 同一クラス・同一コースであればnull
     */
    course: Course | null;

    requirementType: RequirementType;
  }

  model SubjectType {
    id: string;
    name: string;
  }

  model Subject {
    id: string;
    name: string;
    faculty: Faculty;
    period: CoursePeriod;
    dayOfWeekTimetableSlots: DayOfWeekTimetableSlot[];
    eligibleAttributes: EligibleAttribute[];

    /**
     * 科目群・科目区分
     */
    subjectType: SubjectType;

    /**
     * 教務システムのシラバスID
     */
    syllabusId: string;
  }

  model SubjectRequest {
    name: string;
    facultyId: string;
    period: CoursePeriod;
    dayOfWeekTimetableSlotIds: string[];
    eligibleAttributes: EligibleAttribute[];
    subjectTypeId: string;
    syllabusId: string;
  }
}
