import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Funch Service" })
@info(#{ version: "1.0.0" })
@server("https://funch-api-107577467292.asia-northeast1.run.app", "Production")
@server("https://funch-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server("https://funch-api-stg-107577467292.asia-northeast1.run.app", "Staging")
@server(
  "https://funch-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace FunchService {

}
