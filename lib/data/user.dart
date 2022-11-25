import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  String username;
  String usersurname;
  String email;
  String password;
  String phoneNumber;
  bool launch = false;

  User(
      {this.id = 0,
      required this.username,
      required this.usersurname,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.launch});
}
