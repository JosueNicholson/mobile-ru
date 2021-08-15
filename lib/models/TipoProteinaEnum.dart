enum TipoProteinaEnum {
  carneVermelha,
  carneBranca,
  vegetariano
}

extension TipoProteinaExtension on TipoProteinaEnum {
  String get nameProteina {
    switch (this) {
      case TipoProteinaEnum.carneVermelha:
        return 'carneVermelha';
      case TipoProteinaEnum.carneBranca:
        return 'carneBranca';
      case TipoProteinaEnum.vegetariano:
        return 'vegetariano';
      default:
        return null;
    }
  }
}