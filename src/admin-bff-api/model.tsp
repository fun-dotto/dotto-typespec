namespace AdminBFFService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
  }

  model AnnouncementCreateRequest {
    title: string;
    date: utcDateTime;
    url: url;
  }

  model AnnouncementUpdateRequest {
    title?: string;
    date?: utcDateTime;
    url?: url;
  }
}
