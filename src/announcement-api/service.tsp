import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";
import "../foundation/sortDirection.tsp";

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
  /**
   * @deprecated
   * 非推奨: 代わりに`AnnouncementsV1`を使用してください
   */
  @route("/announcements")
  @tag("Announcements")
  interface AnnouncementsV0 {
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

  @route("/v1/announcements")
  @tag("Announcements")
  interface AnnouncementsV1 {
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
    ): Body<{
      announcements: Announcement[];
    }>;

    /**
     * おしらせを作成する
     * @param body 作成するおしらせの情報
     * @returns 作成されたおしらせ
     */
    @post create(@body body: AnnouncementRequest): Body<{
      announcement: Announcement;
    }>;

    /**
     * おしらせを更新する
     * @param id おしらせID
     * @param body 更新するおしらせの情報
     * @returns 更新されたおしらせ
     */
    @put update(@path id: string, @body body: AnnouncementRequest): Body<{
      announcement: Announcement;
    }>;

    /**
     * おしらせを削除する
     * @param id おしらせID
     */
    @delete delete(@path id: string): void;
  }
}
