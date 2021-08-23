import 'package:path/path.dart';
import 'package:student_register/models/db_local.dart';
import 'package:student_register/models/irepository.dart';
import 'package:student_register/models/student.dart';

abstract class StudentRepository implements IRepository<Student> {
  late DBLocal dblocal;
}