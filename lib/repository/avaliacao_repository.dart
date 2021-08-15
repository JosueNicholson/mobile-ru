import 'package:mobile_ru/models/AvaliacaoModel.dart';
import 'package:mobile_ru/resources/api_resource.dart';
import 'package:mobile_ru/helpers/app_exceptions.dart';
import 'package:mobile_ru/helpers/Response.dart';

class AvaliacaoRepository {
  ApiResource _apiResource = ApiResource();

  Future<ResponseFromService> sendRating(Map<String, Object> avaliacaoJson) async {
    try {
      await _apiResource.put("/refeicao/atualizar", avaliacaoJson);
      return ResponseFromService(true, "sucesso");
    } catch (exception) {
      return ResponseFromService(false, exception.toString());
    }

  }

  Future<ResponseFromService> canRate(String matricula) async {
    try {
      await _apiResource.get("/votados/podeVotar/${matricula}");
      return ResponseFromService(true, "sucesso");
    } catch (exception) {
      return ResponseFromService(false, exception.toString());
    }
  }

}