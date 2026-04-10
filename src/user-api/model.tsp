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
    createdAt: utcDateTime;

    /**
     * 更新日時
     */
    updatedAt: utcDateTime;
  }

  model FCMTokenRequest {
    userId: string;
    token: string;
  }

  model Notification {
    id: string;
    title: string;
    message: string;

    /**
     * 通知をタップした時に開くURL
     * アプリを開くのみの場合はnull
     */
    url?: string;

    /**
     * 通知予定日時
     */
    notifyAt: string;

    /**
     * 通知が送信されたかどうか
     */
    isNotified: boolean;

    /**
     * 対象ユーザーIDのリスト
     */
    targetUserIds: string[];
  }

  model NotificationRequest {
    title: string;
    message: string;
    url?: string;
    notifyAt: string;
    targetUserIds: string[];
  }
}
