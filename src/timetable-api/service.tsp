import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Timetable Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://timetable-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://timetable-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://timetable-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://timetable-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace TimetableService {
  @route("/v1/itmes")
  @tag("Items")
  interface ItemsV1 {
    /**
     * 時間割を取得する
     *
     * @param year 開講年度; 指定しない場合は今年度が選択される
     * @param semester 開講時期
     * @param dayOfWeek 曜日; 複数指定時はORでフィルタリングされる; 指定しない場合は全ての曜日が選択される
     * @returns 時間割のリスト
     */
    @get list(
      @query year?: integer,
      @query semester: DottoFoundationV1.CourseSemester,
      @query dayOfWeek: DottoFoundationV1.DayOfWeek[],
    ): OkResponse &
      Body<{
        items: Item[];
      }>;

    /**
     * 時間割に追加する
     * @param body 追加する時間割の情報
     * @returns 作成された時間割
     */
    @post create(@body body: ItemRequest): CreatedResponse &
      Body<{
        item: Item;
      }>;

    /**
     * 時間割を削除する
     * @param id 時間割ID
     * @returns 削除された時間割
     */
    @delete delete(@path id: string): NoContentResponse;
  }
}
