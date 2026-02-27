namespace DottoFoundationV1 {
  /**
   * 学年
   */
  enum Grade {
    B1,
    B2,
    B3,
    B4,
    M1,
    M2,
    D1,
    D2,
    D3,
  }

  /**
   * クラス
   */
  enum Class {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
  }

  /**
   * 開講時期
   */
  enum CourseSemester {
    /**
     * 通年
     */
    AllYear,

    /**
     * 前期
     */
    H1,

    /**
     * 後期
     */
    H2,

    /**
     * 第1クオーター
     */
    Q1,

    /**
     * 第2クオーター
     */
    Q2,

    /**
     * 第3クオーター
     */
    Q3,

    /**
     * 第4クオーター
     */
    Q4,

    /**
     * 夏期集中
     */
    SummerIntensive,

    /**
     * 冬期集中
     */
    WinterIntensive,
  }

  /**
   * 必修・選択
   */
  enum SubjectRequirementType {
    /**
     * 必修
     */
    Required,

    /**
     * 選択
     */
    Optional,

    /**
     * 選択必修
     */
    OptionalRequired,
  }

  /**
   * コース
   */
  enum Course {
    // 情報システムコース
    InformationSystem,

    // 情報デザインコース
    InformationDesign,

    // 高度ICTコース
    AdvancedICT,

    // 複雑系コース
    ComplexSystem,

    // 知能システムコース
    IntelligentSystem,
  }

  /**
   * 教員
   */
  model Faculty {
    id: string;
    name: string;
    email: string;
  }

  model FacultyRequest {
    name: string;
    email: string;
  }

  /**
   * 科目カテゴリ
   */
  enum SubjectClassification {
    // 専門
    Specialized,

    // 教養
    Cultural,

    // 研究指導
    ResearchInstruction,
  }

  /**
   * 教養科目カテゴリ
   */
  enum CulturalSubjectCategory {
    // 社会
    Society,

    // 人間
    Human,

    // 科学
    Science,

    // 健康
    Health,

    // コミュニケーション
    Communication,
  }
}
