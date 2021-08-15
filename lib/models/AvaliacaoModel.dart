import 'package:mobile_ru/models/TipoProteinaEnum.dart';

import 'package:mobile_ru/models/ClassificacaoEnum.dart';

class AvaliacaoModel {
  TipoProteinaEnum tipoProteina;
  Classificacao classificacao;
  String matricula;

  AvaliacaoModel();

  Map<String, Object> toJson() => {
    "proteina": tipoProteina.nameProteina,
    "qualidade": classificacao.nameClassificacao,
    "matricula": matricula,
  };

}