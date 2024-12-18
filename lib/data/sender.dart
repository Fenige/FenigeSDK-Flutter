import 'package:fenige_sdk/data/address.dart';

class Sender {
  String firstName;
  String lastName;
  Address address;

  Sender(this.firstName, this.lastName, this.address);

  Map<String, dynamic> toJson() =>
      {
        "firstName": firstName,
        "lastName": lastName,
        "address": address.toJson()
      };
}