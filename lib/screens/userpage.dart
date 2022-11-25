import 'package:flutter/material.dart';
import 'package:week_16_2/data/user.dart';
import 'package:week_16_2/data/user_repository.dart';
import 'package:week_16_2/data/users.dart';
import 'package:week_16_2/main.dart';

import '../objectbox.g.dart';

class UserPage extends StatefulWidget {
  User user;
  UserPage({required this.user, Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool newlaunch = false;
  late Box<User> userBox;

  updateUser(newlaunch) {
    widget.user.launch = newlaunch;
    userBox.put(widget.user);
  }

  @override
  void initState() {
    super.initState();
    userBox = objectBox.store.box<User>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(children: [
              const Text(
                'Name:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.user.username,
                style: const TextStyle(fontSize: 20),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const Text(
                'Surname:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.user.usersurname,
                style: const TextStyle(fontSize: 20),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const Text(
                'Phone:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.user.phoneNumber,
                style: const TextStyle(fontSize: 20),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const Text(
                'Email:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.user.email,
                style: const TextStyle(fontSize: 20),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  // setState(() {
                  //   widget._newLaunch = false;
                  // });
                  // changeLaunch(widget._newLaunch);
                  updateUser(newlaunch);
                  Navigator.pushNamed(context, '/loginpage');
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Exit'))
          ],
        ),
      ),
    );
  }
}
