import 'package:hive/hive.dart';
part 'secstor.g.dart';

@HiveType(typeId: 0)
class C_hive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  bool complete;
  @HiveField(2)
  String note; //disc
  @HiveField(3)
  String task; //site-prg
  @HiveField(4)
  String login;
  @HiveField(5)
  String pass;
  @HiveField(6)
  String card;
  @HiveField(7)
  String name;
  @HiveField(8)
  String date;
  @HiveField(9)
  String cvv;
  @HiveField(10)
  String pin;

  C_hive({
    this.id = '0',
    this.complete = false,
    this.note = '',
    this.task = '--',
    this.login = '',
    this.pass = '',
    this.card = '',
    this.name = '',
    this.date = '',
    this.cvv = '',
    this.pin = '',
  });
}
