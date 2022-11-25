import 'package:week_16_2/data/user.dart';
import 'package:week_16_2/objectbox.g.dart';

class UserRepository {
  late final Store _store;
  late final Box<User> _box;

  List<User> get users => _box.getAll();

//инициализация базы данных
  Future initDB() async {
    _store = await openStore();
    _box = _store.box<User>();
  }

  addUser(User user) {
    _box.put(user);
  }

  readUser(int id) {
    _box.get(id);
  }
}

class ObjectBox {
  late final Store store;
  ObjectBox._create(this.store) {}
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
