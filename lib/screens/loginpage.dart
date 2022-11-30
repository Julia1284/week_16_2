import 'package:flutter/material.dart';
import 'package:week_16_2/data/user.dart';
import 'package:sizer/sizer.dart';
import 'package:week_16_2/main.dart';
import 'package:week_16_2/screens/userpage.dart';

import '../objectbox.g.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late List<User> users;
  late Box<User> userBox;
// объявляем переменные
  var remember = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

// обнвление пользователя при обновлении launch
  updateUser(User user, newlaunch) {
    user.launch = newlaunch;
    userBox.put(user);
  }

// функци проверки логина, если логин и пароль верные, то переходим на страницу пользователя, в противном случае выводим сообщение об ошибке
  checkLogin(newlaunch) {
    for (var i = 0; i < users.length; i++) {
      if (controllerEmail.text == users[i].email &&
          controllerPassword.text == users[i].password) {
        print(users[i].id);
        updateUser(users[i], newlaunch);
        //если галочка нажата, то нет кнопки назад, и мы не сможем вернуться и поставить галочку у еще одного пользователя. Т.о сохраненный будет только один пользователь
        if (newlaunch) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => UserPage(
                      user: User(
                          id: users[i].id,
                          username: users[i].username,
                          usersurname: users[i].usersurname,
                          email: users[i].email,
                          password: users[i].password,
                          phoneNumber: users[i].phoneNumber,
                          launch: newlaunch))),
              (route) => false);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserPage(
                      user: User(
                          id: users[i].id,
                          username: users[i].username,
                          usersurname: users[i].usersurname,
                          email: users[i].email,
                          password: users[i].password,
                          phoneNumber: users[i].phoneNumber,
                          launch: newlaunch))));
        }
        return;
      }
    }
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Login and password are wrong'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void initState() {
    super.initState();
    users = objectBox.store.box<User>().getAll();
    userBox = objectBox.store.box<User>();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = SizerUtil.orientation == Orientation.landscape;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Вход в систему'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 100.h,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/login.png'),
                    Stack(children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/login.png'),
                          radius: 90,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizerUtil.deviceType == DeviceType.tablet
                        ? SizedBox(
                            width: isLandscape ? 80.w : 70.w,
                            child: TextFormField(
                              controller: controllerEmail,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.email)),
                            ),
                          )
                        : SizedBox(
                            width: isLandscape ? 80.w : 100.w,
                            child: TextFormField(
                              controller: controllerEmail,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.email)),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizerUtil.deviceType == DeviceType.tablet
                        ? SizedBox(
                            width: isLandscape ? 80.w : 70.w,
                            child: TextFormField(
                              controller: controllerPassword,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.password)),
                              obscureText: true,
                            ),
                          )
                        : SizedBox(
                            width: isLandscape ? 80.w : 100.w,
                            child: TextFormField(
                              controller: controllerPassword,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.password)),
                              obscureText: true,
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 180,
                        child: CheckboxListTile(
                          value: remember,
                          // меняем значение checkBox
                          onChanged: (value) {
                            setState(() {
                              remember = value!;
                            });
                          },
                          title: const Text('Remember'),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 50.w,
                      child: OutlinedButton.icon(
                          onPressed: () {
                            checkLogin(remember);
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Login')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        //  переходим на страницу регистрации
                        onPressed: () => Navigator.pushNamed(
                              context,
                              '/formpage',
                            ),
                        child: const Text('Register'))
                  ],
                ),
              ),
            )));
  }
}
