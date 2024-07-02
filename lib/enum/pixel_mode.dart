enum PixelMode {
  individualMode(name : '개인전'),
  individualHistory(name : '개인 기록'),
  groupMode(name : '그룹전');

  const PixelMode({required this.name});

  final String name;
}
