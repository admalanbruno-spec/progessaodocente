let dados = [];

fetch('dados.json')
  .then(response => response.json())
  .then(data => dados = data);

function consultar() {
  const valor = document.getElementById('busca').value.toLowerCase();
  
  const servidor = dados.find(d =>
    d.nome.toLowerCase().includes(valor) ||
    d.siape.includes(valor)
  );

  const resultado = document.getElementById('resultado');

  if (servidor) {
    resultado.innerHTML = `
      <p><strong>Nome:</strong> ${servidor.nome}</p>
      <p><strong>Classe/Nível:</strong> ${servidor.classe} - ${servidor.nivel}</p>
      <p><strong>Última Progressão:</strong> ${servidor.ultima_progressao}</p>
      <p><strong>Próxima Progressão:</strong> ${servidor.proxima_progressao}</p>
    `;
  } else {
    resultado.innerHTML = "<p>Servidor não encontrado.</p>";
  }
}
