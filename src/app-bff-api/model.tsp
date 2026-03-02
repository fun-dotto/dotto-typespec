import "../subject-api/model.tsp";

namespace AppBFFService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
  }

  model SubjectSummary {
    id: string;
    name: string;
    faculties: SubjectFaculty[];

    /**
     * TODO: Timetable API から曜日を取得する
     * 曜日
     */
    dayOfWeek: DottoFoundationV1.DayOfWeek;

    /**
     * TODO: Timetable API から時限を取得する
     * 時限
     */
    period: DottoFoundationV1.Period;

    /**
     * TODO: 時間割APIを作成したら、時間割に追加されているかを取得する
     * 時間割に追加されているか
     */
    isAddedToTimetable: boolean;
  }

  model SubjectDetail {
    id: string;
    name: string;
    faculties: SubjectFaculty[];

    /**
     * 開講年度
     */
    year: integer;

    /**
     * 開講時期
     */
    semester: DottoFoundationV1.CourseSemester;

    /**
     * 単位数
     */
    credit: integer;

    /**
     * 授業名末尾の`学年-クラス`をもとに決定
     */
    eligibleAttributes: SubjectService.SubjectTargetClass[];

    /**
     * 科目群・科目区分をもとに決定
     */
    requirements: SubjectService.SubjectRequirement[];

    syllabus: SubjectService.Syllabus;
  }

  model SubjectFaculty {
    faculty: FacultyService.Faculty;
    isPrimary: boolean;
  }

  model UserInfo {
    grade?: DottoFoundationV1.Grade;
    course?: DottoFoundationV1.Course;
    class?: DottoFoundationV1.Class;
  }
}
