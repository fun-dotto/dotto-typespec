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
    faculties: FacultyService.Faculty[];

    /**
     * TODO: 時間割APIを作成したら、曜日・時限を取得する
     * 曜日・時限
     */
    dayOfWeekTimetableSlots: string;

    /**
     * TODO: 時間割APIを作成したら、時間割に追加されているかを取得する
     * 時間割に追加されているか
     */
    isAddedToTimetable: boolean;
  }

  model SubjectDetail {
    id: string;
    name: string;
    faculties: FacultyService.Faculty[];
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
}
