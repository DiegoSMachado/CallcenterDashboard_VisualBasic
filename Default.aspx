﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html>
<head runat="server">
 <title>Gráficos</title>
 <!-- CSS -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link href="css/base.css" rel="stylesheet" type="text/css">
 <!-- JavaScript-->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script src="js/jquery-1.8.2.js" type="text/javascript"></script>
 <script src="js/loader.js" type="text/javascript"></script>
 <script src="js/jsapi.js" type="text/javascript"></script>
 <script type="text/javascript">
  //Carrega os pacotes de gráficos do Google
  google.load('visualization', '1', { packages: ['corechart'] });
  google.load('visualization', '1', { packages: ['gauge'] });
  google.load('visualization', '1', { packages: ['table'] });
  google.load('visualization', '1', { packages: ["map"] });
 </script>

 <script type="text/javascript">
  // Resgata a informação POST em formato Json e depois chama a função drawComboBox e drawChart
  $(function () {
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGrafico', data: '{}', success:
     function (response) {
      drawCombobox(response.d);
      drawchart(response.d);
     },
    error:
     function () {
      alert("Erro ao carregar dados! Tente novamente.");
     }
   });
  })

  //Função Contrói os gráficos
  function drawchart(dataValues) {

   // --- Gráfico Coluna -------------------------
   // Popula Dados ao Google DataTable
   var data = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data.addColumn('string', 'Nome');
   data.addColumn('number', 'Total');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data.addRow([dataValues[i].NomePais, dataValues[i].Total]);
    } else { }
   }
   // Monta a visualização do Google Chart Gauge
   var columnOption = { title: "Gráfico de Coluna" }
   var grafico1;
   grafico1 = new google.visualization.ColumnChart(document.getElementById('barra'));
   grafico1.draw(data, columnOption);

   // --- Gráfico Relogio -------------------------
   // Popula Dados ao Google DataTable
   var data2 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data2.addColumn('number', dataValues[1].NomePais);
   data2.addColumn('number', dataValues[2].NomePais);
   data2.addColumn('number', dataValues[3].NomePais);
   data2.addRow([dataValues[1].Total, dataValues[2].Total, dataValues[3].Total]);
   var gaugeOptions = { min: 0, max: 100, yellowFrom: 60, yellowTo: 90, redFrom: 90, redTo: 100, minorTicks: 5 };
   // Monta a visualização do Google Chart Gauge
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);

   // --- Gráfico de Linha -------------------------
   // Popula Dados ao Google DataTable
   var data3 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data3.addColumn('string', 'Nome');
   data3.addColumn('number', 'Total');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data3.addRow([dataValues[i].NomePais, dataValues[i].Total]);
    } else { }
   }
   // Monta a visualização do Google Chart LineChart
   var lineOption = { title: "Gráfico de linha" }
   var grafico3;
   grafico3 = new google.visualization.LineChart(document.getElementById('linha'));
   grafico3.draw(data3, lineOption);

   // --- Gráfico Pizza -------------------------
   // Popula Dados ao Google DataTable
   var data4 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data4.addColumn('string', 'Nome');
   data4.addColumn('number', 'Total');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data4.addRow([dataValues[i].NomePais, dataValues[i].Total]);
    } else { }
   }
   // Monta a visualização do Google Chart Pie
   var pieOption = { title: "Gráfico de pizza", pieHole: 0.3 }
   var grafico4;
   grafico4 = new google.visualization.PieChart(document.getElementById('pizza'));
   grafico4.draw(data4, pieOption);

   // --- Tabela -------------------------------
   // Popula Dados ao Google DataTable
   var data5 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data5.addColumn('string', 'Nome');
   data5.addColumn('number', 'Total');
   data5.addColumn('number', 'Idade');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data5.addRow([dataValues[i].NomePais, dataValues[i].Total, dataValues[i].Idade]);
    } else { }
   }
   // Monta a visualização do Google Tabela
   var tableOption = { title: "Tabela" }
   var grafico5;
   grafico5 = new google.visualization.Table(document.getElementById('tabela'));
   grafico5.draw(data5, tableOption);

   // --- Gráfico Scatter ------------------------
   // Popula Dados ao Google DataTable
   var data6 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data6.addColumn('number', 'Total');
   data6.addColumn('number', 'Idade');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data6.addRow([dataValues[i].Total, dataValues[i].Idade]);
    } else { }
   }
   // Monta a visualização do Google Chart Scatter
   var scatterOption = { title: "Gráfico Scatter  -  Valor / Idade" }
   var grafico6;
   grafico6 = new google.visualization.ScatterChart(document.getElementById('scatter'));
   grafico6.draw(data6, scatterOption);


   // --- Gráfico de Bolha ---------------------
   // Popula Dados ao Google DataTable
   var data7 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data7.addColumn('string', 'Nome');
   data7.addColumn('number', 'Total');
   data7.addColumn('number', 'Idade');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data7.addRow([dataValues[i].NomePais, dataValues[i].Total, dataValues[i].Idade]);
    } else { }
   }
   // Monta o visualização do Google Chart Bubble
   var bubbleOption = { title: "Gráfico de Bolha", sizeAxis: { minValue: 20, maxSize: 20 }, animation: { startup: true, duration: 10 } }
   var grafico7;
   grafico7 = new google.visualization.BubbleChart(document.getElementById('bubble'));
   grafico7.draw(data7, bubbleOption);


   // --- Mapa --------------------------------
   // Popula Dados ao Google DataTable
   var data8 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data8.addColumn('string', 'Latitude');
   data8.addColumn('string', 'Longitude');
   data8.addColumn('string', 'Nome');
   //O loop adiciona cada linha da tabela
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].NomePais.trim() == Filtro.value.trim() || Filtro.value.trim() == "todos") {
     data8.addRow([dataValues[i].Latitude, dataValues[i].Longitude, dataValues[i].Nome]);
    } else { }
   }
   // Monta o visualização do Google Chart Map
   var mapOption = { title: "Geolocalização", mapType: 'Normal' }
   var grafico8;
   grafico8 = new google.visualization.Map(document.getElementById('map'));
   grafico8.draw(data8, mapOption);

   //-----------------------------
  }

  // ----- Função Popula o Dropbox
  function drawCombobox(dataValues) {
   //variavel e declarada e recebe primeira tag Option vazia
   var complHtml = '<option value="todos"></option> \n'
   //O loop monta as tags com a informação nome do banco
   for (var i = 0; i < dataValues.length; i++) {
    var montaHtml = '<option value="' + dataValues[i].NomePais.trim() + '">' + dataValues[i].NomePais.trim() + '</option> \n';
    var complHtml = complHtml + montaHtml;
   }
   // A ID Filtro referente ao Select recebe todas as tags Option dentro dela
   Filtro.innerHTML = complHtml;
  }
 </script>
