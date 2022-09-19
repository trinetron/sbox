import 'package:hive/hive.dart';
part 'secstor.g.dart';

@HiveType(typeId: 0)
class C_hive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  bool complete;
  @HiveField(2)
  String note;
  @HiveField(3)
  String task;

  C_hive(
      {this.id = '0', this.complete = false, this.note = '', this.task = '--'});
}
