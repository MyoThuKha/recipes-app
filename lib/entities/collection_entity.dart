import 'package:objectbox/objectbox.dart';

@Entity()
class CollectionEntity {
  @Id()
  int id;
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  @Property(type: PropertyType.date)
  final DateTime createdAt;

  CollectionEntity({this.id = 0, DateTime? createdAt, this.strMeal, this.strMealThumb, this.idMeal})
    : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Favorites{id: $id, , createdAt: $createdAt}';
  }
}
