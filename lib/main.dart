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

class _MyAppState extends State<MyApp> {
  var newLaunch; //объявляем переменную для загрузкт экрана
  final userRepo = UserRepository();
  late var users = <User>[];

  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((directory) {
      _store = Store(
        getObjectBoxModel(),
        directory: directory.path,
      );
    });
    userRepo
        .initDB()
        .whenComplete(() => setState(() => users = userRepo.users));
    loadNewLaunch();
  }

//функция, которая получает из sharedPreference булевое значение и присваивает его переменной.
// значение изначально false, если галочка remember нажата, то меняется на true.
  loadNewLaunch() async {
    setState(() {
      bool userNewLaunch = UserPreferences().getLaunch() ?? false;
      newLaunch = userNewLaunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.black26),
          routes: {
            // если newLaunch true, то загружаем  UserPage, в противном случае LoginPage
            '/': (context) =>
                newLaunch ? UserPage(newLaunch) : const LoginPage(),
            '/loginpage': ((context) => const LoginPage()),
            '/formpage': (context) => FormPage(),
            '/userpage': (context) => UserPage(newLaunch),
          },
        );
      },
    );
  }
}
