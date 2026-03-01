import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Faculty Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://faculty-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://faculty-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://faculty-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://faculty-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace FacultyService {

}
