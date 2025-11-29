import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;

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
     * @param sort
     */
    @get list(@query sort?: string): Announcement[];
  }
}
