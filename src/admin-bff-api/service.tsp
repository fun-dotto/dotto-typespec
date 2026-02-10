import "@typespec/http";
import "@typespec/openapi";
import "../announcement-api/model.tsp";
import "../subject-api/model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Admin BFF Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://admin-bff-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://admin-bff-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://admin-bff-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://admin-bff-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace AdminBFFService {
  @route("/v1/announcements")
  @tag("Announcements")
  interface AnnouncementsV1 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): OkResponse &
      Body<{
        announcements: AnnouncementService.Announcement[];
      }>;

    /**
     * おしらせを詳細取得する
     * @param id おしらせID
     * @returns おしらせの詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>;

    /**
     * おしらせを作成する
     * @param body 作成するおしらせの情報
     * @returns 作成されたおしらせ
     */
    @post create(
      @body body: AnnouncementService.AnnouncementRequest,
    ): CreatedResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>;

    /**
     * おしらせを更新する
     * @param id おしらせID
     * @param body 更新するおしらせの情報
     * @returns 更新されたおしらせ
     */
    @put update(
      @path id: string,
      @body body: AnnouncementService.AnnouncementRequest,
    ): OkResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>;

    /**
     * おしらせを削除する
     * @param id おしらせID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/courses")
  @tag("Courses")
  interface CoursesV1 {
    /**
     * コース一覧を取得する
     * @returns コースのリスト
     */
    @get list(): OkResponse &
      Body<{
        courses: SubjectService.Course[];
      }>;

    /**
     * コースを詳細取得する
     * @param id コースID
     * @returns コースの詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        course: SubjectService.Course;
      }>;

    /**
     * コースを作成する
     * @param body 作成するコースの情報
     * @returns 作成されたコース
     */
    @post create(@body body: SubjectService.CourseRequest): CreatedResponse &
      Body<{
        course: SubjectService.Course;
      }>;

    /**
     * コースを更新する
     * @param id コースID
     * @param body 更新するコースの情報
     * @returns 更新されたコース
     */
    @put update(
      @path id: string,
      @body body: SubjectService.CourseRequest,
    ): OkResponse &
      Body<{
        course: SubjectService.Course;
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
        faculties: SubjectService.Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        faculty: SubjectService.Faculty;
      }>;

    /**
     * 教員を作成する
     * @param body 作成する教員の情報
     * @returns 作成された教員
     */
    @post create(@body body: SubjectService.FacultyRequest): CreatedResponse &
      Body<{
        faculty: SubjectService.Faculty;
      }>;

    /**
     * 教員を更新する
     * @param id 教員ID
     * @param body 更新する教員の情報
     * @returns 更新された教員
     */
    @put update(
      @path id: string,
      @body body: SubjectService.FacultyRequest,
    ): OkResponse &
      Body<{
        faculty: SubjectService.Faculty;
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
        dayOfWeekTimetableSlots: SubjectService.DayOfWeekTimetableSlot[];
      }>;

    /**
     * 曜日・時限を詳細取得する
     * @param id 曜日・時限ID
     * @returns 曜日・時限の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        dayOfWeekTimetableSlot: SubjectService.DayOfWeekTimetableSlot;
      }>;

    /**
     * 曜日・時限を作成する
     * @param body 作成する曜日・時限の情報
     * @returns 作成された曜日・時限
     */
    @post create(
      @body body: SubjectService.DayOfWeekTimetableSlotRequest,
    ): CreatedResponse &
      Body<{
        dayOfWeekTimetableSlot: SubjectService.DayOfWeekTimetableSlot;
      }>;

    /**
     * 曜日・時限を更新する
     * @param id 曜日・時限ID
     * @param body 更新する曜日・時限の情報
     * @returns 更新された曜日・時限
     */
    @put update(
      @path id: string,
      @body body: SubjectService.DayOfWeekTimetableSlotRequest,
    ): OkResponse &
      Body<{
        dayOfWeekTimetableSlot: SubjectService.DayOfWeekTimetableSlot;
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
        subjectCategories: SubjectService.SubjectCategory[];
      }>;

    /**
     * 科目群・科目区分を詳細取得する
     * @param id 科目群・科目区分ID
     * @returns 科目群・科目区分の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subjectCategory: SubjectService.SubjectCategory;
      }>;

    /**
     * 科目群・科目区分を作成する
     * @param body 作成する科目群・科目区分の情報
     * @returns 作成された科目群・科目区分
     */
    @post create(
      @body body: SubjectService.SubjectCategoryRequest,
    ): CreatedResponse &
      Body<{
        subjectCategory: SubjectService.SubjectCategory;
      }>;

    /**
     * 科目群・科目区分を更新する
     * @param id 科目群・科目区分ID
     * @param body 更新する科目群・科目区分の情報
     * @returns 更新された科目群・科目区分
     */
    @put update(
      @path id: string,
      @body body: SubjectService.SubjectCategoryRequest,
    ): OkResponse &
      Body<{
        subjectCategory: SubjectService.SubjectCategory;
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
        subjects: SubjectService.Subject[];
      }>;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subject: SubjectService.Subject;
      }>;

    /**
     * 科目を作成する
     * @param body 作成する科目の情報
     * @returns 作成された科目
     */
    @post create(@body body: SubjectService.SubjectRequest): CreatedResponse &
      Body<{
        subject: SubjectService.Subject;
      }>;

    /**
     * 科目を更新する
     * @param id 科目ID
     * @param body 更新する科目の情報
     * @returns 更新された科目
     */
    @put update(
      @path id: string,
      @body body: SubjectService.SubjectRequest,
    ): OkResponse &
      Body<{
        subject: SubjectService.Subject;
      }>;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }
}
