namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }
}
