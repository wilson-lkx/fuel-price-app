class FuelPrice {
  final int id;
  final int dateFrom;
  final int dateUntil;
  final double ron95;
  final double ron97;
  final double diesel;

  FuelPrice(
      {this.id,
      this.dateFrom,
      this.dateUntil,
      this.ron95,
      this.ron97,
      this.diesel});

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
      id: json['id'],
      dateFrom: json['dateFrom'],
      dateUntil: json['dateUntil'],
      ron95: json['ron95'],
      ron97: json['ron97'],
      diesel: json['diesel'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['dateFrom'] = this.dateFrom;
    data['dateUntil'] = this.dateUntil;
    data['ron95'] = this.ron95;
    data['ron97'] = this.ron97;
    data['diesel'] = this.diesel;
    return data;
  }
}