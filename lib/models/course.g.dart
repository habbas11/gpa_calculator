// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 0;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      courseName: fields[0] as String,
      hwResult: fields[1] as double,
      examResult: fields[2] as double,
      semester: fields[3] as int?,
      weight: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.courseName)
      ..writeByte(1)
      ..write(obj.hwResult)
      ..writeByte(2)
      ..write(obj.examResult)
      ..writeByte(3)
      ..write(obj.semester)
      ..writeByte(4)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
