class Statistic {
  final int attacks;
  final int clicks;
  final int countCreds;
  final int countNotPickedUp;
  final String status;

  Statistic({
    this.attacks,
    this.clicks,
    this.countCreds,
    this.countNotPickedUp,
    this.status
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      attacks: json['attacks'],
      clicks: json['clicks'],
      countCreds: json['countCreds'],
      countNotPickedUp: json['countNotPickedUp'],
      status: json['status'],
    );
  }
}