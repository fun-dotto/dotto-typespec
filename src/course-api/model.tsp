namespace CourseService {
  model Registration {
    id: string;
    userId: string;
    subjectId: string;
  }

  model RegistrationRequest {
    userId: string;
    subjectId: string;
  }
}
