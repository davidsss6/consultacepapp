class ResultadosCepBack4AppModel {
  List<ResultadoCepBack4AppModel> resultados = [];

  ResultadosCepBack4AppModel(this.resultados);

  ResultadosCepBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      resultados = <ResultadoCepBack4AppModel>[];
      json['results'].forEach((v) {
        resultados.add(ResultadoCepBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = resultados.map((v) => v.toJson()).toList();
    return data;
  }
}

class ResultadoCepBack4AppModel {
  String? objectId;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? cidade;
  String? uf;
  String? createdAt;
  String? updatedAt;

  ResultadoCepBack4AppModel(
      {this.objectId,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.cidade,
      this.uf,
      this.createdAt,
      this.updatedAt});

  ResultadoCepBack4AppModel.criar(
      this.logradouro, this.complemento, this.bairro, this.cidade, this.uf);

  ResultadoCepBack4AppModel.modificar(this.objectId, this.logradouro,
      this.complemento, this.bairro, this.cidade, this.uf);

  ResultadoCepBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['logradouro'] = this.logradouro;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logradouro'] = this.logradouro;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;

    return data;
  }
}
