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
     * ユーザーの一覧を取得する
     * @returns ユーザーの一覧
     */
    @get list(): OkResponse &
      Body<{
        users: User[];
      }>;

    /**
     * ユーザーを取得する
     * @param id ユーザーID
     * @returns ユーザーの情報
     */
    @get detail(@path id: string): (OkResponse &
      Body<{
        user: User;
      }>) | NotFoundResponse;

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
      @query updatedAtFrom?: utcDateTime,
      @query updatedAtTo?: utcDateTime
    ): OkResponse &
      Body<{
        fcmTokens: FCMToken[];
      }>;

    /**
     * FCMトークンを作成または更新する
     * 存在しない場合は作成し、存在する場合は更新日時を更新する
     * @param body 作成または更新するFCMトークンの情報
     * @returns 作成または更新されたFCMトークン
     */
    @post upsert(@body body: FCMTokenRequest): OkResponse &
      Body<{
        fcmToken: FCMToken;
      }>;
  }
}
