namespace FoundationV1 {
  model FirebaseAppCheckAuth
    is Http.ApiKeyAuth<Http.ApiKeyLocation.header, "X-Firebase-AppCheck"> {
    description: "Set a bearer token in the format: `Bearer <token>`.";
  }
}
