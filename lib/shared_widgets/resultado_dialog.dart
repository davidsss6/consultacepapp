import 'package:consultacepapp/model/dados_cep_back4app_model.dart';
import 'package:consultacepapp/repository/crud_cep_back4app_repository.dart';
import 'package:flutter/material.dart';

class ResultadoDialog {
  ResultadoDialog();

  static String resultadoErroBuscaCep =
      "Voce precisa preencher o campo CEP corretamente!\n\n Dicas:\n\n- Nao deixe o campo em branco. \n- Não coloque ponto ou vírgula. Apenas número";

  static void mostrarAlertDialog(
    BuildContext context,
    String objectId,
    String logradouro,
    String complemento,
    String bairro,
    String cidade,
    String uf,
    bool editavel, {
    required VoidCallback onOkPressed,
  }) async {
    String title;
    if (editavel) {
      title = "Editar Dados do CEP";
    } else {
      title = "Dados do CEP";
    }

    TextEditingController bairroController =
        TextEditingController(text: bairro);
    TextEditingController cidadeController =
        TextEditingController(text: cidade);
    TextEditingController complementoController =
        TextEditingController(text: complemento);
    TextEditingController ufController = TextEditingController(text: uf);
    TextEditingController logradouroController =
        TextEditingController(text: logradouro);
    CrudCepBack4AppRepository crudCepBack4AppRepository =
        CrudCepBack4AppRepository();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  enabled: editavel,
                  controller: logradouroController,
                  decoration: InputDecoration(labelText: 'Logradouro'),
                ),
                TextField(
                  enabled: editavel,
                  controller: bairroController,
                  decoration: InputDecoration(labelText: 'Bairro'),
                ),
                TextField(
                  enabled: editavel,
                  controller: cidadeController,
                  decoration: InputDecoration(labelText: 'Cidade'),
                ),
                TextField(
                  enabled: editavel,
                  controller: complementoController,
                  decoration: InputDecoration(labelText: 'Complemento'),
                ),
                TextField(
                  enabled: editavel,
                  controller: ufController,
                  decoration: InputDecoration(labelText: 'Uf'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (editavel) {
                  await crudCepBack4AppRepository.atualizarCep(
                      ResultadoCepBack4AppModel.modificar(
                          objectId,
                          logradouroController.text.toString(),
                          complementoController.text.toString(),
                          bairroController.text.toString(),
                          cidadeController.text.toString(),
                          ufController.text.toString()));
                } else {
                  await crudCepBack4AppRepository.criarCep(
                      ResultadoCepBack4AppModel.criar(
                          logradouroController.text.toString(),
                          complementoController.text.toString(),
                          bairroController.text.toString(),
                          cidadeController.text.toString(),
                          ufController.text.toString()));
                }
                Navigator.of(context).pop();
                onOkPressed();
              },
              child: editavel ? Text('Salvar') : Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void mostrarAlertDialogErro(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static String getMensagemErroBuscaCep() {
    return resultadoErroBuscaCep;
  }
}
