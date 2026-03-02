import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "User Service" })
@info(#{ version: "1.0.0" })
@server("https://user-api-107577467292.asia-northeast1.run.app", "Production")
@server("https://user-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server("https://user-api-stg-107577467292.asia-northeast1.run.app", "Staging")
@server(
  "https://user-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace UserService {
  @route("/v1/users")
  @tag("Users")
  interface UsersV1 {
    /**
     * ユーザーを作成または更新する
     * @param body 作成または更新するユーザーの情報
     * @returns 作成または更新されたユーザー
     */
    @post upsert(@path id: string, @body body: UserRequest): OkResponse &
      Body<{
        user: User;
      }>;
  }
}
