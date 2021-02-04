var veiculos_id
var player_id

$("#main").hide();
$(document).ready(function () {
	display(false)
	window.addEventListener('message', function (event) {
		var item = event.data;
		if (item.status == true) {
			display(true)
			$("#menubackgroundnameplayertop").html(item.playername);
			$("#procurarnome_resultados").hide();
			$("#procurarnome_main").hide();
			$("#procurarmatricula_main").hide();
			$("#player_procurados").hide();
			$("#veiculo_procurados").hide();
			$("#player").hide();
			$("#veiculos").hide();
			$("#codigo").hide();
			$("#criaravisos").hide();
			$("#criardetencao").hide();
			$("#criarmandato").hide();
			$("#criarmultas").hide();
		} else {
			display(false)
		}
		if (item.multas) {
			$("#criarmultas").show();
			$("#criarmultas_multas").empty();
			item.multas.forEach(element => {
				$("#criarmultas_multas").append(`
				<div  onclick="criarmulta(this)" data-id="${element.id}">
					<p class="name">[Multa Nº ${element.id}] ${element.name} [Valor ${element.price} €]</p>
				</div>
				`);
			})
		}
		if (item.codigopenal) {
			$("#codigo").show();
			$("#codigo_multas").empty();
			$("#codigo_prisao").empty();
				item.codigopenal.multas.forEach(element => {
					$("#codigo_multas").append(`
					<div>
						<p class="name">[Multa Nº ${element.id}] ${element.name} [Valor ${element.price} €]</p>
					</div>
					`);
				})
				item.codigopenal.prisao.forEach(element => {
					$("#codigo_prisao").append(`
					<div>
						<p class="name">[Detenção Nº ${element.id}] ${element.name} [${element.time}]</p>
					</div>
				`);
				})
		}
		if (item.veiculosplayerdata) {
			$("#veiculos").show();
			$("#veiculos_carros").show();
			$("#veiculos_playername").html("Firstname | " + item.veiculosplayerdata.name);
			$("#veiculos_playerapelido").html("Last Name | " + item.veiculosplayerdata.apelido);
			$("#veiculos_playeridade").html("Age | " + item.veiculosplayerdata.idade);
			$("#veiculos_playerregistro").html("Registration | " + item.veiculosplayerdata.registro);
			$("#veiculos_playertelemovel").html("Phone | " + item.veiculosplayerdata.telemovel);
			if (item.veiculosplayerdata.imagem !== undefined) {
				$("#veiculos_playericon").attr("src",item.veiculosplayerdata.imagem);	
			}
			if(item.veiculosplayerdata.imagem == undefined) {
				$("#veiculos_playericon").attr("src","https://i.imgur.com/pJ6hmOK.png");
			}
			if (item.veiculosplayerdata.veiculos !== "undefined")
			{
				$("#veiculos_carros").empty();
				item.veiculosplayerdata.veiculos.forEach(element => {
					$("#veiculos_carros").append(`
					<div>
						<p class="name">${element.modelo}</p>
					</div>
				`);
				})
			}
			$("#veiculo_procurados_adicionar").hide();
		}
		if (item.veiculosdata) {
			$("#veiculo_procurados_adicionar").show();
			$("#veiculo_procurados").show();
			$("#veiculo_procurados").empty();
			item.veiculosdata.forEach(element => {
				$("#veiculo_procurados").append(`
					<div onclick="veiculos(this)" data-id="${element.user_id}">
						<p class="name">${element.matricula}</p>
					</div>
				`);
			})
		}
		if (item.namelist) {
			$("#procurarnome_main").show();
			$("#procurarnome_resultados").show();
			$("#procurarnome_resultados").empty();
			item.namelist.forEach(element => {
				$("#procurarnome_resultados").append(`
					<div onclick="player(this)" data-id="${element.user_id}">
						<p class="name">${element.name}</p>
					</div>
				`);
			})
		}
		if(item.procuradosdata) {
			$("#player_procurados").show();
			$("#player_procurados").empty();
			item.procuradosdata.forEach(element => {
				$("#player_procurados").append(`
					<div onclick="player(this)" data-id="${element.user_id}">
						<p class="name">${element.name}</p>
					</div>
				`);
			})
		}
		if(item.playerdata){
			if (item.playerdata.id != undefined) {
				player_id = item.playerdata.id;
			}
			$("#player_avisos").empty();
			$("#player_arrests").empty();
			$("#player_multas").empty();
			$("#player_mandato").empty();
			if (item.playerdata.imagem !== undefined) {
				$("#procurarnome_playericon").attr("src",item.playerdata.imagem);	
			}
			if(item.playerdata.imagem == undefined) {
				$("#procurarnome_playericon").attr("src","https://i.imgur.com/pJ6hmOK.png");
			}
			$("#procurarnome_playername").html("Firstname | " + item.playerdata.name);
			$("#procurarnome_playerapelido").html("Last Name | " + item.playerdata.apelido);
			$("#procurarnome_playeridade").html("Age | " + item.playerdata.idade);
			$("#procurarnome_playerregistro").html("Registration | " + item.playerdata.registro);
			$("#procurarnome_playertelemovel").html("Phone | " + item.playerdata.telemovel);
			if (item.playerdata.porte == false)
			{
				$("#procurarnome_playerportearmas").html("Porte de Armas | Não Contem");
			} 
			else
			{
				$("#procurarnome_playerportearmas").html("Porte de Armas | Contem");
			}
			$("#player").show();
			if (item.playerdata.arrests != undefined)
			{
				item.playerdata.arrests.forEach(element => {
					$("#player_arrests").append(`
					<div>
						<p class="name">${element}</p>
					</div>
				`);
				})
			}
			if (item.playerdata.avisos != undefined)
			{
				item.playerdata.avisos.forEach(element => {
					$("#player_avisos").append(`
					<div>
						<p class="name">${element}</p>
					</div>
				`);
				})
			}
			if (item.playerdata.multas != undefined)
			{
				item.playerdata.multas.forEach(element => {
					$("#player_multas").append(`
					<div>
						<p class="name">${element}</p>
					</div>
				`);
				})
			}
			if (item.playerdata.mandato != undefined)
			{
				item.playerdata.mandato.forEach(element => {
					$("#player_mandato").append(`
					<div>
						<p class="name">${element}</p>
					</div>
				`);
				})
			}
		}
	});
	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post('http://vrp_menu_policia/close', JSON.stringify({}));
		}
	};
	$("#procurarnome").click(function () {
		$("#player").hide();
		$("#procurarnome_resultados").hide();
		$("#codigo").hide();
		$("#veiculos").hide();
		$("#player_procurados").hide();
		$("#procurarnome_main").css('display', 'block');
		$("#procurarmatricula_main").css('display', 'none');
		$("#player_procurados").css('display', 'none');
		$("#veiculo_procurados").css('display', 'none');
		$("#criardetencao").hide();
		$("#criaravisos").hide();
		$("#criarmandato").hide();
		$("#criarmultas").hide();
		$("#veiculo_procurados_adicionar").hide();
	})	
	$("#procurarmatricula").click(function () {
		$("#player").hide();
		$("#codigo").hide();
		$("#veiculos").hide();
		$("#procurarnome_resultados").hide();
		$("#player_procurados").hide();
		$("#procurarnome_main").css('display', 'none');
		$("#procurarmatricula_main").css('display', 'block');
		$("#player_procurados").css('display', 'none');
		$("#veiculo_procurados").css('display', 'none');
		$("#criardetencao").hide();
		$("#criaravisos").hide();
		$("#criarmandato").hide();
		$("#criarmultas").hide();
		$("#veiculo_procurados_adicionar").hide();
	})	
	$("#pessoasprocuradas").click(function () {
		$("#player").hide();
		$("#procurarnome_resultados").hide();
		$("#player_procurados").hide();
		$("#procurarnome_main").css('display', 'none');
		$("#procurarmatricula_main").css('display', 'none');
		$("#veiculo_procurados").css('display', 'none');
		$("#criardetencao").hide();
		$("#criaravisos").hide();
		$("#criarmandato").hide();
		$("#criarmultas").hide();
		$("#veiculo_procurados_adicionar").hide();
		$.post("http://vrp_menu_policia/procurados", JSON.stringify({}))
	})
	$("#veiculosprocurados").click(function () {
		$("#player").hide();
		$("#procurarnome_resultados").hide();
		$("#player_procurados").hide();
		$("#procurarnome_main").css('display', 'none');
		$("#procurarmatricula_main").css('display', 'none');
		$("#criardetencao").hide();
		$("#criaravisos").hide();
		$("#criarmandato").hide();
		$("#criarmultas").hide();
		$("#veiculo_procurados_adicionar").show();
		$.post("http://vrp_menu_policia/veiculosprocurados", JSON.stringify({}))
	})
	$("#codigopenal").click(function () {
		$("#player").hide();
		$("#procurarnome_resultados").hide();
		$("#player_procurados").hide();
		$("#procurarnome_main").css('display', 'none');
		$("#procurarmatricula_main").css('display', 'none');
		$("#veiculo_procurados").css('display', 'none');
		$("#codigo").show();
		$("#criardetencao").hide();
		$("#criaravisos").hide();
		$("#criarmandato").hide();
		$("#criarmultas").hide();
		$("#veiculo_procurados_adicionar").hide();
		$.post("http://vrp_menu_policia/codigopenal", JSON.stringify({}))
	})
	$("#procurarnome_procurar").click(function () {
		let firstname = $("#procurarnome_firstname").val()
		let lastname = $("#procurarnome_lastname").val()
		$.post("http://vrp_menu_policia/procurarnome", JSON.stringify({
			primeironome: firstname,
			ultimonome: lastname,
		}))
	})
	$("#procurarmatricula_procurar").click(function () {
		let matricula = $("#procurarmatricula_matricula").val()
		if (matricula.length > 0) {
			$("#procurarmatricula_main").css('display', 'none');
			$.post("http://vrp_menu_policia/procurarmatricula", JSON.stringify({
				matricula: matricula,
			}))
			return
		}
		return
	})
	$("#veiculos_eliminar").click(function () {
		$("#veiculos").hide();
		$.post("http://vrp_menu_policia/eliminarmatriculaprocurada", JSON.stringify({
			user_id: veiculos_id,
		}))
	})
	$("#procurarnome_player_limpar_aviso").click(function () {
		$.post("http://vrp_menu_policia/eliminaraviso", JSON.stringify({
			user_id: player_id,
		}))
	})
	$("#procurarnome_player_limpar_multas").click(function () {
		$.post("http://vrp_menu_policia/eliminarmultas", JSON.stringify({
			user_id: player_id,
		}))
	})
	$("#procurarnome_player_limpar_detenções").click(function () {
		$.post("http://vrp_menu_policia/eliminardetencoes", JSON.stringify({
			user_id: player_id,
		}))
	})
	$("#procurarnome_player_limpar_mandato").click(function () {
		$.post("http://vrp_menu_policia/eliminarmandato", JSON.stringify({
			user_id: player_id,
		}))
	})
	$("#procurarnome_player_criaraviso").click(function () {
		$("#criaravisos").show();
		$("#player").hide();
		var d = new Date();
		var n = d.toLocaleDateString();
		$(".criaravisos_text").html(n);
	})
	$("#procurarnome_player_criarrelatorio").click(function () {
		$("#criardetencao").show();
		$("#player").hide();
		var d = new Date();
		var n = d.toLocaleDateString();
		$(".criardetencao_text").html(n);
	})
	$("#procurarnome_player_criarmandato").click(function () {
		$("#criarmandato").show();
		$("#player").hide();
		var d = new Date();
		var n = d.toLocaleDateString();
		$(".criarmandato_text").html(n);
	})
	$("#procurarnome_player_criarmulta").click(function () {
		$("#player").hide();
		$("#criarmultas").show();
		var d = new Date();
		var n = d.toLocaleDateString();
		$(".criarmultas_text").html(n);
		$.post("http://vrp_menu_policia/multas", JSON.stringify({}))
	})
	$("#criar_avisos_button").click(function () {
		let data = $("#criaravisos_input").val();
		var d = new Date();
		var n = d.toLocaleDateString();
		var finaldata = "[" + n + "] " + data;
		if (data.length > 0) {
			$("#criaravisos_input").value = "";
			$("#criaravisos").hide();
			$("#player").show();
			$.post("http://vrp_menu_policia/avisos", JSON.stringify({
				user_id: player_id,
				avisos: finaldata,
			}))
		}
	})
	$("#criar_detencao_button").click(function () {
		let data = $("#criardetencao_input").val();
		var d = new Date();
		var n = d.toLocaleDateString();
		var finaldata = "[" + n + "] " + data;
		if (data.length > 0) {
			$("#criardetencao").hide();
			$("#player").show();
			$.post("http://vrp_menu_policia/detencao", JSON.stringify({
				user_id: player_id,
				data: finaldata,
			}))
		}
	})
	$("#criar_mandato_button").click(function () {
		let data = $("#criarmandato_input").val();
		var d = new Date();
		var n = d.toLocaleDateString();
		var finaldata = "[" + n + "] " + data;
		if (data.length > 0) {
			$("#criarmandato").hide();
			$("#player").show();
			$.post("http://vrp_menu_policia/mandato", JSON.stringify({
				user_id: player_id,
				data: finaldata,
			}))
		}
	})
	$("#procurarnome_player_imagebutton").click(function () {
		let data = $("#procurarnome_player_imageinput").val();
		if (data.length > 0) {
			$.post("http://vrp_menu_policia/imagem", JSON.stringify({
				user_id: player_id,
				data: data,
			}))
		}
	})
	$("#veiculo_procurados_adicionarbutton").click(function () {
		let data = $("#veiculo_procurados_adicionar_input").val();
		if (data.length > 0) {
			$.post("http://vrp_menu_policia/adicionarmatricula", JSON.stringify({
				data: data,
			}))
		}
	})
});

function display(bool) {
    if (bool) {
        $("#main").fadeIn();
	} else {
        $("#main").fadeOut();
    }
}
function player(element) {
	$("#procurarnome_resultados").hide();
	player_id = element.dataset.id;
	$.post("http://vrp_menu_policia/mostrarnome", JSON.stringify({
		user_id: player_id,
	}))
}
function veiculos(element) {
	$("#procurarnome_resultados").hide();
	veiculos_id = element.dataset.id;
	$.post("http://vrp_menu_policia/mostrarveiculo", JSON.stringify({
		user_id: veiculos_id,
	}))
}
function criarmulta(element) {
	$("#criarmultas").hide();
	$("#player").show();
	var d = new Date();
	var n = d.toLocaleDateString();
	var multa_id = element.dataset.id;
	$.post("http://vrp_menu_policia/multar", JSON.stringify({
		date: n,
		user_id: player_id,
		multa_id: multa_id,
	}))
}