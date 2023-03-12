import 'package:hive/hive.dart';
part 'secstor_card_tmp.g.dart';

@HiveType(typeId: 3)
class C_hiveCard_tmp extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String note;
  @HiveField(2)
  String card;
  @HiveField(3)
  String name;
  @HiveField(4)
  String date;
  @HiveField(5)
  String dateExp;
  @HiveField(6)
  String cvv;
  @HiveField(7)
  String pinAtm;

  C_hiveCard_tmp({
    this.id = '0',
    this.note = '',
    this.card = '',
    this.name = '',
    this.date = '',
    this.dateExp = '',
    this.cvv = '',
    this.pinAtm = '',
  });
}
