# BUILD
- Escolhi a imagem python:3.7-alpine3.13 pois alpine resultará numa imagem mais leve e portanto mais rápida para fazer um deploy é a versão do python mais próxima que ainda é mantida nos repositórios oficiais do dockerhub

- Adicionei um script de dockerize para facilitar o CI, como o app é bem simples só precisamos de um docker build, mas conforme a aplicação cresça pode ser que a etapa de build exige mais passos, como por exemplo executar alguns sed's para alterar alguns parametros com base no ambiente

- O tanto o comando de inicialização como dentro da aplicação o log level está setado para debug, em uma aplicação para produção perguntaria se realmente há essa necessidade, dado que o volume de log será maior com essa flag

- Se tivesse mais tempo faria um teste para verificar se o build da imagem está sendo feito corretamente, se a aplicação está servindo na porta que deveria e retornando a resposta que deveria
