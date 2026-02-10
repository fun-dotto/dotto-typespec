import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Subject Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://subject-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://subject-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://subject-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://subject-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace SubjectService {
  @route("/v1/courses")
  @tag("Courses")
  interface CoursesV1 {
    /**
     * コース一覧を取得する
     * @returns コースのリスト
     */
    @get list(): OkResponse &
      Body<{
        courses: Course[];
      }>;

    /**
     * コースを詳細取得する
     * @param id コースID
     * @returns コースの詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        course: Course;
      }>;

    /**
     * コースを作成する
     * @param body 作成するコースの情報
     * @returns 作成されたコース
     */
    @post create(@body body: CourseRequest): CreatedResponse &
      Body<{
        course: Course;
      }>;

    /**
     * コースを更新する
     * @param id コースID
     * @param body 更新するコースの情報
     * @returns 更新されたコース
     */
    @put update(@path id: string, @body body: CourseRequest): OkResponse &
      Body<{
        course: Course;
      }>;

    /**
     * コースを削除する
     * @param id コースID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/faculties")
  @tag("Faculties")
  interface FacultiesV1 {
    /**
     * 教員一覧を取得する
     * @returns 教員のリスト
     */
    @get list(): OkResponse &
      Body<{
        faculties: Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        faculty: Faculty;
      }>;

    /**
     * 教員を作成する
     * @param body 作成する教員の情報
     * @returns 作成された教員
     */
    @post create(@body body: FacultyRequest): CreatedResponse &
      Body<{
        faculty: Faculty;
      }>;

    /**
     * 教員を更新する
     * @param id 教員ID
     * @param body 更新する教員の情報
     * @returns 更新された教員
     */
    @put update(@path id: string, @body body: FacultyRequest): OkResponse &
      Body<{
        faculty: Faculty;
      }>;

    /**
     * 教員を削除する
     * @param id 教員ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/day-of-week-timetable-slots")
  @tag("DayOfWeekTimetableSlots")
  interface DayOfWeekTimetableSlotsV1 {
    /**
     * 曜日・時限一覧を取得する
     * @returns 曜日・時限のリスト
     */
    @get list(): OkResponse &
      Body<{
        dayOfWeekTimetableSlots: DayOfWeekTimetableSlot[];
      }>;

    /**
     * 曜日・時限を詳細取得する
     * @param id 曜日・時限ID
     * @returns 曜日・時限の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        dayOfWeekTimetableSlot: DayOfWeekTimetableSlot;
      }>;

    /**
     * 曜日・時限を作成する
     * @param body 作成する曜日・時限の情報
     * @returns 作成された曜日・時限
     */
    @post create(
      @body body: DayOfWeekTimetableSlotRequest,
    ): CreatedResponse &
      Body<{
        dayOfWeekTimetableSlot: DayOfWeekTimetableSlot;
      }>;

    /**
     * 曜日・時限を更新する
     * @param id 曜日・時限ID
     * @param body 更新する曜日・時限の情報
     * @returns 更新された曜日・時限
     */
    @put update(
      @path id: string,
      @body body: DayOfWeekTimetableSlotRequest,
    ): OkResponse &
      Body<{
        dayOfWeekTimetableSlot: DayOfWeekTimetableSlot;
      }>;

    /**
     * 曜日・時限を削除する
     * @param id 曜日・時限ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/subject-categories")
  @tag("SubjectCategories")
  interface SubjectCategoriesV1 {
    /**
     * 科目群・科目区分一覧を取得する
     * @returns 科目群・科目区分のリスト
     */
    @get list(): OkResponse &
      Body<{
        subjectCategories: SubjectCategory[];
      }>;

    /**
     * 科目群・科目区分を詳細取得する
     * @param id 科目群・科目区分ID
     * @returns 科目群・科目区分の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subjectCategory: SubjectCategory;
      }>;

    /**
     * 科目群・科目区分を作成する
     * @param body 作成する科目群・科目区分の情報
     * @returns 作成された科目群・科目区分
     */
    @post create(@body body: SubjectCategoryRequest): CreatedResponse &
      Body<{
        subjectCategory: SubjectCategory;
      }>;

    /**
     * 科目群・科目区分を更新する
     * @param id 科目群・科目区分ID
     * @param body 更新する科目群・科目区分の情報
     * @returns 更新された科目群・科目区分
     */
    @put update(
      @path id: string,
      @body body: SubjectCategoryRequest,
    ): OkResponse &
      Body<{
        subjectCategory: SubjectCategory;
      }>;

    /**
     * 科目群・科目区分を削除する
     * @param id 科目群・科目区分ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/subjects")
  @tag("Subjects")
  interface SubjectsV1 {
    /**
     * 科目一覧を取得する
     * @returns 科目のリスト
     */
    @get list(): OkResponse &
      Body<{
        subjects: Subject[];
      }>;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subject: Subject;
      }>;

    /**
     * 科目を作成する
     * @param body 作成する科目の情報
     * @returns 作成された科目
     */
    @post create(@body body: SubjectRequest): CreatedResponse &
      Body<{
        subject: Subject;
      }>;

    /**
     * 科目を更新する
     * @param id 科目ID
     * @param body 更新する科目の情報
     * @returns 更新された科目
     */
    @put update(@path id: string, @body body: SubjectRequest): OkResponse &
      Body<{
        subject: Subject;
      }>;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }
}
