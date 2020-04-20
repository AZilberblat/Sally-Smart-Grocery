class BillingAddress {
  String city;
  String country;
  String line1;
  String line2;
  String name;
  String postalCode;
  String state;

  BillingAddress({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.name,
    this.postalCode,
    this.state,
  });

  factory BillingAddress.fromJson(Map<dynamic, dynamic> json) {
    return BillingAddress(
      city: json['city'],
      country: json['country'],
      line1: json['line1'] ?? json["address_line_1"],
      line2: json['line2'] ?? json["address_line_2"],
      name: json['name'] ?? '${json['first_name']}${json['last_name']}',
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) data['city'] = this.city;
    if (this.country != null) data['country'] = this.country;
    if (this.line1 != null) data['line1'] = this.line1;
    if (this.line2 != null) data['line2'] = this.line2;
    if (this.name != null) data['name'] = this.name;
    List<String> splitName = name.split(' ');
    if (splitName.length > 1) {
      data['first_name'] = splitName.first;
      data['last_name'] = splitName.sublist(1).join(' ');
    }
    if (this.postalCode != null) data['postalCode'] = this.postalCode;
    if (this.state != null) data['state'] = this.state;
    return data;
  }
}
