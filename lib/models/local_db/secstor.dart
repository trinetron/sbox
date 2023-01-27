import 'package:hive/hive.dart';
part 'secstor.g.dart';

@HiveType(typeId: 0)
class C_hive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String note; //disc
  @HiveField(2)
  String task; //site-prg
  @HiveField(3)
  String login;
  @HiveField(4)
  String pass;

  C_hive({
    this.id = '0',
    this.note = '',
    this.task = '--',
    this.login = '',
    this.pass = '',
  });
}
