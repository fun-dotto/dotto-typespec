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
  @route("/announcements")
  @tag("Announcements")
  interface Announcements {
    /**
     * @returns おしらせのリスト
     */
    @get list(): Body<{
      announcements: Announcement[];
    }>;

    /**
     * おしらせを作成する
     * @param body 作成するおしらせの情報
     * @returns 作成されたおしらせ
     */
    @post create(@body body: AnnouncementCreateRequest): Body<{
      announcement: Announcement;
    }>;

    /**
     * おしらせを更新する
     * @param id おしらせID
     * @param body 更新するおしらせの情報
     * @returns 更新されたおしらせ
     */
    @put update(@path id: string, @body body: AnnouncementUpdateRequest): Body<{
      announcement: Announcement;
    }>;

    /**
     * おしらせを削除する
     * @param id おしらせID
     */
    @delete delete(@path id: string): void;
  }
}
