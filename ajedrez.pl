:- dynamic casilla/3.
%TODO: 
%movimiento de peones de 2 casillas solo el primer movimiento
%permitir bloqueo de jaques con otra pieza o comiendote a la pieza que realiza el jaque
%jaque mate como notificacion (actualmente si hay un jaque mate no va a permitir ningun movimiento del color en cuestion)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FACTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numero(a,1).
numero(b,2).
numero(c,3).
numero(d,4).
numero(e,5).
numero(f,6).
numero(g,7).
numero(h,8).

%piezas

rey(reyBlanco).
rey(reyNegro).

reina(reinaBlanca).
reina(reinaNegra).

peon(peonBlancoA).
peon(peonBlancoB).
peon(peonBlancoC).
peon(peonBlancoD).
peon(peonBlancoE).
peon(peonBlancoF).
peon(peonBlancoG).
peon(peonBlancoH).

peon(peonNegroA).
peon(peonNegroB).
peon(peonNegroC).
peon(peonNegroD).
peon(peonNegroE).
peon(peonNegroF).
peon(peonNegroG).
peon(peonNegroH).

alfil(alfilBlancoOscuras).
alfil(alfilBlancoClaras).

alfil(alfilNegroOscuras).
alfil(alfilNegroClaras).

torre(torreBlancaA).
torre(torreBlancaH).

torre(torreNegraA).
torre(torreNegraH).

caballo(caballoBlancoB).
caballo(caballoBlancoG).

caballo(caballoNegroB).
caballo(caballoNegroG).

%colores

blancas(reyBlanco).
blancas(reinaBlanca).
blancas(peonBlancoA).
blancas(peonBlancoB).
blancas(peonBlancoC).
blancas(peonBlancoD).
blancas(peonBlancoE).
blancas(peonBlancoF).
blancas(peonBlancoG).
blancas(peonBlancoH).
blancas(alfilBlancoOscuras).
blancas(alfilBlancoClaras).
blancas(torreBlancaA).
blancas(torreBlancaH).
blancas(caballoBlancoB).
blancas(caballoBlancoG).

negras(reyNegro).
negras(reinaNegra).
negras(peonNegroA).
negras(peonNegroB).
negras(peonNegroC).
negras(peonNegroD).
negras(peonNegroE).
negras(peonNegroF).
negras(peonNegroG).
negras(peonNegroH).
negras(alfilNegroOscuras).
negras(alfilNegroClaras).
negras(torreNegraA).
negras(torreNegraH).
negras(caballoNegroB).
negras(caballoNegroG).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TABLERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aqui editar e introducir piezas deseadas

%plantilla con el tablero completo ordinario

casilla(reyNegro, e, 8).

casilla(reyBlanco, d, 1).

casilla(reinaBlanca, e, 1).

casilla(reinaNegra, d, 8).

casilla(peonBlancoA, a, 2).
casilla(peonBlancoB, b, 2).
casilla(peonBlancoC, c, 2).
casilla(peonBlancoD, d, 2).
casilla(peonBlancoE, e, 2).
casilla(peonBlancoF, f, 2).
casilla(peonBlancoG, g, 2).
casilla(peonBlancoH, h, 2).

casilla(peonNegroA, a, 7).
casilla(peonNegroB, b, 7).
casilla(peonNegroC, c, 7).
casilla(peonNegroD, d, 7).
casilla(peonNegroE, e, 7).
casilla(peonNegroF, f, 7).
casilla(peonNegroG, g, 7).
casilla(peonNegroH, h, 7).

casilla(alfilBlancoOscuras, c, 1).
casilla(alfilBlancoClaras, f, 1).

casilla(alfilNegroOscuras, f, 1).
casilla(alfilNegroClaras, c, 1).

casilla(torreBlancaA, a, 1).
casilla(torreBlancaH, h, 1).

casilla(torreNegraA, a, 1).
casilla(torreNegraH, h, 1).

casilla(caballoBlancoB, b, 1).
casilla(caballoBlancoG, g, 1).

casilla(caballoNegroB, b, 8).
casilla(caballoNegroG, g, 8).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOGICA DE MOVIMIENTO DE PIEZAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% movimiento del rey
movimientoValidoRey(Pieza, ColumnaDestino, FilaDestino) :-
	rey(Pieza),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	abs(NumColumnaActual - NumColumnaDestino, AbsDistCol),
	AbsDistCol =< 1,
	abs(FilaActual - FilaDestino, AbsDistFila),
	AbsDistFila =< 1,
	simularJaqueReyFuturaPosicion(Pieza, ColumnaDestino, FilaDestino, Jaque),
	Jaque == noJaque.




