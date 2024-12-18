class Address {
  String countryCode;
  String city;
  String postalCode;
  String street;
  String houseNumber;

  Address(this.countryCode, this.city, this.postalCode, this.street, this.houseNumber);

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "city": city,
    "postalCode": postalCode,
    "street": street,
    "houseNumber": houseNumber
  };
}