import 'dart:ui';

class ColorsStyle {
  static final white = getColorByHex('#FFFFFF');
  static final background = getColorByHex('#F5F7FA');
  static final blue = getColorByHex('#003A74');
  static final grey = getColorByHex('#979797');

  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  }
}
