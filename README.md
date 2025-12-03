Lumos - Projeto acadêmico desenvolvido em Flutter (Frontend) e Spring Boot (Backend) para oferecer um sistema de gerenciamento escolar
--------------------------------------------------------------------------------------------------------------------------

Estrutura do Repositório:
Lumos/
│
├── demo/           → API REST em Spring Boot
├── lumos-front/    → Aplicativo Flutter
│
├── README.md
└── .gitignore


Fluxo de Branches:
main -	integração do sistema
front -	desenvolvimento exclusivo do Flutter
back -	desenvolvimento exclusivo do Backend


Banco de Dados:
O sistema utiliza MySQL 8.0.41
Arquivo .sql completo está em: docs/lumosBD.sql

Linguagens utilizadas no ptojero:
Dart - para a construção do frontend (HTML e JavaScript são derivadas da criação da aplicção web pelo própio Dart)
JAVA - para a construção do backend, utilizando Insomnia Postman


Como rodar o projeto

Backend:
cd demo
???

Frontend:
cd lumos-front
flutter pub get
flutter run


Contribuidores:
Equipe responsável pelo desenvolvimento do backend: Raphael de Abreu e Daniel de Paula
Equipe responsável pelo desenvolvimento do frontend: Lucas Neves, Nathália Ferreira e Raiana Vitória
