import 'package:httpsapicalldemoproject/model/pictures.dart';
import 'package:httpsapicalldemoproject/model/userName.dart';

class Users {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final Pictures picture;

  Users({
    required this.email,
    required this.gender,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.picture,
  });
}
