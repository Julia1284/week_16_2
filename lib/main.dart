import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:week_16_2/data/user.dart';
import 'package:week_16_2/data/user_repository.dart';
import 'package:week_16_2/data/users.dart';
import 'package:week_16_2/screens/formpage.dart';
import 'package:week_16_2/screens/loginpage.dart';
import 'package:week_16_2/screens/userpage.dart';
import 'package:path_provider/path_provider.dart';

import 'objectbox.g.dart';

late Store _store;
late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  await UserPreferences().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

//https://github.com/doctorcode9/windows_todo_app_flutter.git
class _MyAppState extends State<MyApp> {
  late List<User> users; //список всех пользователей
  late Box<User> userBox; // box для пользователей - таблица пользователей
  bool newlaunch = false; // булевая переменная для загрузки экрана
  late User user; // экземпляр пользователя
  // неизвестный пользователь
  User unknownUser = User(
      username: 'Unknown',
      usersurname: 'Unknown',
      email: 'Unknown',
      password: 'Unknown',
      phoneNumber: 'Unknown',
      launch: false);

  @override
  void initState() {
    super.initState();
    //получаем всех пользователей из  store
    users = objectBox.store.box<User>().getAll();
    // инициализируем userbox
    userBox = objectBox.store.box<User>();
    user = checklaunch();
  }

  @override
  void dispose() {
    objectBox.store.close();
    super.dispose();
  }

// функция проверки загрузки, если галочка была поставлена, то launch у какого-то пользователя true. Ищем его и возвращаем, чтобы потом передать на страницу пользователя
  checklaunch() {
    for (var i = 0; i < users.length; i++) {
      if (users[i].launch == true) {
        setState(() {
          newlaunch = true;
        });
        return users[i];
      }
    }
    setState(() {
      newlaunch = false;
    });
    return unknownUser;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.black26),
          routes: {
            // если newдaunch true, то загружаем  UserPage, в противном случае LoginPage
            '/': (context) =>
                newlaunch ? UserPage(user: user) : const LoginPage(),
            '/loginpage': ((context) => const LoginPage()),
            '/formpage': (context) => const FormPage(),
            '/userpage': (context) => UserPage(user: user),
          },
        );
      },
    );
  }
}
