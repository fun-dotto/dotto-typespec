namespace UserService {
  model User {
    /**
     * ユーザーID
     *
     * Firebase Authentication の UID
     */
    id: string;

    /**
     * メールアドレス
     * 
     * Firebase Authentication のメールアドレス
     */
    email: string;

    /**
     * 学年
     */
    grade?: DottoFoundationV1.Grade;

    /**
     * コース
     */
    course?: DottoFoundationV1.Course;

    /**
    * クラス
    */
    class?: DottoFoundationV1.Class;
  }

  model UserRequest {
    email: string;
    grade?: DottoFoundationV1.Grade;
    course?: DottoFoundationV1.Course;
    class?: DottoFoundationV1.Class;
  }

  model FCMToken {
    /**
     * FCMトークン
     */
    token: string;

    /**
     * ユーザーID
     */
    userId: string;

    /**
     * 作成日時
     */
    createdAt: string;

    /**
     * 更新日時
     */
    updatedAt: string;
  }

  model FCMTokenRequest {
    userId: string;
    token: string;
  }
}
