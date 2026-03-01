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

}
