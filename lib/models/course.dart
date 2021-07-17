import 'package:hive/hive.dart';

part 'course.g.dart';

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  String courseName;
  @HiveField(1)
  double hwResult;
  @HiveField(2)
  double examResult;
  @HiveField(3)
  int? semester = -1;
  @HiveField(4)
  double weight;

  Course({
    required this.courseName,
    required this.hwResult,
    required this.examResult,
    required this.semester,
    required this.weight,
  });
}
