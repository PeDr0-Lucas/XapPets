# **XapPets 🐶🏨**

 

Uma aplicação construída em **Node.js**, **Flutter** e **MongoDb**, que realiza um controle de Animais em um determinado Hotel. O projeto se trata de um CRUD, permitindo o usuário: Criar, Listar, Editar e Deletar os dados referente aos animais.

 

---

 

## **🚀 Instalação e Configuração**

 
### **Pré-requisitos**

- Node.js (v16 ou superior);
- **npm** ou **yarn**;
- Flutter SDK

### **Clonar Repositório**

 

```bash

 

    https://github.com/PeDr0-Lucas/XapPets.git

 

```

 

### **🔧 Instalar Dependências**

 

#### **FrontEnd**

Com npm

 

```bash

    cd frontend

    flutter pub get

```

#### **Backend**

Com npm

 

```bash

    cd server

    npm install

```

### Estrutura do Projeto
 

#### FrontEnd
 
frontend/

|

|---android/

|---lib/

|   |--model/

|   |   |--pet_model.dart

|   |--provider/

|   |   |--pet_provider.dart

|   |--screens/

|   |   |--editPet.dart

|   |   |--home.dart

|   |--service/

|   |   |--api_service.dart

|   |--main.dart

|

|--pubspec.yaml

|--pubspec.lock

 
#### BackEnd


Server/

|

|---src/

|   |--controllers/

|   |   |--petController.js

|   |--database/

|   |   |--db.js

|   |--models/

|   |   |--Pet.js

|   |   |--schema.js

|   |--routes/

|   |   |--petRoutes.js

|   |--utils/

|   |   |--sum.js

|   |   |--validations.js

|--index.js


### **Rodando o Projeto**

#### **FrontEnd**

```bash

    cd frontend
    flutter run

```

#### **Backend**

Com npm

```bash

    cd server
    npm start
```


