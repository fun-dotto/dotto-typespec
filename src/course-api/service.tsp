import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Course Service" })
@info(#{ version: "1.0.0" })
@server("https://course-api-107577467292.asia-northeast1.run.app", "Production")
@server("https://course-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://course-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://course-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace CourseService {
  @route("/v1/registrations")
  @tag("Registrations")
  interface RegistrationsV1 {
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
        registrations: Registration[];
      }>;

    /**
     * 履修情報を作成する
     * @param body 作成する履修情報の情報
     * @returns 作成された履修情報
     */
    @post create(@body body: RegistrationRequest): CreatedResponse &
      Body<{
        registration: Registration;
      }>;

    /**
     * 履修情報を削除する
     * @param id 履修情報ID
     * @returns 削除された履修情報
     */
    @delete delete(@path id: string): NoContentResponse;
  }
}
