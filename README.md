# **XapPets 🐶🏨**

## Descrição do Projeto 📋

Uma aplicação de gerenciamento de animais para hotéis de pets, desenvolvida com tecnologias modernas para oferecer uma solução completa de CRUD (Create, Read, Update, Delete).

## **🚀 Tecnologias Utilizadas**

- **Backend:** Node.js, Express.js
- **Frontend:** Flutter
- **Banco de Dados:** MongoDB
- **Arquitetura:** 
  - Frontend: Provider
  - Backend: MVC (Model-View-Controller)

## **🛠️ Pré-requisitos**

- Node.js (v16 ou superior)
- npm ou yarn
- Flutter SDK (última versão estável)
- MongoDB

## **📦 Instalação**

### Clonar Repositório

```bash
git clone https://github.com/PeDr0-Lucas/XapPets.git
cd XapPets
```

### Configuração do Backend

```bash
cd server
npm install
```

### Configuração do Frontend

```bash
cd ../frontend
flutter pub get
```

### Configuração do Banco de Dados

1. Instale o MongoDB
2. Crie um banco de dados para o projeto
3. Configure as credenciais de conexão no arquivo `server/src/database/db.js`

## **🚀 Executando o Projeto**

### Iniciando o Backend

```bash
cd server
npm start
```

### Iniciando o Frontend

```bash
cd frontend
flutter run
```

## **✨ Funcionalidades**

- Cadastro de animais
- Listagem de animais
- Edição de informações dos animais
- Exclusão de registros de animais

## **📡 Rotas da API**

### Pets

#### Buscar Todos os Pets
- **Método:** GET
- **Endpoint:** `/pets`
- **Descrição:** Retorna todos os pets cadastrados com informações de diárias

#### Buscar Pet por ID
- **Método:** GET
- **Endpoint:** `/pets/:id`
- **Descrição:** Retorna os detalhes de um pet específico

#### Criar Novo Pet
- **Método:** POST
- **Endpoint:** `/pets`
- **Corpo da Requisição:**
```json
{
  "nomeTutor": "Nome do Tutor",
  "contatoTutor": "99999-9999",
  "especie": "cachorro",
  "raca": "Labrador",
  "dataEntrada": "DD/MM/AAAA",
  "dataSaidaPrevista": "DD/MM/AAAA" (opcional)
}
```

#### Atualizar Pet
- **Método:** PUT
- **Endpoint:** `/pets/:id`
- **Corpo da Requisição:** Mesmo formato da criação, com campos opcionais

#### Excluir Pet
- **Método:** DELETE
- **Endpoint:** `/pets/:id`
- **Descrição:** Remove um pet específico do sistema

### **⚠️ Validações**
- Telefone deve estar no formato `xxxxx-xxxx`
- Espécie deve ser "cachorro" ou "gato"
- Data no formato `DD/MM/AAAA`
- Todos os campos obrigatórios devem ser preenchidos

## **🛠️ Troubleshooting**

- Certifique-se de que todas as dependências estão instaladas corretamente
- Verifique a versão do Node.js e do Flutter
- Confirme que o MongoDB está rodando antes de iniciar o backend
