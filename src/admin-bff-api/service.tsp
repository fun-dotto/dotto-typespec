import "@typespec/http";
import "@typespec/openapi";

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
    @get list(@query q?: string): (OkResponse &
      Body<{
        faculties: AcademicService.Faculty[];
      }>) | UnauthorizedResponse;

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
    @get list(@query userId: string, @query dates: plainDate[]): (OkResponse &
      Body<{
        personalCalendarItems: AcademicService.PersonalCalendarItem[];
      }>) | UnauthorizedResponse;
  }

  @route("/v1/cancelledClasses")
  @tag("CancelledClasses")
  interface CancelledClassesV1 {
    /**
     * 休講一覧を取得する
     * @param subjectIds 科目IDのリスト; 指定した科目の休講のみを取得する; 指定しない場合は全科目を検索対象とする
     * @param from 検索対象開始日付
     * @param until 検索対象終了日付
     * @returns 休講のリスト
     */
    @get list(
      @query subjectIds?: string[],
      @query(#{ explode: true }) from?: plainDate,
      @query(#{ explode: true }) until?: plainDate,
    ): (OkResponse &
      Body<{
        cancelledClasses: AcademicService.CancelledClass[];
      }>) | UnauthorizedResponse;

    /**
     * 休講を作成する
     * @param body 作成する休講の情報
     * @returns 作成された休講
     */
    @post create(
      @body body: AcademicService.CancelledClassRequest,
    ): (CreatedResponse &
      Body<{
        cancelledClass: AcademicService.CancelledClass;
      }>) | UnauthorizedResponse;

    /**
     * 教務システムから休講を取得する
     * @returns 新たに取得された休講
     */
    @put fetch(): (OkResponse &
      Body<{
        cancelledClasses: AcademicService.CancelledClass[];
      }>) | UnauthorizedResponse;

    /**
     * 休講を削除する
     * @param id 休講ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/notifications")
  @tag("Notifications")
  interface NotificationV1 {
    /**
     * 通知の一覧を取得する
     * @param notifyAtFrom 通知予定日時の開始日時 (notifyAt >= notifyAtFrom)
     * @param notifyAtTo 通知予定日時の終了日時 (notifyAt <= notifyAtTo)
     * @param isNotified 通知済みかどうか (true: 通知済みの通知のみ、false: 通知未済みの通知のみ、指定なし: 全ての通知)
     * @returns 通知の一覧
     */
    @get list(
      @query(#{ explode: true }) notifyAtFrom?: utcDateTime,
      @query(#{ explode: true }) notifyAtTo?: utcDateTime,
      @query isNotified?: boolean,
    ): OkResponse &
      Body<{
        notifications: UserService.Notification[];
      }>;

    /**
     * 通知を作成する
     * 存在しない場合は作成し、存在する場合は更新日時を更新する
     * @param body 作成する通知の情報
     * @returns 作成された通知
     */
    @post create(@body body: UserService.NotificationRequest): CreatedResponse &
      Body<{
        notification: UserService.Notification;
      }>;

    /**
     * 通知を更新する
     * @param id 通知ID
     * @param body 更新する通知の情報
     * @returns 更新された通知
     */
    @put update(
      @path id: string,
      @body body: UserService.NotificationRequest,
    ): (OkResponse &
      Body<{
        notification: UserService.Notification;
      }>) | NotFoundResponse;

    /**
     * 通知を削除する
     * @param id 通知ID
     * @returns
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/makeupClasses")
  @tag("MakeupClasses")
  interface MakeupClassesV1 {
    /**
     * 補講一覧を取得する
     * @param subjectIds 科目IDのリスト; 指定した科目の補講のみを取得する; 指定しない場合は全科目を検索対象とする
     * @param from 検索対象開始日付
     * @param until 検索対象終了日付
     * @returns 補講のリスト
     */
    @get list(
      @query subjectIds?: string[],
      @query(#{ explode: true }) from?: plainDate,
      @query(#{ explode: true }) until?: plainDate,
    ): (OkResponse &
      Body<{
        makeupClasses: AcademicService.MakeupClass[];
      }>) | UnauthorizedResponse;

    /**
     * 補講を作成する
     * @param body 作成する補講の情報
     * @returns 作成された補講
     */
    @post create(
      @body body: AcademicService.MakeupClassRequest,
    ): (CreatedResponse &
      Body<{
        makeupClass: AcademicService.MakeupClass;
      }>) | UnauthorizedResponse;

    /**
     * 教務システムから補講を取得する
     * @returns 新たに取得された補講
     */
    @put fetch(): (OkResponse &
      Body<{
        makeupClasses: AcademicService.MakeupClass[];
      }>) | UnauthorizedResponse;

    /**
     * 補講を削除する
     * @param id 補講ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/roomChanges")
  @tag("RoomChanges")
  interface RoomChangesV1 {
    /**
     * 教室変更一覧を取得する
     * @param subjectIds 科目IDのリスト; 指定した科目の教室変更のみを取得する; 指定しない場合は全科目を検索対象とする
     * @param from 検索対象開始日付
     * @param until 検索対象終了日付
     * @returns 教室変更のリスト
     */
    @get list(
      @query subjectIds?: string[],
      @query(#{ explode: true }) from?: plainDate,
      @query(#{ explode: true }) until?: plainDate,
    ): (OkResponse &
      Body<{
        roomChanges: AcademicService.RoomChange[];
      }>) | UnauthorizedResponse;

    /**
     * 教室変更を作成する
     * @param body 作成する教室変更の情報
     * @returns 作成された教室変更
     */
    @post create(
      @body body: AcademicService.RoomChangeRequest,
    ): (CreatedResponse &
      Body<{
        roomChange: AcademicService.RoomChange;
      }>) | UnauthorizedResponse;

    /**
     * 教務システムから教室変更を取得する
     * @returns 新たに取得された教室変更
     */
    @put fetch(): (OkResponse &
      Body<{
        roomChanges: AcademicService.RoomChange[];
      }>) | UnauthorizedResponse;

    /**
     * 教室変更を削除する
     * @param id 教室変更ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/rooms")
  @tag("Rooms")
  interface RoomsV1 {
    /**
     * 教室一覧を取得する
     * @param q 検索ワード; 部屋名・部屋番号・教員名の部分一致検索される
     * @param floors 階数; 指定した場合は指定した階数の部屋のみを取得する
     * @returns 教室のリスト
     */
    @get list(
      @query q?: string,
      @query floors?: DottoFoundationV1.Floor[],
    ): (OkResponse &
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
      @query(#{ explode: true }) from?: utcDateTime,
      @query(#{ explode: true }) until?: utcDateTime,
    ): (OkResponse &
      Body<{
        reservations: AcademicService.Reservation[];
      }>) | UnauthorizedResponse;

    /**
     * 予約を詳細取得する
     * @param id 予約ID
     * @returns 予約の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        reservation: AcademicService.Reservation;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * 教室を予約する
     * @param body 予約する教室の情報
     * @returns 作成された予約
     */
    @post create(
      @body body: AcademicService.ReservationRequest,
    ): (CreatedResponse &
      Body<{
        reservation: AcademicService.Reservation;
      }>) | UnauthorizedResponse;

    /**
     * 予約を削除する
     * @param id 予約ID
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
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
        subjects: AcademicService.Subject[];
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
    @get list(): (OkResponse &
      Body<{
        users: UserService.User[];
      }>) | UnauthorizedResponse;

    /**
     * ユーザーを取得する
     * @param id ユーザーID
     * @returns ユーザーの情報
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        user: UserService.User;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * ユーザーを作成または更新する
     * @param body 作成または更新するユーザーの情報
     * @returns 作成または更新されたユーザー
     */
    @post upsert(
      @path id: string,
      @body body: UserService.UserRequest,
    ): (OkResponse &
      Body<{
        user: UserService.User;
      }>) | UnauthorizedResponse;
  }

  @route("/v1/fcmTokens")
  @tag("FCM Tokens")
  interface FCMTokenV1 {
    /**
     * FCMトークンの一覧を取得する
     * @param userIds ユーザーIDの一覧
     * @param tokens FCMトークンの一覧
     * @param updatedAtFrom 更新日時の開始日時 (updatedAt >= updatedAtFrom)
     * @param updatedAtTo 更新日時の終了日時 (updatedAt <= updatedAtTo)
     * @returns FCMトークンの一覧
     */
    @get list(
      @query userIds?: string[],
      @query tokens?: string[],
      @query(#{ explode: true }) updatedAtFrom?: utcDateTime,
      @query(#{ explode: true }) updatedAtTo?: utcDateTime,
    ): (OkResponse &
      Body<{
        fcmTokens: UserService.FCMToken[];
      }>) | UnauthorizedResponse;

    /**
     * FCMトークンを作成または更新する
     * 存在しない場合は作成し、存在する場合は更新日時を更新する
     * @param body 作成または更新するFCMトークンの情報
     * @returns 作成または更新されたFCMトークン
     */
    @post upsert(@body body: UserService.FCMTokenRequest): (OkResponse &
      Body<{
        fcmToken: UserService.FCMToken;
      }>) | UnauthorizedResponse;
  }

  @route("/v1/menuItems")
  @tag("MenuItems")
  interface MenuItemsV1 {
    /**
     * メニューを取得する
     * @param date メニューを取得する日付
     * @returns メニューのリスト
     */
    @get list(@query date: plainDate): (OkResponse &
      Body<{
        menuItems: FunchService.MenuItem[];
      }>) | UnauthorizedResponse;
  }

  @route("/v1/facultyRooms")
  @tag("FacultyRooms")
  interface FacultyRoomsV1 {
    /**
     * 教員室を取得する
     *
     * @param year 年度; 指定しない場合は今年度が選択される
     * @returns 教員室のリスト
     */
    @get list(@query year?: integer): (OkResponse &
      Body<{
        facultyRooms: AcademicService.FacultyRoom[];
      }>) | UnauthorizedResponse;

    /**
     * 教員室を追加する
     * @param body 追加する教員室の情報
     * @returns 作成された教員室
     */
    @post create(
      @body body: AcademicService.FacultyRoomRequest,
    ): (CreatedResponse &
      Body<{
        facultyRoom: AcademicService.FacultyRoom;
      }>) | UnauthorizedResponse;

    /**
     * 教員室を削除する
     * @param id 教員室ID
     * @returns 削除された教員室
     */
    @delete delete(
      @path id: string,
    ): NoContentResponse | NotFoundResponse | UnauthorizedResponse;
  }
}
