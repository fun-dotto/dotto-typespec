namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }

  model AnnouncementCreateRequest {
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }

  model AnnouncementUpdateRequest {
    title?: string;
    date?: utcDateTime;
    url?: url;
    isActive?: boolean;
  }
}
