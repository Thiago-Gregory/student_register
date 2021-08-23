import 'package:sqflite/sqflite.dart';
import 'package:student_register/models/db_local.dart';
import 'package:student_register/models/student.dart';
import 'package:student_register/repositories/student_repository.dart';

class StudentDBRepository implements StudentRepository {
  @override
  late DBLocal dblocal;

  StudentDBRepository() {
    this.dblocal = DBLocal(
      table: "Students"
    );
  }

  @override
  Future<Student> find(int id) async {
    Database database = await dblocal.getConnection();

    //var -> List<Map<String, dynamic>>
    var data = await database.query(
      dblocal.table,
      where: "id=?",
      whereArgs: [id],
    );
    database.close();

    return Student.fromMap(data.first);
  }

  @override
  Future<int> insert(Student entity) async {
    Database database = await dblocal.getConnection();

    int id = await database.insert(
      dblocal.table,
      entity.toMap(), 
    );
    database.close();

    return id;
  }

  @override
  Future<int> remove({required String conditions, required List conditionsValue}) async {
    Database database = await dblocal.getConnection();

    int id = await database.delete(
      dblocal.table,
      where: conditions,
      whereArgs: conditionsValue,
    );
    database.close();

    return id;
  }

  @override
  Future<List<Student>> search() async {
    Database database = await dblocal.getConnection();

    var data = await database.query(dblocal.table);
    List<Student> students = data.map((object) => Student.fromMap(object)).toList();

    database.close();

    return students;
  }

  @override
  Future<int> update({required Student entity, required String conditions, required List conditionsValue}) async {
    Database database = await dblocal.getConnection();

    int id = await database.update(
      dblocal.table,
      entity.toMap(),
      where: conditions,
      whereArgs: conditionsValue, 
    );

    database.close();

    return id;
  }
}
