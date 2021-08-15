enum Classificacao {
  BOM, REGULAR, RUIM
}

extension ClassificacaoExtension on Classificacao {
  String get nameClassificacao {
    switch (this) {
      case Classificacao.BOM:
        return "BOM";
      case Classificacao.REGULAR:
        return "REGULAR";
      case Classificacao.RUIM:
        return "RUIM";
      default:
        return null;
    }
  }
}