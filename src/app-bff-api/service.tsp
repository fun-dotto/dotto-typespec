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
namespace AppBFFService {
  /**
   * @deprecated
   * 非推奨: 代わりに`AnnouncementsV1`を使用してください
   */
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
    @get list(): Body<{
      announcements: Announcement[];
    }>;
  }
}
