import "../academic-api/model.tsp";

namespace AppBFFService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
  }

  model CourseRegistration {
    id: string;
    subject: SubjectSummary;
  }

  model CourseRegistrationRequest {
    subjectId: string;
  }

  model Room {
    id: string;
    name: string;
    floor: DottoFoundationV1.Floor;
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
    eligibleAttributes: AcademicService.SubjectTargetClass[];

    /**
     * 科目群・科目区分をもとに決定
     */
    requirements: AcademicService.SubjectRequirement[];

    syllabus: AcademicService.Syllabus;
  }

  model SubjectFaculty {
    faculty: AcademicService.Faculty;
    isPrimary: boolean;
  }

  model SubjectSummary {
    id: string;
    name: string;
    faculties: SubjectFaculty[];
  }

  model TimetableItem {
    id: string;
    subject: SubjectSummary;

    /**
     * 集中講義など、時間割に含まれていない場合はnull
     */
    slot?: DottoFoundationV1.TimetableSlot;

    rooms: Room[];
  }

  model UserInfo {
    grade?: DottoFoundationV1.Grade;
    course?: DottoFoundationV1.Course;
    class?: DottoFoundationV1.Class;
  }
}
