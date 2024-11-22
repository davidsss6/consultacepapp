# 🌍 Buscador de CEP

Olá! Este é o **Buscador de CEP**, um aplicativo desenvolvido em **Flutter** para tornar a pesquisa, armazenamento e edição de CEPs uma tarefa fácil e prática. 🔍💾

## 🛠️ Funcionalidades Principais

- **🔎 Pesquisa de CEP**: Conecta-se à API do ViaCep para encontrar os detalhes do CEP pesquisado e exibe os resultados em um **pop-up elegante**.
- **💾 Salvamento de CEPs**: Se o CEP pesquisado não existe no **Back4App**, ele pode ser cadastrado com um clique!
- **📃 Lista de CEPs Salvos**: Mostra todos os CEPs armazenados no **Back4App**, para facilitar a visualização e o gerenciamento.
- **✏️ Edição de CEPs**: Clique em um item da lista e atualize os dados com facilidade.
- **🗑️ Exclusão de CEPs**: Com apenas um toque no ícone de lixeira, remova CEPs salvos da lista.

---

## 🚀 Tecnologias Utilizadas

Este app usa o melhor da tecnologia Flutter! 🌟

- **💻 Linguagem**: Dart com Flutter.
- **🔐 flutter_dotenv**: Gerenciamento seguro de variáveis de ambiente.
- **🚀 Dio**: Para consumo de APIs com **interceptors**.
- **☁️ Back4App**: Banco de dados para armazenar e gerenciar CEPs salvos.

---

## 🛠️ Detalhes Técnicos

### 🔍 Pesquisa de CEP na API do ViaCep
Conexão direta com o ViaCep usando **Dio** para buscar informações completas de um CEP, como:

- 📍 Bairro
- 🏢 Logradouro
- 🌆 Cidade
- 🗺️ Estado

### 💾 Salvamento de Dados no Back4App
Se o CEP pesquisado não existe no banco de dados do **Back4App**, você pode salvá-lo com um clique. Simples assim! 😎

### 📃 Listagem, Edição e Exclusão
Todos os CEPs salvos aparecem em uma lista com:

1. **📃 Visualização completa**.
2. **✏️ Botão para editar** os dados salvos.
3. **🗑️ Botão para excluir** o CEP, caso não precise mais dele.

---

## 🛡️ Tratamento de Erros

- **📡 Erros de Conexão**: Mensagens claras informam problemas com a internet ou com os servidores.
- **📝 Validação de Entradas**: Garante que o usuário insira um CEP válido antes de pesquisar.

---

## 📱 Interface do Usuário

- **🎨 Design Responsivo**: Compatível com diferentes tamanhos de tela.
- **🔘 Botões Intuitivos**: Ícones claros para edição e exclusão.
- **📑 Listagem organizada**: Apresenta os CEPs com informações detalhadas.

---

## 🎯 Como Funciona?

1. **🔍 Pesquise um CEP**.
   - Insira o CEP na barra de pesquisa e receba as informações no pop-up.
2. **💾 Salve os dados**.
   - Clique em "Salvar" e o CEP será armazenado no **Back4App**.
3. **📃 Gerencie seus CEPs**.
   - Edite ou exclua qualquer CEP salvo diretamente na lista.

---

## 📖 Próximos Passos

- Adicionar autenticação de usuários para um banco de CEPs personalizado. 🔒
- Implementar filtros para busca dentro da lista de CEPs. 🔍

---


Espero que este app seja útil e fácil de usar! 😃 Caso tenha dúvidas ou sugestões, fique à vontade para compartilhar. 🚀
