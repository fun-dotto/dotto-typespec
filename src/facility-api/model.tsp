namespace FacilityService {
  model Room {
    id: string;
    name: string;
    floor: DottoFoundationV1.Floor;
  }

  model RoomRequest {
    name: string;
    floor: DottoFoundationV1.Floor;
  }

  model Reservation {
    startAt: utcDateTime;
    endAt: utcDateTime;
    title: string;
  }
}
