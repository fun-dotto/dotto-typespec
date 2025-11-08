import "@typespec/http";
import "@typespec/openapi";

using Http;
using OpenAPI;

@service(#{ title: "Announcement Service" })
namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }

  @route("/announcements")
  @tag("Announcements")
  interface Announcements {
    /** List announcements */
    @get list(): Announcement[];
  }
}
