/* const express = require('express')
const produtos = [
'Caneta',
'lapis',
'Eraser',
'Cera',
'Portatil'
]
const buscaProdutos = (produtoBuscado) => produtos.filter(produto => produtoBuscado === produto)
const server = express() //servidor express
server.get('/produtos', (request, response) => {
response.send(
    'Lista de Produtos:\n' +
    produtos.join('\n'))
})
server.get('/busca', (request, response) => {
const produtosEncontrados = buscaProdutos(request.query.nomeProduto)
response.send(
'Lista de Produtos:\n' +
produtosEncontrados.join('\n'))
})
server.listen(4000, () => console.log('Acesse localhost:4000'))

//npm install express (no terminal VSC)
No Browser http://localhost:4000/produtos

const fs = require('fs');
const ids = {
    "event-ids" : [
        "Z698xZ2qZa6y5",
        "Z698xZ2qZaFHl",
        "G5vYZ9svBCs1O",
    ]
 }
fs.writeFile('C:/ISEL/Semestre3/IPW/Trabalhos/TP1/App_part2-Node_application/new_JSON.json', (ids["event-ids"])[0], err => {
    if (err) throw err ;
    console.log("Ficheiro criado com sucesso");
});
fs.readFile('C:/ISEL/Semestre3/IPW/Trabalhos/TP1/App_part2-Node_application/new_JSON.json', "utf8", (err, data) => {
    if (err) throw err;
    console.log(data);
}); */

const fetch = require('node-fetch');

// Defina a URL do servidor para o qual deseja enviar solicitações
const serverURL = 'http://isel.pt'; // Substitua pelo URL real do seu servidor

// Defina o método de solicitação (GET, POST, PUT, DELETE, etc.)
const method = 'GET'; // Substitua pelo método desejado

// Configurações adicionais da solicitação, como cabeçalhos ou corpo da solicitação
const requestOptions = {
  method: method,
  // Adicione cabeçalhos aqui, se necessário
  // headers: { 'Content-Type': 'application/json' },
  // Adicione o corpo da solicitação aqui, se necessário
  // body: JSON.stringify({ key: 'value' }),
};

// Função para fazer a solicitação
async function sendRequest() {
  try {
    const response = await fetch(serverURL, requestOptions);

    if (response.ok) {
      const data = await response.json(); // Se a resposta é JSON
      console.log('Resposta bem-sucedida:', data);
    } else {
      console.error('Erro na solicitação:', response.statusText);
    }
  } catch (error) {
    console.error('Erro na solicitação:', error);
  }
}

// Chame a função para fazer a solicitação
sendRequest();
