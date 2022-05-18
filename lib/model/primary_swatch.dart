import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'primary_swatch.g.dart';

@HiveType(typeId: 0)
enum PrimarySwatch {
  @HiveField(0)
  red(Colors.red),
  @HiveField(1)
  pink(Colors.pink),
  @HiveField(2)
  purple(Colors.purple),
  @HiveField(3)
  deepPurple(Colors.deepPurple),
  @HiveField(4)
  indigo(Colors.indigo),
  @HiveField(5, defaultValue: true)
  blue(Colors.blue),
  @HiveField(6)
  lightBlue(Colors.lightBlue),
  @HiveField(7)
  cyan(Colors.cyan),
  @HiveField(8)
  teal(Colors.teal),
  @HiveField(9)
  green(Colors.green),
  @HiveField(10)
  lightGreen(Colors.lightGreen),
  @HiveField(11)
  lime(Colors.lime),
  @HiveField(12)
  yellow(Colors.yellow),
  @HiveField(13)
  amber(Colors.amber),
  @HiveField(14)
  orange(Colors.orange),
  @HiveField(15)
  deepOrange(Colors.deepOrange),
  @HiveField(16)
  brown(Colors.brown),
  @HiveField(17)
  grey(Colors.grey),
  @HiveField(18)
  blueGrey(Colors.blueGrey);

  final MaterialColor color;

  const PrimarySwatch(this.color);
}
