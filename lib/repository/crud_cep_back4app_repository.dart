import 'package:consultacepapp/interceptors/back4app_dio_interceptor.dart';
import 'package:consultacepapp/model/dados_cep_back4app_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CrudCepBack4AppRepository {

  var _dio = Dio();

  CrudCepBack4AppRepository(){
    _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASEURL");
    _dio.interceptors.add(Back4AppDioInterceptor());

  }

  Future<ResultadosCepBack4AppModel> obterCep() async {
    var url = "/Endereco";
    var result = await _dio.get(url);
    return ResultadosCepBack4AppModel.fromJson(result.data);
  }

  Future<void> criarCep(ResultadoCepBack4AppModel dadoCepBack4AppModel) async {
    try{
      await _dio.post("/Endereco", data: dadoCepBack4AppModel.toJsonEndpoint() );
    }catch(e){
      throw e;
    }
  }

  Future<void> atualizarCep(ResultadoCepBack4AppModel dadoCepBack4AppModel) async {
    
    print(dadoCepBack4AppModel.objectId.toString());
    
    try{
      await _dio.put("/Endereco/"+dadoCepBack4AppModel.objectId.toString(), 
      data: dadoCepBack4AppModel.toJsonEndpoint() );
    }catch(e){
      throw e;
    }
  }


  Future<void> removerCep(String objectId) async {
    try{
      await _dio.delete("/Endereco/$objectId");
    }catch(e){
      throw e;
    }
  }

}