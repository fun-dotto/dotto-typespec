namespace AnnouncementService {
  model Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }

  enum SortDirection {
    Asc: "asc",
    Desc: "desc",
  }
}

namespace AnnouncementServiceV1 {
  model V1Announcement {
    id: string;
    title: string;
    date: utcDateTime;
    url: url;
    isActive: boolean;
  }

  enum SortDirection {
    Asc: "asc",
    Desc: "desc",
  }
}
