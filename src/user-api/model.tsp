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
    /**
     * 通知ID
     */
    id: string;

    /**
     * 通知タイトル
     */
    title: string;

    /**
     * 通知本文
     */
    body: string;

    /**
     * 通知に表示する画像のURL
     */
    imageUrl?: string;

    /**
     * Firebase Analytics に記録する分析ラベル
     *
     * 通知の開封率計測などに利用
     */
    analyticsLabel?: string;

    /**
     * APNs のバッジ数
     *
     * アプリアイコンに表示される数値。0 でバッジを消去
     */
    apnsBadge?: integer;

    /**
     * APNs の通知音
     *
     * - "default": OS 標準の通知音
     * - "" または省略: 無音
     * - 任意のファイル名（例: "alert.caf"）: アプリバンドルまたは Library/Sounds/ に同梱されたカスタムサウンド
     *   対応フォーマットは .caf / .aiff / .wav（Linear PCM, MA4, µ-law, a-law）、最大30秒
     */
    apnsSound?: string;

    /**
     * APNs の content-available フラグ
     *
     * true でサイレントプッシュ（バックグラウンド更新）になる
     */
    apnsContentAvailable?: boolean;

    /**
     * Android の通知チャンネルID
     *
     * Android 8.0 以降、通知はチャンネル単位で管理される
     */
    androidChannelId?: string;

    /**
     * Android の通知優先度
     *
     * "normal" または "high"。"high" は即時配信される
     */
    androidPriority?: string;

    /**
     * Android の通知TTL（秒）
     *
     * FCM がメッセージを保持する最大時間。期限切れで破棄される
     */
    androidTtlSeconds?: integer;

    /**
     * Web Push 通知をクリックした際に開くURL
     */
    webpushLink?: string;

    /**
     * 通知をタップした時に開くURL
     * アプリを開くのみの場合は未指定
     */
    url?: string;

    /**
     * 通知送信可能になる日時（この時刻以降に送信対象となる）
     */
    notifyAfter: utcDateTime;

    /**
     * 通知送信期限日時（この時刻を過ぎた場合は送信しない）
     */
    notifyBefore: utcDateTime;

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
    /**
     * 通知タイトル
     */
    title: string;

    /**
     * 通知本文
     */
    body: string;

    /**
     * 通知に表示する画像のURL
     */
    imageUrl?: string;

    /**
     * Firebase Analytics に記録する分析ラベル
     */
    analyticsLabel?: string;

    /**
     * APNs のバッジ数
     */
    apnsBadge?: integer;

    /**
     * APNs の通知音
     *
     * - "default": OS 標準の通知音
     * - "" または省略: 無音
     * - 任意のファイル名（例: "alert.caf"）: アプリバンドルまたは Library/Sounds/ に同梱されたカスタムサウンド
     *   対応フォーマットは .caf / .aiff / .wav（Linear PCM, MA4, µ-law, a-law）、最大30秒
     */
    apnsSound?: string;

    /**
     * APNs の content-available フラグ（true でサイレントプッシュ）
     */
    apnsContentAvailable?: boolean;

    /**
     * Android の通知チャンネルID
     */
    androidChannelId?: string;

    /**
     * Android の通知優先度（"normal" または "high"）
     */
    androidPriority?: string;

    /**
     * Android の通知TTL（秒）
     */
    androidTtlSeconds?: integer;

    /**
     * Web Push 通知をクリックした際に開くURL
     */
    webpushLink?: string;

    /**
     * 通知をタップした時に開くURL
     * アプリを開くのみの場合は未指定
     */
    url?: string;

    /**
     * 通知送信可能になる日時（この時刻以降に送信対象となる）
     */
    notifyAfter: utcDateTime;

    /**
     * 通知送信期限日時（この時刻を過ぎた場合は送信しない）
     */
    notifyBefore: utcDateTime;

    /**
     * 対象ユーザーIDのリスト
     */
    targetUserIds: string[];
  }
}
