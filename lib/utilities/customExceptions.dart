class LocationServiceEnabledException implements Exception {
  String cause;
  LocationServiceEnabledException(this.cause);
}

class LocationServicePermissionException implements Exception {
  String cause;
  LocationServicePermissionException(this.cause);
}

class LocationServicePermanentDenialException implements Exception {
  String cause;
  LocationServicePermanentDenialException(this.cause);
}
