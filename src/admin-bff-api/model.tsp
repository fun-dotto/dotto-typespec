namespace AdminBFFService {
  model Announcement {
    id: string;
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }

  model AnnouncementRequest {
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }
}
