import 'package:consultacepapp/model/dados_cep.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuscaCepRepository {
  Future<DadosCep> getEnderecoCep(String cepPesquisado) async {
    var dio = Dio();
    var enderecoBase = dotenv.get("API_VIACEP_URL");
    try {
      var result = await dio.get("$enderecoBase$cepPesquisado/json/");
      var cepPesquisadoModel = DadosCep.fromJson(result.data);
      return cepPesquisadoModel;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Erro de conexão: O tempo limite foi excedido.";
      } else if (e.type == DioExceptionType.badResponse) {
        throw "Erro de resposta: ${e.response?.statusCode ?? 'Código desconhecido'}";
      } else if (e.type == DioExceptionType.cancel) {
        throw "A solicitação foi cancelada.";
      } else {
        throw "Erro inesperado: ${e.message}";
      }
    } catch (e) {
      throw "Erro desconhecido: $e";
    }
  }
}
