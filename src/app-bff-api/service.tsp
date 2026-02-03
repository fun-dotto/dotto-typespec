import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "App BFF Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://app-bff-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://app-bff-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://app-bff-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://app-bff-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace AppBFFService {
  @route("/announcements")
  @tag("Announcements")
  interface AnnouncementsV0 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): Announcement[];
  }

  @route("/v1/announcements")
  @tag("Announcements")
  interface AnnouncementsV1 {
    /**
     * @returns おしらせのリスト
     */
    @get list(): Body<{
      announcements: Announcement[];
    }>;
  }
  @route("/courses")
  @tag("Courses")
  interface Courses {
    /**
     * @returns コースのリスト
     */
    @get list(@query name?: string): Course[];
  }
  @route("/grades")
  @tag("Grades")
  interface Grades {
    /**
     * @returns 学年のリスト
     */
    @get list(@query name?: string): Grade[];
  }
  @route("/classes")
  @tag("Classes")
  interface Classes {
    /**
     * @returns クラスのリスト
     */
    @get list(@query name?: string): Class[];
  }
  @route("/academic-areas")
  @tag("AcademicAreas")
  interface AcademicAreas {
    /**
     * @returns 所属コースのリスト
     */
    @get list(@query name?: string): AcademicArea[];
  }
  @route("opening-periods")
  @tag("OpeningPeriods")
  interface OpeningPeriods {
    /**
     * @returns 学期のリスト
     */
    @get list(@query name?: string): OpeningPeriod[];
  }
  @route("course-intermediate-categories")
  @tag("CourseIntermediateCategories")
  interface CourseIntermediateCategories {
    /**
     * @returns コースのリスト
     */
    @get list(@query name?: string): CourseIntermediateCategory[];
  }
  @route("course-child-categories")
  @tag("CourseChildCategories")
  interface CourseChildCategories {
    /**
     * @returns コースのリスト
     */
    @get list(@query name?: string): CourseChildCategory[];
  }
}
