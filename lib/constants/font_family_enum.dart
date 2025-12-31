enum FontFamilyEnum {
  system(''),
  roboto('Roboto'),
  openSans('OpenSans'),
  lato('Lato'),
  montserrat('Montserrat'),
  avertaStdCY('AvertaStdCY');

  final String familyName;
  const FontFamilyEnum(this.familyName);

  String get displayName {
    switch (this) {
      case FontFamilyEnum.system:
        return 'System';
      case FontFamilyEnum.roboto:
        return 'Roboto';
      case FontFamilyEnum.openSans:
        return 'Open Sans';
      case FontFamilyEnum.lato:
        return 'Lato';
      case FontFamilyEnum.montserrat:
        return 'Montserrat';
      case FontFamilyEnum.avertaStdCY:
        return 'Averta Std CY';
    }
  }

  static FontFamilyEnum fromString(String fontName) {
    return FontFamilyEnum.values.firstWhere(
      (e) => e.familyName == fontName,
      orElse: () => FontFamilyEnum.system,
    );
  }
}
