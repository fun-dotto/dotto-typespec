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
  model Course {
    id: string;
  }
  model Grade {
    id: string;
  }
  model Class {
    id: string;
  }
  model AcademicArea {
    id: string;
  }
  model OpeningPeriod {
    id: string;
  }
  model CourseIntermediateCategory {
    id: string;
  }
  model CourseChildCategory {
    id: string;
  }
}
