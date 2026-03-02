namespace SubjectService {
  /**
   * 対象学年・クラス
   */
  model SubjectTargetClass {
    grade: DottoFoundationV1.Grade;

    /**
     * 修士課程・博士課程対象の場合はnull
     */
    class?: DottoFoundationV1.Class;
  }

  model SubjectRequirement {
    course: DottoFoundationV1.Course;
    requirementType: DottoFoundationV1.SubjectRequirementType;
  }

  model SubjectRequirementRequest {
    course: DottoFoundationV1.Course;
    requirementType: DottoFoundationV1.SubjectRequirementType;
  }

  model SubjectFaculty {
    facultyId: string;
    isPrimary: boolean;
  }

  model SubjectFacultyRequest {
    facultyId: string;
    isPrimary: boolean;
  }

  model SubjectSummary {
    id: string;
    name: string;
    faculties: SubjectFaculty[];
  }

  model Subject {
    id: string;
    name: string;
    faculties: SubjectFaculty[];
    semester: DottoFoundationV1.CourseSemester;

    /**
     * 単位数
     */
    credit: integer;

    /**
     * 授業名末尾の`学年-クラス`をもとに決定
     */
    eligibleAttributes: SubjectTargetClass[];

    /**
     * 科目群・科目区分をもとに決定
     */
    requirements: SubjectRequirement[];
  }

  model Syllabus {
    /**
     * 教務システムのシラバスID
     */
    id: string;

    /**
     * 授業名
     */
    name: string;

    /**
     * 授業名 (en)
     */
    enName: string;

    /**
     * 配当年次
     */
    grades: string;

    /**
     * 単位数
     */
    credit: integer;

    /**
     * 担当教員名
     */
    facultyNames: string;

    /**
     * 実務家教員区分
     */
    practicalHomeFacultyCategory: string;

    /**
     * 複数人担当形式
     */
    multiplePersonTeachingForm: string;

    /**
     * 授業形態
     */
    teachingForm: string;

    /**
     * 授業の概要
     */
    summary: string;

    /**
     * 授業の到達目標
     */
    learningOutcomes: string;

    /**
     * 提出課題等
     */
    assignments: string;

    /**
     * 成績の評価方法・基準
     */
    evaluationMethod: string;

    /**
     * テキスト
     */
    textbooks: string;

    /**
     * 参考書
     */
    referenceBooks: string;

    /**
     * 履修条件
     */
    prerequisites: string;

    /**
     * 事前学習
     */
    preLearning: string;

    /**
     * 事後学習
     */
    postLearning: string;

    /**
     * 履修上の留意点
     */
    notes: string;

    /**
     * キーワード
     */
    keywords: string;

    /**
     * 対象コース・領域
     */
    targetCourses: string;

    /**
     * 対象領域
     */
    targetAreas: string;

    /**
     * 科目群・科目区分
     */
    classifications: string;

    /**
     * 教授言語
     */
    teachingLanguage: string;

    /**
     * 授業内容とスケジュール
     */
    contentsAndSchedule: string;

    /**
     * 授業・試験の形式
     */
    teachingAndExamForm: string;

    /**
     * DSOP対象科目
     */
    dspoSubject: string;
  }

  model SubjectRequest {
    syllabusId: string;
  }
}
