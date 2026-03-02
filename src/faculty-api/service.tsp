import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Faculty Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://faculty-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://faculty-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://faculty-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://faculty-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace FacultyService {
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
}