% movimiento de los peones
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	peon(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	(blancas(Pieza) -> 
		FilaDestino - FilaActual =:= 1
	; negras(Pieza) ->
		FilaDestino - FilaActual =:= -1
	),
	ColumnaDestino == ColumnaActual.

%peon comiendo a otra pieza, movimiento diagonal
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	peon(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	casilla(_, ColumnaDestino, FilaDestino),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	( blancas(Pieza) -> 
		FilaDestino - FilaActual =:= 1	
	; negras(Pieza) ->
		FilaDestino - FilaActual =:= -1
	),
	abs(NumColumnaDestino - NumColumnaActual, AbsDistCol),
	AbsDistCol =:= 1.


% movimiento de los alfiles 
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	alfil(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	DistFila is FilaDestino - FilaActual,
	DistCol is NumColumnaDestino - NumColumnaActual,
	abs(DistCol, DistColAbs),
	abs(DistFila, DistFilaAbs),
	DistColAbs =:= DistFilaAbs,
	%revisar colision
	DireccionColumna is DistCol/DistColAbs, %direccion en el eje de columnas ya sea -1 hacia la izquierda o 1 hacia la derecha
	DireccionFila is DistFila/DistFilaAbs, %direccion -1 es hacia abajo y 1 hacia arriba
	rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino).





% movimiento de las TORRES
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	torre(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	(FilaActual =:= FilaDestino; ColumnaActual == ColumnaDestino),
	%si el movimiento es en la misma fila, se halla la direccion en la columna, hacia la izquierda o derecha
	(FilaActual =:= FilaDestino -> (
		DireccionFila is 0,
		DistCol is NumColumnaDestino - NumColumnaActual,
		abs(DistCol, DistColAbs),
		DireccionColumna is DistCol/DistColAbs
	);
	%si el movimiento es en la misma columna, se halla la direccion en la fila, hacia arriba o abajo
	ColumnaActual == ColumnaDestino -> (
		DireccionColumna is 0,
		DistFila is FilaDestino - FilaActual,
		abs(DistFila, DistFilaAbs),
		DireccionFila is DistFila/DistFilaAbs
	)),
	rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino).



% movimiento horizontal y vertical de las REINAS
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	reina(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	(FilaActual =:= FilaDestino; ColumnaActual == ColumnaDestino),
	%si el movimiento es en la misma fila, se halla la direccion en la columna, hacia la izquierda o derecha
	(FilaActual =:= FilaDestino -> (
		DireccionFila is 0,
		DistCol is NumColumnaDestino - NumColumnaActual,
		abs(DistCol, DistColAbs),
		DireccionColumna is DistCol/DistColAbs
	);
	%si el movimiento es en la misma columna, se halla la direccion en la fila, hacia arriba o abajo
	ColumnaActual == ColumnaDestino -> (
		DireccionColumna is 0,
		DistFila is FilaDestino - FilaActual,
		abs(DistFila, DistFilaAbs),
		DireccionFila is DistFila/DistFilaAbs
	)),
	rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino).

% movimiento diagonal de las REINAS
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	reina(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	DistFila is FilaDestino - FilaActual,
	DistCol is NumColumnaDestino - NumColumnaActual,
	abs(DistCol, DistColAbs),
	abs(DistFila, DistFilaAbs),
	DistColAbs =:= DistFilaAbs,
	%revisar colision
	DireccionColumna is DistCol/DistColAbs, %direccion en el eje de columnas ya sea -1 hacia la izquierda o 1 hacia la derecha
	DireccionFila is DistFila/DistFilaAbs, %direccion -1 es hacia abajo y 1 hacia arriba
	rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino).


% movimiento de los CABALLOS
movimientoValido(Pieza, ColumnaDestino, FilaDestino) :-
	caballo(Pieza),
	movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino),
	casilla(Pieza, ColumnaActual, FilaActual),
	numero(ColumnaDestino, NumColumnaDestino),
	numero(ColumnaActual, NumColumnaActual),
	DistFila is FilaDestino - FilaActual,
	DistCol is NumColumnaDestino - NumColumnaActual,
	abs(DistCol, DistColAbs),
	abs(DistFila, DistFilaAbs),
	(DistColAbs =:= 2 ->
		DistFilaAbs =:= 1
	;
	DistFilaAbs =:= 2 ->
		DistColAbs =:= 1).



%revisa si hay piezas en las casillas de una recta, se detiene una antes del destino, solo es para revisar el camino en medio y no el destino
rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino) :-
	NumColumnaActual + DireccionColumna =:= NumColumnaDestino,
	FilaActual + DireccionFila =:= FilaDestino.

rectaSinColision(NumColumnaActual, FilaActual, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino) :-
	NumColumnaActual2 is NumColumnaActual + DireccionColumna,
	FilaActual2 is FilaActual + DireccionFila,
	numero(ColumnaActual, NumColumnaActual2),
	\+ casilla(_, ColumnaActual, FilaActual2),
	rectaSinColision(NumColumnaActual2, FilaActual2, DireccionColumna, DireccionFila, NumColumnaDestino, FilaDestino).
	

