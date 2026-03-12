import "@typespec/http";
import "@typespec/openapi";
import "../academic-api/model.tsp";
import "../announcement-api/model.tsp";

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

  @route("/v1/courseRegistrations")
  @tag("CourseRegistrations")
  interface CourseRegistrationsV1 {
    /**
     * 履修情報を取得する
     * @param userId ユーザーID
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semester 開講時期
     * @returns 履修情報のリスト
     */
    @get list(
      @query userId: string,
      @query year?: integer,
      @query semester: DottoFoundationV1.CourseSemester,
    ): OkResponse &
      Body<{
        registrations: AcademicService.Registration[];
      }>;

    /**
     * 履修情報を作成する
     * @param body 作成する履修情報の情報
     * @returns 作成された履修情報
     */
    @post create(
      @body body: AcademicService.RegistrationRequest,
    ): CreatedResponse &
      Body<{
        registration: AcademicService.Registration;
      }>;

    /**
     * 履修情報を削除する
     * @param id 履修情報ID
     * @returns 削除された履修情報
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/rooms")
  @tag("Rooms")
  interface RoomsV1 {
    /**
     * 教室一覧を取得する
     * @returns 教室のリスト
     */
    @get list(@query floor?: DottoFoundationV1.Floor[]): OkResponse &
      Body<{
        rooms: AcademicService.Room[];
      }>;

    /**
     * 教室を詳細取得する
     * @param id 教室ID
     * @returns 教室の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        room: AcademicService.Room;
      }>;

    /**
     * 教室を作成する
     * @param body 作成する教室の情報
     * @returns 作成された教室
     */
    @post create(@body body: AcademicService.RoomRequest): CreatedResponse &
      Body<{
        room: AcademicService.Room;
      }>;

    /**
     * 教室を更新する
     * @param id 教室ID
     * @param body 更新する教室の情報
     * @returns 更新された教室
     */
    @put update(
      @path id: string,
      @body body: AcademicService.RoomRequest,
    ): OkResponse &
      Body<{
        room: AcademicService.Room;
      }>;

    /**
     * 教室を削除する
     * @param id 教室ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/rooms/{id}/reservations")
  @tag("Reservations")
  interface ReservationsV1 {
    /**
     * 教室の予約一覧を取得する
     * @param id 教室ID
     * @param from 開始日時
     * @param until 終了日時
     * @returns 予約のリスト
     */
    @get list(
      @path id: string,
      @query from?: utcDateTime,
      @query until?: utcDateTime,
    ): OkResponse &
      Body<{
        reservations: AcademicService.Reservation[];
      }>;
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
        faculties: AcademicService.Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>;

    /**
     * 教員を作成する
     * @param body 作成する教員の情報
     * @returns 作成された教員
     */
    @post create(@body body: AcademicService.FacultyRequest): CreatedResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>;

    /**
     * 教員を更新する
     * @param id 教員ID
     * @param body 更新する教員の情報
     * @returns 更新された教員
     */
    @put update(
      @path id: string,
      @body body: AcademicService.FacultyRequest,
    ): OkResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>;

    /**
     * 教員を削除する
     * @param id 教員ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/subjects")
  @tag("Subjects")
  interface SubjectsV1 {
    /**
     * 科目一覧を取得する
     *
     * 同一項目同士はOR、異なる項目同士はANDでフィルタリングされます。
     *
     * @param q 検索ワード
     * @param grade 学年
     * @param courses コース; 大学院の場合は大学院コースに読み替え
     * @param class クラス; 大学院の学年を選択した場合は選択できない
     * @param classification 学部: 専門・教養; 大学院: 専門・研究指導
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semester 開講時期
     * @param requirementType 必修・選択・選択必修
     * @param culturalSubjectCategory 教養科目カテゴリ
     * @returns 科目のリスト
     */
    @get list(
      @query q?: string,
      @query grade?: DottoFoundationV1.Grade[],
      @query courses?: DottoFoundationV1.Course[],
      @query class?: DottoFoundationV1.Class[],
      @query classification?: DottoFoundationV1.SubjectClassification[],
      @query year?: integer,
      @query semester?: DottoFoundationV1.CourseSemester[],
      @query requirementType?: DottoFoundationV1.SubjectRequirementType[],

      @query
      culturalSubjectCategory?: DottoFoundationV1.CulturalSubjectCategory[],
    ): OkResponse &
      Body<{
        subjects: AcademicService.SubjectSummary[];
      }>;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subject: AcademicService.Subject;
      }>;

    /**
     * 科目を作成または更新する
     * @param body 作成または更新する科目の情報
     * @returns 作成または更新された科目
     */
    @post upsert(@body body: AcademicService.SubjectRequest): OkResponse &
      Body<{
        subject: AcademicService.Subject;
      }>;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/timetableItmes")
  @tag("TimetableItems")
  interface TimetableItemsV1 {
    /**
     * 時間割を取得する
     *
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semester 開講時期
     * @param dayOfWeek 曜日; 複数指定時はORでフィルタリングされる; 指定しない場合は全ての曜日が選択される
     * @returns 時間割のリスト
     */
    @get list(
      @query year?: integer,
      @query semester: DottoFoundationV1.CourseSemester,
      @query dayOfWeek?: DottoFoundationV1.DayOfWeek[],
    ): OkResponse &
      Body<{
        items: AcademicService.TimetableItem[];
      }>;

    /**
     * 時間割に追加する
     * @param body 追加する時間割の情報
     * @returns 作成された時間割
     */
    @post create(
      @body body: AcademicService.TimetableItemRequest,
    ): CreatedResponse &
      Body<{
        item: AcademicService.TimetableItem;
      }>;

    /**
     * 時間割を削除する
     * @param id 時間割ID
     * @returns 削除された時間割
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/users")
  @tag("Users")
  interface UsersV1 {
    /**
     * ユーザーを取得する
     * @param id ユーザーID
     * @returns ユーザーの情報
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        user: UserService.User;
      }>;
  }
}
