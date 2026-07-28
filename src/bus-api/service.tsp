import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Bus Service" })
@info(#{ version: "1.0.0" })
@server("https://bus-api-107577467292.asia-northeast1.run.app", "Production")
@server("https://bus-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server("https://bus-api-stg-107577467292.asia-northeast1.run.app", "Staging")
@server(
  "https://bus-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace BusService {
  @route("/v1/busTrips")
  @tag("BusTrips")
  interface BusTripsV1 {
    /**
     * バスの運行情報を取得する
     *
     * @param date バスの運行情報を取得する日付
     *
     * @returns バスの運行情報のリスト
     */
    @get list(@query(#{ explode: true }) date: plainDate): OkResponse &
      Body<{
        busTrips: BusTrip[];
      }>;
  }

  @route("/v1/busTrips/{tripId}/busTimetableStops")
  @tag("BusTimetableStops")
  interface BusTimetableStopsV1 {
    /**
     * バスの停車情報を取得する
     *
     * @param tripId 運行ID
     *
     * @returns バスの停車情報のリスト
     */
    @get list(@path tripId: string): OkResponse &
      Body<{
        busTimetableStops: BusTimetableStop[];
      }>;
  }
}
