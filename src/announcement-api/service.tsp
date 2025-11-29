import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Announcement Service" })
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
namespace AnnouncementService {
  @route("/announcements")
  @tag("Announcements")
  interface Announcements {
    /**
     * @param sortByDateAsc
     * 日時昇順ソートするか
     *
     * 降順ソートの場合はfalseを指定
     *
     * デフォルト値はtrue (昇順ソート)
     * @param filterIsActive
     * 公開状態で絞り込むか
     *
     * 公開状態ではないもののみを抽出する場合はfalseを指定
     *
     * デフォルト値はnull (すべての公開状態を含む)
     * @returns おしらせのリスト
     */
    @get list(
      @query sortByDateAsc?: boolean,
      @query filterIsActive?: boolean,
    ): Announcement[];
  }
}
