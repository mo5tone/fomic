class SourceID {
  static const local = const SourceID._(
    index: 0,
    name: '本地文件',
  );

  static const dmzj = const SourceID._(
    index: 1,
    name: '动漫之家',
  );

  static const manhuaren = const SourceID._(
    index: 2,
    name: '漫画人',
  );

  final int index;
  final String name;

  const SourceID._({
    this.index,
    this.name,
  });
}
