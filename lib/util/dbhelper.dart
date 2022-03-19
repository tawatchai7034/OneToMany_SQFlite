// @dart=2.9
import 'package:one_to_many_sqf/models/photo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';

class DbHelper {
  final int version = 1;
  Database db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future testDb() async {
    db = await openDb();
    await db.execute('INSERT INTO lists VALUES (0, "Fruit", 2)');
    await db.execute(
        'INSERT INTO items VALUES (0, 0, "Apples", "2 Kg", "Better if they are green")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (database, version) {
            database.execute(
                'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, species TEXT)');
            database.execute(
                'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER,bodyLenght REAL,heartGirth REAL,hearLenghtSide REAL,hearLenghtRear REAL,hearLenghtTop REAL,pixelReference REAL,distanceReference REAL,imageSide TEXT, imageRear TEXT, imageTop TEXT,date TEXT,note TEXT ' +
                    'FOREIGN KEY(idList) REFERENCES lists(id))');
            database.execute(
                'CREATE TABLE photos(id INTEGER PRIMARY KEY,idPro INTEGER,idTime INTEGER, photo_name TEXT, gender TEXT, species TEXT)'+'FOREIGN KEY(idPro) REFERENCES lists(id))'+'FOREIGN KEY(idTime) REFERENCES items(id))');
          }, version: version);
          //  quantity TEXT, note TEXT,
    }
    return db;
  }

  Future<int> insertList(ShoppingList list) async {
    int id = await this.db.insert(
      'lists',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertItem(ListItem item) async {
    int id = await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query('lists');
    return List.generate(maps.length, (i) {
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['gender'],
        maps[i]['species'],
      );
    });
  }

  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps =
    await db.query('items', where: 'idList = ?', whereArgs: [idList]);
    return List.generate(maps.length, (i) {
      return ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['bodyLenght'],
        maps[i]['heartGirth'],
        maps[i]['hearLenghtSide'],
        maps[i]['hearLenghtRear'],
        maps[i]['hearLenghtTop'],
        maps[i]['pixelReference'],
        maps[i]['distanceReference'],
        maps[i]['imageSide'],
        maps[i]['imageRear'],
        maps[i]['imageTop'],
        maps[i]['date'],
        // maps[i]['quantity'],
        maps[i]['note'],
      );
    });
  }

  Future<int> deleteList(ShoppingList list) async {
    int result = await db.delete(
        "items", where: "idList = ?", whereArgs: [list.id]);
    result = await db.delete("lists", where: "id = ?", whereArgs: [list.id]);
    return result;
  }

    Future<int> deleteItem(ListItem Item) async {
    int result = await db.delete(
        "items", where: "id = ?", whereArgs: [Item.id]);
    return result;
  }

  // helper of images for  
  Future<Photo> save(Photo employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert("photos", employee.toMap());
    return employee;
  }

   Future<int> delete(Photo employee) async {
    var dbClient = await db;
    int result = await dbClient.delete('photos',where: "id = ?", whereArgs: [employee.id]);
    return result;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map<String, Object>> maps = await dbClient.query("photos", columns: ["id", "photo_name"]);
    List<Photo> employees = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}