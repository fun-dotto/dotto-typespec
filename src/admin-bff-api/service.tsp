import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

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
     * @param filterIsActive
     * 公開状態で絞り込むか
     *
     * 公開状態のみを抽出する場合は`true`を指定
     * @returns おしらせのリスト
     */
    @get list(@query filterIsActive?: boolean = false): OkResponse &
      Body<{
        announcements: Announcement[];
      }>;

    /**
     * おしらせを詳細取得する
     * @param id おしらせID
     * @returns おしらせの詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        announcement: Announcement;
      }>;

    /**
     * おしらせを作成する
     * @param body 作成するおしらせの情報
     * @returns 作成されたおしらせ
     */
    @post create(@body body: AnnouncementRequest): CreatedResponse &
      Body<{
        announcement: Announcement;
      }>;

    /**
     * おしらせを更新する
     * @param id おしらせID
     * @param body 更新するおしらせの情報
     * @returns 更新されたおしらせ
     */
    @put update(@path id: string, @body body: AnnouncementRequest): OkResponse &
      Body<{
        announcement: Announcement;
      }>;

    /**
     * おしらせを削除する
     * @param id おしらせID
     */
    @delete delete(@path id: string): NoContentResponse;
  }
}
