import 'package:mobile_ru/helpers/Response.dart';
import 'package:mobile_ru/models/AvaliacaoModel.dart';
import 'package:mobile_ru/resources/api_resource.dart';
import 'package:mobile_ru/resources/storage_resource.dart';
import 'package:mobile_ru/repository/avaliacao_repository.dart';
class VotacaoBloc {
  StorageResource _storageResource;
  final _matricula = 'matricula';
  ApiResource _apiResource;
  AvaliacaoModel avaliacao;
  String comentario;

  VotacaoBloc() {
    _storageResource = StorageResource.instance;
    _apiResource = ApiResource();
    avaliacao = AvaliacaoModel();
    comentario = "";
  }

  saveMatricula(String numeroMatricula) async {
    final returned = await _storageResource.saveKey(_matricula, numeroMatricula);
  }

  removeMatricula() async {
    await _storageResource.removeKey(_matricula);
  }

  Future<String> getMatricula() async {
    final returned = await _storageResource.getKey(_matricula);
    return returned;
  }

  Future<ResponseFromService> canRate() async {
    final matricula = await _storageResource.getKey(_matricula);
    return await AvaliacaoRepository().canRate(matricula);
  }

  Future<ResponseFromService> rate() async {
    avaliacao.matricula = await _storageResource.getKey(_matricula);
    Map<String, Object> avaliacaoJson = avaliacao.toJson();
    if(comentario.isNotEmpty){
      avaliacaoJson["comentario"] = comentario;
    }
    return await AvaliacaoRepository().sendRating(avaliacaoJson);
  }

  Future<ResponseFromService> auth() async {
     ResponseFromService res = await _apiResource.signIn();
     return res;
  }

}