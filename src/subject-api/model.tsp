import "../dotto-foundation/model.tsp";

namespace SubjectService {
  /**
   * コース
   */
  model Course {
    id: string;
    name: string;
  }

  model CourseRequest {
    name: string;
  }

  /**
   * 教員
   */
  model Faculty {
    id: string;
    name: string;
    email: string;
  }

  model FacultyRequest {
    name: string;
    email: string;
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

  model TimetableSlotRequest {
    slot: integer;
    startTimeOfDay: plainTime;
    endTimeOfDay: plainTime;
  }

  /**
   * 曜日・時限
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

  model DayOfWeekTimetableSlotRequest {
    dayOfWeek: integer;
    timetableSlotId: string;
  }

  /**
   * 対象学年・クラス
   */
  model SubjectTargetClass {
    grade: DottoFoundationV1.Grade;

    /**
     * 修士課程・博士課程対象の場合はnull
     */
    class: DottoFoundationV1.Class | null;
  }

  model SubjectRequirement {
    course: Course;
    requirementType: DottoFoundationV1.SubjectRequirementType;
  }

  model SubjectRequirementRequest {
    courseId: string;
    requirementType: DottoFoundationV1.SubjectRequirementType;
  }

  /**
   * 科目群・科目区分
   */
  model SubjectCategory {
    id: string;
    name: string;
  }

  model Subject {
    id: string;
    name: string;
    faculty: Faculty;
    semester: DottoFoundationV1.CourseSemester;
    dayOfWeekTimetableSlots: DayOfWeekTimetableSlot[];

    /**
     * 授業名末尾の`学年-クラス`をもとに決定
     */
    eligibleAttributes: SubjectTargetClass[];

    /**
     * 科目群・科目区分をもとに決定
     */
    requirements: SubjectRequirement[];

    /**
     * 科目群・科目区分のリスト
     */
    categories: SubjectCategory[];

    /**
     * 教務システムのシラバスID
     */
    syllabusId: string;
  }

  model SubjectRequest {
    name: string;
    facultyId: string;
    semester: DottoFoundationV1.CourseSemester;
    dayOfWeekTimetableSlotIds: string[];
    eligibleAttributes: SubjectTargetClass[];
    requirements: SubjectRequirementRequest[];
    categoryIds: string[];
    syllabusId: string;
  }
}
