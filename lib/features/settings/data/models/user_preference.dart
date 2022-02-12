import 'package:hive/hive.dart';

part 'user_preference.g.dart';

@HiveType(typeId: 1)
class UserPreferenceModel extends HiveObject {
  @HiveField(0)
  final bool showEntryDate;

  @HiveField(1)
  final String inboxAmount;

  UserPreferenceModel({
    required this.showEntryDate,
    required this.inboxAmount,
  });
}
