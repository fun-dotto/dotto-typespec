namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isAvailable: boolean;
  }

  model AnnouncementCreateRequest {
    title: string;
    date: utcDateTime;
    url: url;
    isAvailable: boolean;
  }

  model AnnouncementUpdateRequest {
    title?: string;
    date?: utcDateTime;
    url?: url;
    isAvailable?: boolean;
  }
}
