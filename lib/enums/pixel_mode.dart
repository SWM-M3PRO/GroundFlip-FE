enum PixelMode {
  individualMode(koreanName : '개인전'),
  individualHistory(koreanName : '개인 기록'),
  groupMode(koreanName : '그룹전');

  const PixelMode({required this.koreanName});

  final String koreanName;

  static PixelMode fromKrName(String krName) {
    return PixelMode.values.firstWhere((mode) => mode.koreanName == krName,
        orElse: () => throw ArgumentError('No enum value with krName $krName'),
    );
  }
}
