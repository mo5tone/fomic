import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'chapter.g.dart';

@HiveType(typeId: 1)
class Chapter with EquatableMixin {
  @HiveField(0)
  final String url;
  @HiveField(1)
  String name;

  /// In milliseconds
  @HiveField(2)
  int updatedAt;
  @HiveField(3)
  double index;

  @override
  List<Object> get props => [url];

  Chapter(this.url, {this.index = -1, this.name, this.updatedAt = 0});
}
