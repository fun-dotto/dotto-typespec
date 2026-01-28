namespace AdminBFFService {
  model Announcement {
    id: string;
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }

  model AnnouncementCreateRequest {
    title: string;
    availableFrom: utcDateTime;
    availableUntil?: utcDateTime;
    url: url;
  }

  model AnnouncementUpdateRequest {
    title?: string;
    availableFrom?: utcDateTime;
    availableUntil?: utcDateTime;
    url?: url;
  }
}