</head>
<body>
 <form id="form1" runat="server">
  <div class="navbar navbar-default navbar-fixed-top hidden-print">
   <div class="container-fluid">
    <div class="navbar-header">
     <a class="navbar-brand no-wrap" href="http://201.18.84.42:8080/dashboard" tabindex="-1">Report</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar-collapse">
     <div class="form-group">
      <label for="id_quebra" class="sr-only">Quebra</label>
      <select id="id_quebra" name="id" class="form-control" required>
       <!-- Código Inserido pelo back end -------------------------->
       <option value="">Carteira / Quebra</option>
       <!----------------------------------------------------------->
      </select>
     </div>

     <div class="form-group">
      <label for="data" class="sr-only">Data</label>
      <select id="data" name="data" class="form-control">
       <!-- Código Inserido pelo back end -------------------------->
       <option value="">xx/xx/xxxx</option>
       <!----------------------------------------------------------->
      </select>
     </div>
     <button type="submit" class="btn btn-primary">atualizar</button>
    </div>
   </div>
  </div>
 </form>
 <div class="col-xs-12 col-lg-10 col-lg-offset-1">
  <div class="page-header">
   <!-- Código Inserido pelo back end -------------------------->
   <h1>Hora a Hora
    <small class="text-muted">ADT - TODAS</small>
    <small class="text-muted">( 29/08/2016 )</small>
   </h1>
  </div>
  <p class="text-muted text-right">última atualização em 29/08/2016 às 17h48</p>
   <!----------------------------------------------------------->
  <ul id="abas" class="nav nav-tabs hidden-print">
   <li role="presentation" class="active"><a href="#">Dashboard</a></li>
   <li role="presentation">
    <a href="#">
     <span class="hidden-xs">Operadores</span>
     <span class="visible-xs-inline">Operad.</span>
    </a>
   </li>
   <li role="presentation" >
    <a href="#">
     <span class="hidden-xs">Finalizações do dia</span>
    </a>
   </li>
  </ul>
  <div class="panel-body">
   <!-- Painel Dashboard -------------------------------------------- -->
  </div>
  <div class="panel-footer text-center hidden-print">
   <div class="btn-group btn-group-sm" data-toggle="buttons">

   </div>
  </div>
 </div>
</body>
</html>


<script>
 // --- Função filtra dropdox --------------------------------
 // Reconstrói somente os gráficos não alterando o Dropbox
 function filtrando() {
  $.ajax({
   type: 'POST',
   dataType: 'json',
   contentType: 'application/json',
   url: 'Default.aspx/GetDadosGrafico',
   data: '{}',
   success:
       function (response) {
        drawchart(response.d);
       }
  })
 }
</script>