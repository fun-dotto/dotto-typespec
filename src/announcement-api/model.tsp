namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;

    @doc("非推奨: 代わりに`availableFrom`を使用してください")
    date: utcDateTime;

    @doc("非推奨: 代わりに`availableTo`を使用してください")
    isActive: boolean;
  }

  model AnnouncementRequest {
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }
}
