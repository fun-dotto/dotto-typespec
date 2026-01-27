import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";
import "../foundation/sortDirection.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Announcement Service v0" })
@info(#{ version: "0.0.0" })
@server(
  "https://announcement-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server(
  "https://announcement-api-qa-107577467292.asia-northeast1.run.app",
  "QA"
)
@server(
  "https://announcement-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://announcement-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace AnnouncementServiceV0 {
  @route("/announcements")
  @tag("Announcements")
  interface Announcements {
    /**
     * @param sortByDate
     * 日時ソート
     *
     * 昇順ソートの場合は`asc`を指定、降順ソートの場合は`desc`を指定
     * @param filterIsActive
     * 公開状態で絞り込むか
     *
     * 公開状態のみを抽出する場合は`true`を指定
     * @returns おしらせのリスト
     */
    @get list(
      @query
      sortByDate?: FoundationV1.SortDirection = FoundationV1.SortDirection.Asc,

      @query filterIsActive?: boolean = false,
    ): Announcement[];
  }
}

@service(#{ title: "Announcement Service v1" })
@info(#{ version: "1.0.0" })
@server(
  "https://announcement-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server(
  "https://announcement-api-qa-107577467292.asia-northeast1.run.app",
  "QA"
)
@server(
  "https://announcement-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://announcement-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace AnnouncementServiceV1 {
  @route("/v1/announcements")
  @tag("Announcements")
  interface Announcements {
    /**
     * @param sortByDate
     * 日時ソート
     *
     * 昇順ソートの場合は`asc`を指定、降順ソートの場合は`desc`を指定
     * @param filterIsActive
     * 公開状態で絞り込むか
     *
     * 公開状態のみを抽出する場合は`true`を指定
     * @returns おしらせのリスト
     */
    @get list(
      @query
      sortByDate?: FoundationV1.SortDirection = FoundationV1.SortDirection.Asc,

      @query filterIsActive?: boolean = false,
    ): {
      announcements: Announcement[];
    };
  }
}