%movimiento hacia casilla vacia
movimientoValidoPorColor(_, ColumnaDestino, FilaDestino) :-
	\+ casilla(_, ColumnaDestino, FilaDestino).
	
%movimiento pieza blanca hacia negra
movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino) :-
	casilla(Pieza2, ColumnaDestino, FilaDestino),
	blancas(Pieza),
	negras(Pieza2).

%movimiento pieza negra hacia blanca
movimientoValidoPorColor(Pieza, ColumnaDestino, FilaDestino) :-
	casilla(Pieza2, ColumnaDestino, FilaDestino),
	blancas(Pieza2),
	negras(Pieza).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOGICA DE JAQUE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%revisa si el rey esta en jaque
reyEnJaque(Rey) :-
	casilla(Rey, ColumnaActual, FilaActual),
	movimientoValido(_, ColumnaActual, FilaActual).




%rey se intenta mover a casilla vacia
simularJaqueReyFuturaPosicion(Rey, ColumnaDestino, FilaDestino, Jaque) :-
	\+ casilla(_, ColumnaDestino, FilaDestino),
	casilla(Rey, ColumnaActual, FilaActual),

	%realizar movimiento
	retractall(casilla(Rey, _, _)),
	assert(casilla(Rey, ColumnaDestino, FilaDestino)),
	
	%revisar jaque
	((reyEnJaque(Rey), Jaque = jaque); 
	(\+ reyEnJaque(Rey), Jaque = noJaque)),
	

	%regresar rey a posicion antigua
	retractall(casilla(Rey, ColumnaDestino, FilaDestino)),
	assert(casilla(Rey, ColumnaActual, FilaActual)),
	!.




%rey se intenta mover y comer a otra pieza
simularJaqueReyFuturaPosicion(Rey, ColumnaDestino, FilaDestino, Jaque) :-
	casilla(Pieza, ColumnaDestino, FilaDestino),
	casilla(Rey, ColumnaActual, FilaActual),

	%realizar movimiento
	retractall(casilla(Pieza, ColumnaDestino, FilaDestino)),
	retractall(casilla(Rey, _, _)),
	assert(casilla(Rey, ColumnaDestino, FilaDestino)),

	%revisar jaque
	((reyEnJaque(Rey), Jaque = jaque); 
	(\+ reyEnJaque(Rey), Jaque = noJaque)),
	

	%regresar a posicion antigua
	retractall(casilla(Rey, ColumnaDestino, FilaDestino)),
	assert(casilla(Pieza, ColumnaDestino, FilaDestino)),
	assert(casilla(Rey, ColumnaActual, FilaActual)),
	!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ASSERTS Y LOGICA MOVIMIENTO DE PIEZAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% movimiento assert del rey (movimientoValidoRey tiene que ser distinto si no reyEnJaque genera una recursion infinita)
moverPieza(Pieza, ColumnaDestino, FilaDestino) :-
	filaValida(FilaDestino),
	movimientoValidoRey(Pieza, ColumnaDestino, FilaDestino),
	retractall(casilla(_, ColumnaDestino, FilaDestino)),
	retractall(casilla(Pieza, _, __)),
	assert(casilla(Pieza, ColumnaDestino, FilaDestino)),
	!.
	


% movimiento assert de las piezas
moverPieza(Pieza, ColumnaDestino, FilaDestino) :-
	filaValida(FilaDestino),
	movimientoValido(Pieza, ColumnaDestino, FilaDestino),
	movimientoValidoPorJaqueActual(Pieza),
	retractall(casilla(_, ColumnaDestino, FilaDestino)),
	retractall(casilla(Pieza, _, __)),
	assert(casilla(Pieza, ColumnaDestino, FilaDestino)),
	!.
	


% verifica que la fila sea valida
filaValida(FilaDestino) :-
	FilaDestino > 0,
	FilaDestino < 9.


% funcion simple para conseguir el color de una pieza
colorPieza(Pieza, Color) :-
	(blancas(Pieza) -> Color = blancas;
	negras(Pieza) -> Color = negras).


% revisa que un color no pueda mover una pieza mientras su rey esta en jaque
movimientoValidoPorJaqueActual(Pieza) :-
	colorPieza(Pieza, Color),
	Color == negras,
	(reyEnJaque(reyNegro) ->
	print('Rey negro en jaque'),
	fail;
	\+ reyEnJaque(reyNegro)).

movimientoValidoPorJaqueActual(Pieza) :-
	colorPieza(Pieza, Color),
	Color == blancas,
	(reyEnJaque(reyBlanco) ->
	print('Rey blanco en jaque'),
	fail;
	\+ reyEnJaque(reyBlanco)).

	