import 'package:floor/floor.dart';

@Entity(tableName: 'PersistentLocalizedString')
class PersistentLocalizedString {
  @primaryKey
  final String? id;
  final String? value;

  PersistentLocalizedString(this.id, this.value);
}
