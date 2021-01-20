import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'page.g.dart';

@HiveType(typeId: 2)
class Page with EquatableMixin {
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final Map<String, dynamic> imageHeaders;

  @override
  List<Object> get props => [imageUrl, imageHeaders];

  Page({this.index = -1, this.imageUrl, this.imageHeaders});
}
