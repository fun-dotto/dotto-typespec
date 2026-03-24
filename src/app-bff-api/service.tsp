import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "App BFF Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://app-bff-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://app-bff-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://app-bff-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://app-bff-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
@useAuth(BearerAuth)
namespace AppBFFService {
  @route("/announcements")
  @tag("Announcements")
  interface AnnouncementsV0 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): Announcement[];
  }

  @route("/v1/announcements")
  @tag("Announcements")
  interface AnnouncementsV1 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): (OkResponse &
      Body<{
        announcements: Announcement[];
      }>) | UnauthorizedResponse;
  }

  @route("/v1/subjects")
  @tag("Subjects")
  interface SubjectsV1 {
    /**
     * 科目を検索する
     *
     * 同一項目同士はOR、異なる項目同士はANDでフィルタリングされます。
     *
     * @param q 検索ワード
     * @param grade 学年
     * @param courses コース; 大学院の場合は大学院コースに読み替え
     * @param class クラス; 大学院の学年を選択した場合は選択できない
     * @param classification 学部: 専門・教養; 大学院: 専門・研究指導
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
      @query semester?: DottoFoundationV1.CourseSemester[],
      @query requirementType?: DottoFoundationV1.SubjectRequirementType[],

      @query
      culturalSubjectCategory?: DottoFoundationV1.CulturalSubjectCategory[],
    ): (OkResponse &
      Body<{
        subjects: SubjectSummary[];
      }>) | UnauthorizedResponse;

    /**
     * @returns 科目の詳細
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        subject: SubjectDetail;
      }>) | NotFoundResponse | UnauthorizedResponse;
  }

  @route("/v1/users")
  @tag("Users")
  interface UsersV1 {
    /**
     * ユーザーを取得する
     * @returns ユーザーの情報
     */
    @get detail(): (OkResponse &
      Body<{
        user: UserInfo;
      }>) | NotFoundResponse | UnauthorizedResponse;

    /**
     * ユーザーを作成または更新する
     * @param body 作成または更新するユーザーの情報
     * @returns 作成または更新されたユーザー
     */
    @post upsert(@body body: UserInfo): (OkResponse &
      Body<{
        user: UserInfo;
      }>) | UnauthorizedResponse;
  }

  @route("/v1/timetableItems")
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
        timetableItems: TimetableItem[];
      }>) | UnauthorizedResponse;
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
      @query year?: integer,
      @query semesters: DottoFoundationV1.CourseSemester[],
    ): (OkResponse &
      Body<{
        courseRegistrations: CourseRegistration[];
      }>) | UnauthorizedResponse;

    /**
     * 履修情報を作成する
     * @param body 作成する履修情報の情報
     * @returns 作成された履修情報
     */
    @post create(@body body: CourseRegistrationRequest): (CreatedResponse &
      Body<{
        courseRegistration: CourseRegistration;
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
}
