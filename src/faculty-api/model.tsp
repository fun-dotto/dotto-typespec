namespace FacultyService {
  /**
   * 教員
   */
  model Faculty {
    id: string;
    name: string;
    email: string;
  }

  model FacultyRequest {
    name: string;
    email: string;
  }
}
