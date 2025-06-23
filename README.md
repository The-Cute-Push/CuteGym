# CuteGym - GRUPO B
Este projeto consiste na criação de um modelo físico de um banco de dados para um sistema de gerenciamento de assinaturas de academias, o CuteGym.
A parte visual do projeto foi programada em React criando um CRUD para os cadastros necessários, onde a aplicação faz conexão com o banco de dados através de uma API em Java, e realiza operações de adição, aualização e deleção dos dados, usando conceitos e dinâmicas práticas de SQL Server desenvolvidas em aula.

### Integrantes
Vitor Muneretto Tinelli - VitorTinelli<br>
Gabriel Mensor da Rosa - GabrielMensor<br>
Lucas De Bitencourt Frasson - herudegan<br>
Brendon Córdova Silveira - Lightkiin<br>
Rafael Garcia de Rocchi - rafaelgarciaderocchi<br>
Vinícius dos Santos Nascimento - ViniciusDSN<br>
...

### Modelo Físico
Utilizamos a ferramenta de modelagem de dados [dbdiagram.io](https://dbdiagram.io/) para criação do modelo físico do banco de dados, para posterior exportação dos scripts DDL das tabelas e relacionamentos.<br>
<!--Arquivo fonte: [Modelo Fisico](https://dbdiagram.io/d/68477a47579a5a75f79526ab).<br> -->

![image]()
  
### Dicionário de Dados
As informações sobre as tabelas e índices foram documentados na planilha [dicionario_de_dados_cutegym.xlsx](dicionario_dados/dicionario_de_dados_cutegym.xlsx)

### Scripts SQL
Para este projeto foi utilizado o banco de dados [Azure SQL](https://azure.microsoft.com/pt-br/products/azure-sql/database) <br>
Este é o procedimento para criação do banco de dados Azure SQL [Criando SQL Azure serverless no Azure gratuito - Sem cartão de crédito](https://github.com/jlsilva01/sql-azure-satc).

Abaixo, segue os scripts SQL separados por tipo:
+ [Tabelas](scripts/ddl/tabelas)
+ [Índices](scripts/ddl/indices)
+ [Gatilhos](scripts/ddl/gatilhos)
+ [Procedimentos armazenados](scripts/ddl/procedimentos-armazenados)
+ [Funções](scripts/ddl/funcoes)
+ [DML](scripts/dml)

### Código Fonte do CRUD
- VITE/REACT
- AXIOS (NODEJS)

### Relatório Final
O relatório final está disponível no arquivo [relatorio-final/template1.docx](relatorio/template1.docx).

### Referências
https://www.w3schools.com/sql/sql_datatypes.asp
https://learn.microsoft.com/pt-br/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver17
