class Trace {
  final String IPv4;
  final String city;
  final String countryCode;
  final String countryName;
  final double latitude;
  final double longitude;
  final String postal;
  final String state;

  Trace({
    this.IPv4,
    this.city,
    this.countryCode,
    this.countryName,
    this.latitude,
    this.longitude,
    this.postal,
    this.state
  });

  factory Trace.fromJson(Map<String, dynamic> json) {
    return Trace(
      IPv4: json['IPv4'],
      city: json['city'],
      countryCode: json['country_code'],
      countryName: json['country_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      postal: json['postal'],
      state: json['state'],
    );
  }
}