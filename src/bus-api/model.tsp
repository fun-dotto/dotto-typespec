namespace BusService {
  model BusStop {
    id: string;
    name: string;
  }

  model BusRoute {
    id: string;
    name: string;
  }

  model BusTimetableStop {
    tripId: string;
    stop: BusStop;
    departureTime: utcDateTime;
  }

  model BusTrip {
    id: string;
    departureTime: utcDateTime;
    arrivalTime: utcDateTime;
    route: BusRoute;

    /**
     * 乗車バス停、乗り換えバス停、降車バス停のリスト
     */
    stops: BusStop[];

    delay: duration;
    alert: BusAlert;
  }

  enum BusAlert {
    /**
     * 通常運行
     */
    None,

    /**
     * 運休
     */
    Cancellation,
  }
}
