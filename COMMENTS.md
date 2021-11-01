# BUILD
## O que fiz
- Escolhi a imagem python:3.7-alpine3.13 pois alpine resultará numa imagem mais leve e portanto mais rápida para fazer um deploy é a versão do python mais próxima que ainda é mantida nos repositórios oficiais do dockerhub

- Adicionei um script de dockerize para facilitar o CI, como o app é bem simples só precisamos de um docker build, mas conforme a aplicação cresça pode ser que a etapa de build exige mais passos, como por exemplo executar alguns sed's para alterar alguns parametros com base no ambiente

- O tanto o comando de inicialização como dentro da aplicação o log level está setado para debug, em uma aplicação para produção perguntaria se realmente há essa necessidade, dado que o volume de log será maior com essa flag

## Próximos passos
- Fazer um teste para verificar se o build da imagem está sendo feito corretamente, se a aplicação está servindo na porta que deveria e retornando a resposta que deveria. Usando a mesma biblioteca GO

- Executar com um usuário que não seja o root

# DEPLOY
## O que fiz
- Escolhi usar o GCP para fazer o deploy, pois tenho mais familiaridade com ele

- Escolhi o docker-compose ao invés do minikube pois a máquina da free-tier é bem leve e o minikube exige uma máquina um pouco mais parruda

- Escolhi terraform para a infraestrutura imutável por ter mais conhecimento nele que no Pulumi ou no Deployment Manager

- Escolhi Ansible ao invés de Puppet ou Chef pois o Ansible não tem exigência de ter o esquema de master/agents

- Como o CI não ficou totalmente funcional na parte do ansible (explico melhor embaixo), criei um script para subir o docker local, só necessita da instalação do docker-compose

- Fiz também um deploy numa máquina do GCP, vocês podem acessar a dashboard do grafana com http://34.123.248.117:3000/d/xtkCtBkiz/prometheus-blackbox-exporter?orgId=1&refresh=10s, o usuário e a senha estão no email que enviei

## Próximos passos
- Escrever testes para o terraform (O próprio terratest fornece um pacote para isso)

- Escrever módulos mais gerais para Ansible/Terraform e inserir valores por variáveis, para ter um reaproveitamento maior de código

- Configurar um backend para que o Terraform seja capaz de verificar o estado do servidor antes de qualquer apply

# MONITORAMENTO
## O que fiz
- Adicionei um prometheus, grafana e prometheus blackbox no compose para fazer o deploy da aplicação junto com as ferramentas de monitoração

- Escolhi o prometheus por fazer parte da stack da empresa e o grafana por integrar bem com o prometheus

- O blackbox eu escolhi pois queria métricas mais específicas da aplicação ao invés de específicas da máquina

- Criei um endpoint "/health" na aplicação para que o blackbox possa atingir e verificar se o flask foi iniciado com sucesso

- Coloquei as configurações das ferramentas como volume no compose para que o deploy já traga o grafana pronto para uso

## Próximos passos
- Colocar métricas relativas ao estado da máquina (uso de memória, load average, uptime)

- Salvar os dados do prometheus em um banco para não perder em caso de restart da máquina

- Criar alertas para notificar em caso de algum problema (Pode usar o próprio Alert-Manager do Prometheus)

- Monitorar também endpoints mais específicos da aplicação, como o de publicar o comentário

# CI
## O que fiz
- Utilizei o Github Actions por não necessitar de nenhum deploy na máquina do GCP

- Escolhi automatizar o test/build/push da imagem docker e a criação/configuração do servidor

## Próximos passos
- O ansible não executa com sucesso devido a umas dependências na action que escolhi (tentei algumas e nenhuma pareceu cobriu tudo o que precisava), então se fosse continuar usando o actions criaria uma imagem com todas as dependencias necessárias (rsync, setuptools) e que eu pudesse usar sem ter de expôr nenhuma chave no meu repositório. E também na primeira execução do playbook ele fica preso em uma etapa de realizar um apt install dos pacotes docker, precisaria investigar melhor o pq disso acontecer

- Melhoraria o sistema de criação de tags na construção da imagem docker da aplicação para que não haja perda da versão anterior sempre que houver um push novo

- Criaria um pipeline para os testes do terraform com o trigger de push em branchs de dev, o mesmo para criação a de uma imagem docker da aplicação com uma tag de "develop"
