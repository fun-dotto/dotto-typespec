import "@typespec/http";
import "@typespec/openapi";

using Http;
using OpenAPI;

@service(#{ title: "App BFF Service" })
namespace AppBFFService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
  }

  @route("/announcements")
  @tag("Announcements")
  interface Announcements {
    /** List announcements */
    @get list(): Announcement[];
  }
}
