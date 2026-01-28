namespace AppBFFServiceV0 {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
  }
}

namespace AppBFFServiceV1 {
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
