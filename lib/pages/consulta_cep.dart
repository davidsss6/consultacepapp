import 'package:consultacepapp/model/dados_cep.dart';
import 'package:consultacepapp/model/dados_cep_back4app_model.dart';
import 'package:consultacepapp/repository/busca_cep_repository.dart';
import 'package:consultacepapp/repository/crud_cep_back4app_repository.dart';
import 'package:consultacepapp/shared_widgets/resultado_dialog.dart';
import 'package:consultacepapp/shared_widgets/text_label.dart';
import 'package:consultacepapp/shared_widgets/text_label_titulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsultaCepPagState extends StatefulWidget {
  const ConsultaCepPagState({super.key});

  @override
  State<ConsultaCepPagState> createState() => ConsultaCepPagStateState();
}

class ConsultaCepPagStateState extends State<ConsultaCepPagState> {
  var cepDigitadoController = TextEditingController();
  DadosCep dadosCep = DadosCep();
  late BuscaCepRepository buscaCepRepository;
  CrudCepBack4AppRepository crudCepBack4AppRepository =
      CrudCepBack4AppRepository();
  var _dadosCepBack4AppModel = ResultadosCepBack4AppModel([]);
  var carregando = false;

  @override
  void initState() {
    buscaCepRepository = BuscaCepRepository();
    super.initState();
    obterCepsJaPesquisados();
  }

  void obterCepsJaPesquisados() async {
    setState(() {
      carregando = true;
    });

    try {
      _dadosCepBack4AppModel = await crudCepBack4AppRepository.obterCep();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      carregando = false;
    });
  }

  void mostrarSalvarCep(String cepPassado) async {
    try {
      dadosCep = await buscaCepRepository.getEnderecoCep(cepPassado);
      if (dadosCep != null && dadosCep.logradouro.toString() != "null") {
        ResultadoDialog.mostrarAlertDialog(
            this.context,
            "",
            dadosCep.logradouro.toString(),
            dadosCep.complemento.toString(),
            dadosCep.bairro.toString(),
            dadosCep.localidade.toString(),
            dadosCep.estado.toString(),
            false, onOkPressed: () {
          setState(() {
            obterCepsJaPesquisados();
          });
        });
      } else {
        ResultadoDialog.mostrarAlertDialogErro(
            context, "Erro: Nenhum endereço para este CEP foi encontrado.");
      }
    } catch (e) {
      // Captura e exibe a mensagem de erro
      print("Erro ao buscar o CEP: $e");
      ResultadoDialog.mostrarAlertDialogErro(
          context, "Erro no servidor ao buscar o CEP. Erro do servidor: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 213, 173, 12),
        title: const Text('Pesquisa CEP'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset("lib/images/cep_logo.png"),
              const SizedBox(height: 20),
              const TextLabelTitulo(texto: "Pesquisa CEP"),
              const TextLabel(
                  texto: "Entre com o CEP que deseja saber o endereço::"),
              TextField(
                keyboardType: TextInputType.number, // Define o teclado numérico
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly // Permite apenas dígitos
                ],
                controller: cepDigitadoController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 232, 205, 25))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 234, 188, 7))),
                    hintText: "CEP",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 204, 180, 25),
                    )),
              ),
              TextButton(
                  onPressed: () async {
                    if (cepDigitadoController.text.isEmpty ||
                        cepDigitadoController.text.contains(".") ||
                        cepDigitadoController.text.contains(",")) {
                      ResultadoDialog.mostrarAlertDialogErro(
                          context, ResultadoDialog.getMensagemErroBuscaCep());
                    } else {
                      setState(() {
                        mostrarSalvarCep(cepDigitadoController.text);
                      });
                    }
                  },
                  child: const Text(
                    "Consultar",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 96, 90, 36)),
                  )),
              const TextLabel(texto: "CEPs já pesquisados:"),
              carregando
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dadosCepBack4AppModel.resultados.length,
                      itemBuilder: (BuildContext context, int index) {
                        var cepBack4App =
                            _dadosCepBack4AppModel.resultados[index];
                        return Stack(
                          children: [
                            ListTile(
                              onTap: () {
                                ResultadoDialog.mostrarAlertDialog(
                                    context,
                                    cepBack4App.objectId.toString(),
                                    cepBack4App.logradouro.toString(),
                                    cepBack4App.complemento.toString(),
                                    cepBack4App.bairro.toString(),
                                    cepBack4App.cidade.toString(),
                                    cepBack4App.uf.toString(),
                                    true, onOkPressed: () {
                                  setState(() {
                                    obterCepsJaPesquisados();
                                  });
                                });
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child:
                                        Text("Bairro: ${cepBack4App.bairro}"),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 20, color: Colors.red),
                                    onPressed: () async {
                                      await crudCepBack4AppRepository
                                          .removerCep(_dadosCepBack4AppModel
                                              .resultados[index].objectId
                                              .toString());
                                      setState(() {
                                        obterCepsJaPesquisados();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  "Logradouro: ${cepBack4App.logradouro} \nCidade: ${cepBack4App.cidade} \nUF: ${cepBack4App.uf}"),
                            ),
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
