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
@useAuth(BearerAuth)
namespace AdminBFFService {
  @route("/v1/announcements")
  @tag("Announcements")
  interface AnnouncementsV1 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): (OkResponse &
      Body<{
        announcements: AnnouncementService.Announcement[];
      }>) | UnauthorizedResponse;

    /**
     * おしらせを詳細取得する
     * @param id おしらせID
     * @returns おしらせの詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * おしらせを作成する
     * @param body 作成するおしらせの情報
     * @returns 作成されたおしらせ
     */
    @post create(
      @body body: AnnouncementService.AnnouncementRequest,
    ): (CreatedResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>) | UnauthorizedResponse;

    /**
     * おしらせを更新する
     * @param id おしらせID
     * @param body 更新するおしらせの情報
     * @returns 更新されたおしらせ
     */
    @put update(
      @path id: string,
      @body body: AnnouncementService.AnnouncementRequest,
    ): (OkResponse &
      Body<{
        announcement: AnnouncementService.Announcement;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * おしらせを削除する
     * @param id おしらせID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/courseRegistrations")
  @tag("CourseRegistrations")
  interface CourseRegistrationsV1 {
    /**
     * 履修情報を取得する
     * @param userId ユーザーID
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semesters 開講時期
     * @returns 履修情報のリスト
     */
    @get list(
      @query userId: string,
      @query year?: integer,
      @query semesters: DottoFoundationV1.CourseSemester[],
    ): (OkResponse &
      Body<{
        registrations: AcademicService.CourseRegistration[];
      }>) | UnauthorizedResponse;

    /**
     * 履修情報を作成する
     * @param body 作成する履修情報の情報
     * @returns 作成された履修情報
     */
    @post create(
      @body body: AcademicService.CourseRegistrationRequest,
    ): (CreatedResponse &
      Body<{
        registration: AcademicService.CourseRegistration;
      }>) | UnauthorizedResponse;

    /**
     * 履修情報を削除する
     * @param id 履修情報ID
     * @returns 削除された履修情報
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/faculties")
  @tag("Faculties")
  interface FacultiesV1 {
    /**
     * 教員一覧を取得する
     * @param q 検索ワード; 教員の名前で部分一致検索される
     * @returns 教員のリスト
     */
    @get list(@query q?: string): OkResponse &
      Body<{
        faculties: AcademicService.Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 教員を作成する
     * @param body 作成する教員の情報
     * @returns 作成された教員
     */
    @post create(@body body: AcademicService.FacultyRequest): (CreatedResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>) | UnauthorizedResponse;

    /**
     * 教員を更新する
     * @param id 教員ID
     * @param body 更新する教員の情報
     * @returns 更新された教員
     */
    @put update(
      @path id: string,
      @body body: AcademicService.FacultyRequest,
    ): (OkResponse &
      Body<{
        faculty: AcademicService.Faculty;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 教員を削除する
     * @param id 教員ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/personalCalendarItems")
  @tag("PersonalCalendarItems")
  interface PersonalCalendarItemsV1 {
    /**
     * 個人カレンダーアイテム一覧を取得する
     *
     * @param userId ユーザーID
     * @param dates 日付のリスト; 指定した日付の個人カレンダーアイテムのみを取得する
     * @returns 個人カレンダーアイテムのリスト; 時間割、履修情報、休講補講、振替授業日情報から構築される
     */
    @get list(@query userId: string, @query dates: utcDateTime[]): OkResponse &
      Body<{
        personalCalendarItems: AcademicService.PersonalCalendarItem[];
      }>;
  }

  @route("/v1/rooms")
  @tag("Rooms")
  interface RoomsV1 {
    /**
     * 教室一覧を取得する
     * @returns 教室のリスト
     */
    @get list(@query floor?: DottoFoundationV1.Floor[]): (OkResponse &
      Body<{
        rooms: AcademicService.Room[];
      }>) | UnauthorizedResponse;

    /**
     * 教室を詳細取得する
     * @param id 教室ID
     * @returns 教室の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        room: AcademicService.Room;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 教室を作成する
     * @param body 作成する教室の情報
     * @returns 作成された教室
     */
    @post create(@body body: AcademicService.RoomRequest): (CreatedResponse &
      Body<{
        room: AcademicService.Room;
      }>) | UnauthorizedResponse;

    /**
     * 教室を更新する
     * @param id 教室ID
     * @param body 更新する教室の情報
     * @returns 更新された教室
     */
    @put update(
      @path id: string,
      @body body: AcademicService.RoomRequest,
    ): (OkResponse &
      Body<{
        room: AcademicService.Room;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 教室を削除する
     * @param id 教室ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/reservations")
  @tag("Reservations")
  interface ReservationsV1 {
    /**
     * 教室の予約一覧を取得する
     * 検索対象期間に一部でも重複する予約が取得される
     * @param roomIds 教室IDのリスト
     * @param from 検索対象開始日時
     * @param until 検索対象終了日時
     * @returns 予約のリスト
     */
    @get list(
      @query roomIds?: string[],
      @query from?: utcDateTime,
      @query until?: utcDateTime,
    ): OkResponse &
      Body<{
        reservations: AcademicService.Reservation[];
      }>;

    /**
     * 予約を詳細取得する
     * @param id 予約ID
     * @returns 予約の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        reservation: AcademicService.Reservation;
      }>) | NotFoundResponse;

    /**
      * 教室を予約する
      * @param body 予約する教室の情報
      * @returns 作成された予約
      */
    @post create(@body body: AcademicService.ReservationRequest): CreatedResponse &
    Body<{
      reservation: AcademicService.Reservation;
    }>;

    /**
     * 予約を削除する
     * @param id 予約ID
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
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
     * @param grades 学年
     * @param courses コース; 大学院の場合は大学院コースに読み替え
     * @param classes クラス; 大学院の学年を選択した場合は選択できない
     * @param classifications 学部: 専門・教養; 大学院: 専門・研究指導
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semesters 開講時期
     * @param requirementTypes 必修・選択・選択必修
     * @param culturalSubjectCategories 教養科目カテゴリ
     * @returns 科目のリスト
     */
    @get list(
      @query q?: string,
      @query grades?: DottoFoundationV1.Grade[],
      @query courses?: DottoFoundationV1.Course[],
      @query classes?: DottoFoundationV1.Class[],
      @query classifications?: DottoFoundationV1.SubjectClassification[],
      @query year?: integer,
      @query semesters?: DottoFoundationV1.CourseSemester[],
      @query requirementTypes?: DottoFoundationV1.SubjectRequirementType[],

      @query
      culturalSubjectCategories?: DottoFoundationV1.CulturalSubjectCategory[],
    ): (OkResponse &
      Body<{
        subjects: AcademicService.SubjectSummary[];
      }>) | UnauthorizedResponse;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        subject: AcademicService.Subject;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 科目を作成または更新する
     * @param body 作成または更新する科目の情報
     * @returns 作成または更新された科目
     */
    @post upsert(@body body: AcademicService.SubjectRequest): (OkResponse &
      Body<{
        subject: AcademicService.Subject;
      }>) | UnauthorizedResponse;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/timetableItmes")
  @tag("TimetableItems")
  interface TimetableItemsV1 {
    /**
     * 時間割を取得する
     *
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semesters 開講時期
     * @returns 時間割のリスト
     */
    @get list(
      @query year?: integer,
      @query semesters: DottoFoundationV1.CourseSemester[],
    ): (OkResponse &
      Body<{
        items: AcademicService.TimetableItem[];
      }>) | UnauthorizedResponse;

    /**
     * 時間割に追加する
     * @param body 追加する時間割の情報
     * @returns 作成された時間割
     */
    @post create(
      @body body: AcademicService.TimetableItemRequest,
    ): (CreatedResponse &
      Body<{
        item: AcademicService.TimetableItem;
      }>) | UnauthorizedResponse;

    /**
     * 時間割を削除する
     * @param id 時間割ID
     * @returns 削除された時間割
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/users")
  @tag("Users")
  interface UsersV1 {
    /**
     * ユーザーの一覧を取得する
     * @returns ユーザーの一覧
     */
    @get list(): OkResponse &
      Body<{
        users: UserService.User[];
      }>;

    /**
     * ユーザーを取得する
     * @param id ユーザーID
     * @returns ユーザーの情報
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        user: UserService.User;
      }>) | NotFoundResponse;

    /**
     * ユーザーを作成または更新する
     * @param body 作成または更新するユーザーの情報
     * @returns 作成または更新されたユーザー
     */
    @post upsert(@path id: string, @body body: UserService.UserRequest): OkResponse &
      Body<{
        user: UserService.User;
      }>;
  }
  
  @route("/v1/fcmTokens")
  @tag("FCM Tokens")
  interface FCMTokenV1 {
    /**
     * FCMトークンの一覧を取得する
     * @param userIds ユーザーIDの一覧
     * @param tokens FCMトークンの一覧
     * @param lastUpdatedAtFrom 更新日時の開始日時 (lastUpdatedAt >= lastUpdatedAtFrom)
     * @param lastUpdatedAtTo 更新日時の終了日時 (lastUpdatedAt <= lastUpdatedAtTo)
     * @returns FCMトークンの一覧
     */
    @get list(
      @query userIds?: string[],
      @query tokens?: string[],
      @query lastUpdatedAtFrom?: utcDateTime,
      @query lastUpdatedAtTo?: utcDateTime
    ): OkResponse &
      Body<{
        fcmTokens: UserService.FCMToken[];
      }>;

    /**
     * FCMトークンを作成または更新する
     * 存在しない場合は作成し、存在する場合は更新日時を更新する
     * @param body 作成または更新するFCMトークンの情報
     * @returns 作成または更新されたFCMトークン
     */
    @post upsert(@path id: string, @body body: UserService.FCMTokenRequest): OkResponse &
      Body<{
        fcmToken: UserService.FCMToken;
      }>;
  }
}
