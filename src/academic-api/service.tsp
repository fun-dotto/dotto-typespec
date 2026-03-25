import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Academic Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://academic-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://academic-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://academic-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://academic-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace AcademicService {
  @route("/v1/subjects")
  @tag("Subjects")
  interface SubjectsV1 {
    /**
     * 科目一覧を取得する
     *
     * 同一項目同士はOR、異なる項目同士はANDでフィルタリングされます。
     *
     * @param ids 科目IDのリスト; 指定した場合は指定した科目IDのみを取得する
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
      @query ids?: string[],
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
        subjects: SubjectSummary[];
      }>;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        subject: Subject;
      }>) | NotFoundResponse;

    /**
     * 科目を作成または更新する
     * @param body 作成または更新する科目の情報
     * @returns 作成または更新された科目
     */
    @post upsert(@body body: SubjectRequest): (OkResponse &
      Body<{
        subject: Subject;
      }>) | BadRequestResponse;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/subjects/{id}/syllabus")
  @tag("Syllabus")
  interface SyllabusV1 {
    /**
     * シラバスを取得する
     * @param id 科目ID
     * @returns シラバス
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        syllabus: Syllabus;
      }>) | NotFoundResponse;
  }

  @route("/v1/faculties")
  @tag("Faculties")
  interface FacultiesV1 {
    /**
     * 教員一覧を取得する
     * @param ids 教員IDのリスト; 指定した場合は指定した教員IDのみを取得する
     * @returns 教員のリスト
     */
    @get list(@query ids?: string[]): OkResponse &
      Body<{
        faculties: Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        faculty: Faculty;
      }>) | NotFoundResponse;

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
    @put update(@path id: string, @body body: FacultyRequest): (OkResponse &
      Body<{
        faculty: Faculty;
      }>) | NotFoundResponse;

    /**
     * 教員を削除する
     * @param id 教員ID
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/courseRegistrations")
  @tag("CourseRegistrations")
  interface CourseRegistrationsV1 {
    /**
     * 履修情報を取得する
     * @param userId ユーザーID
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semesters 開講時期; 指定された時期に開講される全ての科目が取得される
     * @returns 履修情報のリスト
     */
    @get list(
      @query userId: string,
      @query year?: integer,
      @query semesters: DottoFoundationV1.CourseSemester[],
    ): (OkResponse &
      Body<{
        courseRegistrations: CourseRegistration[];
      }>) | NotFoundResponse;

    /**
     * 履修情報を作成する
     * @param body 作成する履修情報の情報
     * @returns 作成された履修情報
     */
    @post create(@body body: CourseRegistrationRequest): (CreatedResponse &
      Body<{
        courseRegistration: CourseRegistration;
      }>) | BadRequestResponse;

    /**
     * 履修情報を削除する
     * @param id 履修情報ID
     * @returns 削除された履修情報
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/timetableItems")
  @tag("TimetableItems")
  interface TimetableItemsV1 {
    /**
     * 時間割を取得する
     *
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semesters 開講時期; 指定された時期に開講される全ての科目が取得される
     * @returns 時間割のリスト
     */
    @get list(
      @query year?: integer,
      @query semesters: DottoFoundationV1.CourseSemester[],
    ): OkResponse &
      Body<{
        timetableItems: TimetableItem[];
      }>;

    /**
     * 時間割に追加する
     * @param body 追加する時間割の情報
     * @returns 作成された時間割
     */
    @post create(@body body: TimetableItemRequest): CreatedResponse &
      Body<{
        timetableItem: TimetableItem;
      }>;

    /**
     * 時間割を削除する
     * @param id 時間割ID
     * @returns 削除された時間割
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/personalCalendarItems")
  @tag("PersonalCalendarItems")
  interface PersonalCalendarItemsV1 {
    /**
     * 個人カレンダーアイテム一覧を取得する
     *
     * @param from 開始日時
     * @param until 終了日時
     * @returns 個人カレンダーアイテムのリスト
     */
    @get list(
      @query from?: utcDateTime,
      @query until?: utcDateTime,
    ): OkResponse &
      Body<{
        personalCalendarItems: PersonalCalendarItem[];
      }>;

    /**
     * 個人カレンダーアイテムを作成する
     * @param body 作成する個人カレンダーアイテムの情報
     * @returns 作成された個人カレンダーアイテム
     */
    @post create(
      @body body: PersonalCalendarItemRequest,
    ): CreatedResponse &
      Body<{
        personalCalendarItem: PersonalCalendarItem;
      }>;

    /**
     * 個人カレンダーアイテムを削除する
     * @param id 個人カレンダーアイテムID
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
  }

  @route("/v1/rooms")
  @tag("Rooms")
  interface RoomsV1 {
    /**
     * 教室一覧を取得する
     * @param ids 教室IDのリスト; 指定した場合は指定した教室IDのみを取得する
     * @param floor 階数; 指定した場合は指定した階数の教室のみを取得する
     * @returns 教室のリスト
     */
    @get list(
      @query ids?: string[],
      @query floor?: DottoFoundationV1.Floor[],
    ): OkResponse &
      Body<{
        rooms: Room[];
      }>;

    /**
     * 教室を詳細取得する
     * @param id 教室ID
     * @returns 教室の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        room: Room;
      }>) | NotFoundResponse;

    /**
     * 教室を作成する
     * @param body 作成する教室の情報
     * @returns 作成された教室
     */
    @post create(@body body: RoomRequest): CreatedResponse &
      Body<{
        room: Room;
      }>;

    /**
     * 教室を更新する
     * @param id 教室ID
     * @param body 更新する教室の情報
     * @returns 更新された教室
     */
    @put update(@path id: string, @body body: RoomRequest): (OkResponse &
      Body<{
        room: Room;
      }>) | NotFoundResponse;

    /**
     * 教室を削除する
     * @param id 教室ID
     */
    @delete delete(@path id: string): NoContentResponse | NotFoundResponse;
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
        reservations: Reservation[];
      }>;
  }
}
