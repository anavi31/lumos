Lumos - Projeto acadêmico desenvolvido em Flutter (Frontend) e Spring Boot (Backend) para oferecer um sistema de gerenciamento escolar
--------------------------------------------------------------------------------------------------------------------------------------

Estrutura do Repositório:
Lumos/
│
├── backend/        → API REST em Spring Boot
├── frontend/       → Aplicativo Flutter
├── docs/           → Banco de dados
│
├── README.md
└── .gitignore


Fluxo de Branches:
main -	integração do sistema
front -	desenvolvimento exclusivo do Flutter
back -	desenvolvimento exclusivo do Spring Boot


Banco de Dados:
O sistema utiliza MySQL 8.0.41
Arquivo .sql completo está em: docs/lumosBD.sql

Como rodar o projeto

Backend:
cd lumos-back
mvn spring-boot:run



Frontend:
cd lumos-front
flutter pub get
flutter run


Contribuidores:
Equipe responsável pelo desenvolvimento do backend: Raphael de Abreu e Daniel de Paula
Equipe responsável pelo desenvolvimento do frontend: Lucas Neves, Nathália Ferreira e Raiana Vitória
