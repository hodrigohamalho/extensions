jQuery(function(){
	// Cria uma pilha para permitir que seja possivel uma pausa entre a exibicao dos flahs
	var stack = {
		delay: 5000,
		actions:[],
		run: function() {
			if (stack.actions.length) { // Verifica se existe elemento na pilha
				stack.actions.shift()(); // Desempilha
		    	setTimeout(stack.run, stack.delay); // Semelhante ao sleep do java.
		  	}else{ // Quando a pilha ficar vazia recomece o ciclo.
		  		$($("#slideshow li")).hide();
			  	showElements();
			  	stack.run();
			}
		  	
		}
	};

	function showElements(){
		$("#slideshow li").each(function(index){ // itera sobre os itens
			var that = this;
			stack.actions.push(function(){ // empilha essas acoes
				$(that).animate({ "height": "toggle", "opacity": "toggle"}, "slow" );	// Mostra o flash atual
				$($("#slideshow li")[index-1]).hide("slow"); // Esconde o flash anterior
			});
		});
	}

	showElements();
	stack.run();
});
