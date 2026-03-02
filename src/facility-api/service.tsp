import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Facility Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://facility-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://facility-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://facility-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://facility-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace FacilityService {
  @route("/v1/rooms")
  @tag("Rooms")
  interface RoomsV1 {
    /**
     * 教室一覧を取得する
     * @param ids 教室IDのリスト; 指定した場合は指定した教室IDのみを取得する
     * @param floor 階数; 指定した場合は指定した階数の教室のみを取得する
     * @returns 教室のリスト
     */
    @get list(
      @query ids?: string[],
      @query floor?: DottoFoundationV1.Floor[],
    ): OkResponse &
      Body<{
        rooms: Room[];
      }>;

    /**
     * 教室を詳細取得する
     * @param id 教室ID
     * @returns 教室の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        room: Room;
      }>;

    /**
     * 教室を作成する
     * @param body 作成する教室の情報
     * @returns 作成された教室
     */
    @post create(@body body: RoomRequest): CreatedResponse &
      Body<{
        room: Room;
      }>;

    /**
     * 教室を更新する
     * @param id 教室ID
     * @param body 更新する教室の情報
     * @returns 更新された教室
     */
    @put update(@path id: string, @body body: RoomRequest): OkResponse &
      Body<{
        room: Room;
      }>;

    /**
     * 教室を削除する
     * @param id 教室ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/rooms/{id}/reservations")
  @tag("Reservations")
  interface ReservationsV1 {
    /**
     * 教室の予約一覧を取得する
     * @param id 教室ID
     * @param from 開始日時
     * @param until 終了日時
     * @returns 予約のリスト
     */
    @get list(
      @path id: string,
      @query from?: utcDateTime,
      @query until?: utcDateTime,
    ): OkResponse &
      Body<{
        reservations: Reservation[];
      }>;
  }
}
