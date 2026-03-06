let dados = [];

// Carregar dados
fetch('dados.json')
  .then(response => response.json())
  .then(data => dados = data);

// Cálculo automático (24 meses)
function calcularProxima(dataUltima) {
  const data = new Date(dataUltima);
  data.setFullYear(data.getFullYear() + 2);
  return data.toISOString().split('T')[0];
}

function consultar() {
  const siape = document.getElementById("siape").value;
  const servidor = dados.find(s => s.siape == siape);

  if (servidor) {
    const proxima = calcularProxima(servidor.ultima_progressao);

    document.getElementById("resultado").innerHTML =
      `<strong>Nome:</strong> ${servidor.nome}<br>
       <strong>Classe:</strong> ${servidor.classe}<br>
       <strong>Nível:</strong> ${servidor.nivel}<br>
       <strong>Última Progressão:</strong> ${servidor.ultima_progressao}<br>
       <strong>Próxima Progressão:</strong> ${proxima}`;
  } else {
    document.getElementById("resultado").innerHTML = "Servidor não encontrado.";
  }
}

// Login simples
function login() {
  const senha = document.getElementById("senha").value;
  if (senha === "cgp2025") {
    document.getElementById("painel").style.display = "block";
  } else {
    alert("Senha incorreta");
  }
}

// Importação Excel
function importarExcel() {
  const file = document.getElementById('excelFile').files[0];
  const reader = new FileReader();

  reader.onload = function(e) {
    const data = new Uint8Array(e.target.result);
    const workbook = XLSX.read(data, { type: 'array' });
    const sheet = workbook.Sheets[workbook.SheetNames[0]];
    dados = XLSX.utils.sheet_to_json(sheet);

    alert("Importação concluída!");
  };

  reader.readAsArrayBuffer(file);
}
