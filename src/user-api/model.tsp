namespace UserService {
  model User {
    /**
     * ユーザーID
     *
     * Firebase Authentication の UID
     */
    id: string;

    email: string;
    grade?: DottoFoundationV1.Grade;
    course?: DottoFoundationV1.Course;
    class?: DottoFoundationV1.Class;
  }

  model UserRequest {
    email: string;
    grade?: DottoFoundationV1.Grade;
    course?: DottoFoundationV1.Course;
    class?: DottoFoundationV1.Class;
  }
}
