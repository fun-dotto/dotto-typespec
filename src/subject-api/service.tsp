import "@typespec/http";
import "@typespec/openapi";
import "./model.tsp";

using Http;
using OpenAPI;

@service(#{ title: "Subject Service" })
@info(#{ version: "1.0.0" })
@server(
  "https://subject-api-107577467292.asia-northeast1.run.app",
  "Production"
)
@server("https://subject-api-qa-107577467292.asia-northeast1.run.app", "QA")
@server(
  "https://subject-api-stg-107577467292.asia-northeast1.run.app",
  "Staging"
)
@server(
  "https://subject-api-dev-107577467292.asia-northeast1.run.app",
  "Development"
)
@server("http://localhost:8080", "Local")
namespace SubjectService {
  @route("/v1/faculties")
  @tag("Faculties")
  interface FacultiesV1 {
    /**
     * 教員一覧を取得する
     * @returns 教員のリスト
     */
    @get list(): OkResponse &
      Body<{
        faculties: DottoFoundationV1.Faculty[];
      }>;

    /**
     * 教員を詳細取得する
     * @param id 教員ID
     * @returns 教員の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        faculty: DottoFoundationV1.Faculty;
      }>;

    /**
     * 教員を作成する
     * @param body 作成する教員の情報
     * @returns 作成された教員
     */
    @post create(
      @body body: DottoFoundationV1.FacultyRequest,
    ): CreatedResponse &
      Body<{
        faculty: DottoFoundationV1.Faculty;
      }>;

    /**
     * 教員を更新する
     * @param id 教員ID
     * @param body 更新する教員の情報
     * @returns 更新された教員
     */
    @put update(
      @path id: string,
      @body body: DottoFoundationV1.FacultyRequest,
    ): OkResponse &
      Body<{
        faculty: DottoFoundationV1.Faculty;
      }>;

    /**
     * 教員を削除する
     * @param id 教員ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/subjects")
  @tag("Subjects")
  interface SubjectsV1 {
    /**
     * 科目一覧を取得する
     *
     * 同一項目同士はOR、異なる項目同士はANDでフィルタリングされます。
     *
     * @param q 検索ワード
     * @param grade 学年
     * @param courses コース; 大学院の場合は大学院コースに読み替え
     * @param class クラス; 大学院の学年を選択した場合は選択できない
     * @param classification 学部: 専門・教養; 大学院: 専門・研究指導
     * @param semester 開講時期
     * @param requirementType 必修・選択・選択必修
     * @param calturalSubjectCategory 教養科目カテゴリ
     * @returns 科目のリスト
     */
    @get list(
      @query q: string,
      @query grade: DottoFoundationV1.Grade[],
      @query courses: DottoFoundationV1.Course[],
      @query class: DottoFoundationV1.Class[],
      @query classification: DottoFoundationV1.SubjectClassification[],
      @query semester: DottoFoundationV1.CourseSemester[],
      @query requirementType: DottoFoundationV1.SubjectRequirementType[],
      @query calturalSubjectCategory: DottoFoundationV1.CulturalSubjectCategory[],
    ): OkResponse &
      Body<{
        subjects: SubjectSummary[];
      }>;

    /**
     * 科目を詳細取得する
     * @param id 科目ID
     * @returns 科目の詳細
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        subject: Subject;
      }>;

    /**
     * 科目を作成または更新する
     * @param body 作成する科目の情報
     * @returns 作成された科目
     */
    @put upsert(@body body: SubjectRequest): OkResponse &
      Body<{
        subject: Subject;
      }>;

    /**
     * 科目を削除する
     * @param id 科目ID
     */
    @delete delete(@path id: string): NoContentResponse;
  }

  @route("/v1/subjects/{id}/syllabus")
  @tag("Syllabus")
  interface SyllabusV1 {
    /**
     * シラバスを取得する
     * @param id 科目ID
     * @returns シラバス
     */
    @get detail(@path id: string): OkResponse &
      Body<{
        syllabus: Syllabus;
      }>;
  }
}
