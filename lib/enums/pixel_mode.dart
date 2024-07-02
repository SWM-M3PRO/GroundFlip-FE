enum PixelMode {
  individualMode(krName : '개인전'),
  individualHistory(krName : '개인 기록'),
  groupMode(krName : '그룹전');

  const PixelMode({required this.krName});

  final String krName;

  static PixelMode fromKrName(String krName) {
    return PixelMode.values.firstWhere((mode) => mode.krName == krName,
        orElse: () => throw ArgumentError('No enum value with krName $krName'),
    );
  }
}
