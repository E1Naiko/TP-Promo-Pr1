program testCargaDatosCategoria;
uses crt, SysUtils;
const
	constOPCIONES = 'C';
	constFILAS = 2;
	constCOLUMNAS = 2;
type
	subrOpciones = 'A'..constOPCIONES;
	cadena = string;
	cadVerif = string[2];
	
	arrOpciones = array [subrOpciones] of cadena;
	tipoPreguntas = record
		pregunta: cadena;
		opciones: arrOpciones;
		respuesta: subrOpciones;
	end;
	
	subrFila = 1..constFILAS;
	subrColumna = 1..constCOLUMNAS;
	matrCategorias = array [subrFila, subrColumna] of tipoPreguntas;
	
// ---------------------------- MODULOS RELACIONADOS A LA MATRIZ ----------------------------
procedure imprimirPregunta(p: tipoPreguntas);
	var I: subrOpciones;
	begin
		with p do begin
			writeln(' - Pregunta: ', pregunta);
			writeln(' -- Opciones:');
			for I:='A' to constOPCIONES do
				writeln(' --- [', I,']: ', p.opciones[I]);
			writeln(' -- Respuesta: ', respuesta);
			writeln;
		end;
	end;

procedure imprimirMatriz(m: matrCategorias);
	var
		I: subrFila;
		J: subrColumna;
	begin
		for J:=1 to constCOLUMNAS do begin
			writeln('Columna ', J);
			for I:=1 to constFILAS do
				imprimirPregunta(m[I,J]);
		end;
	end;	
		
procedure cargaMatriz(var m: matrCategorias); // CARGA GENERAL DE LA MATRIZ
	procedure cargaOpciones(var v:arrOpciones); // CARGA EL VECTOR DE OPCIONES
		var I: subrOpciones;
		begin
			for I:='A' to constOPCIONES do begin
				writeln(' -- Introduzca Opcion "', I, '"');
				readln(v[I]);
			end;
		end;
		
	procedure cargaRespuesta(var r: subrOpciones); // CARGA DEL VALOR DE RESPUESTA
		type conjVal = set of char;
		var
			act: char;
			ok: boolean;
			conj: conjVal;
		begin
			conj:= ['A'..constOPCIONES];
			ok:=false;
			
			while not(ok) do begin
				writeln('Introduca la opcion correcta:');
				readln(act);
				act:= UpCase(act);
				
				if (act in conj) then ok:= true
									else writeln('ERROR');
			end;
			r:= act;
		end;
	function verificacionPreg(act: tipoPreguntas): boolean; // CHEQUEO DE CADA PREGUNTA PARA EL USUARIO
		var verificacion: cadVerif;
		begin
			Writeln('------------------------------------------------------');
			writeln(' Pregunta:');
			imprimirPregunta(act);
			writeln(' ----- ¿Autoriza el ingreso de la pregunta a la base de datos? (si) -----');
			readln(verificacion);
			verificacion:= UpperCase(verificacion);
			verificacionPreg:= verificacion = 'SI';
		end;
		
	function verificacionColumna(m: matrCategorias; J: subrCOLUMNA): boolean; // CHEQUEO DE CADA COLUMNA PARA EL USUARIO
		var
			I: subrFila;
			verificacion: cadVerif;
		begin
			Writeln('------------------------------------------------------');
			writeln('Columna ', J);
			for I:= 1 to constFILAS do
				imprimirPregunta(m[I,J]);
			writeln(' ----- ¿Autoriza el ingreso de columna a la base de datos? (si) -----');
			readln(verificacion);
			verificacion:= UpperCase(verificacion);
			verificacionColumna:= verificacion = 'SI';
		end;
		
		function verificacionMatr(m: matrCategorias): boolean; // CHEQUEO FINAL DE LA MATRIZ PARA EL USUARIO
		var verificacion: cadVerif;
		begin
			Writeln('------------------------------------------------------');
			writeln(' Resultado:');
			imprimirMatriz(m);
			writeln(' ----- ¿Autoriza el ingreso de la matriz a la base de datos? (si) -----');
			readln(verificacion);
			verificacion:= UpperCase(verificacion);
			verificacionMatr:= verificacion = 'SI';
		end;
	
	var
		I: subrFila;
		J: subrColumna;
		act: tipoPreguntas;
		ok, okJ, okI: boolean;
		
	begin
		okI:=false;
		while not(okI) do begin
			for J:=1 to constCOLUMNAS do begin
				okJ:=false;
				while not(okJ) do begin
					for I:=1 to constFILAS do begin
						ok:=false;
						while not(ok) do begin
							clrscr;
							writeln('Introduzca la pregunta [', I, '/', J,']:');
							readln(act.pregunta);
							cargaOpciones(act.opciones);
							cargaRespuesta(act.respuesta);
							
							ok:= verificacionPreg(act);
						end;
						m[I,J]:= act;
					end;
					clrscr;
					okJ:= verificacionColumna(m, J);
				end;
			end;
			okI:= verificacionMatr(m);
		end;
		writeln(' ------------- FIN CARGA DE LA MATRIZ -------------');
	end;
// ---------------------------- FIN MODULOS RELACIONADOS A LA MATRIZ ----------------------------
procedure cargaArchivo(m:matrCategorias);
	var
		archCategorias: file of matrCategorias;
	begin
		assign(archCategorias, 'TESTcategorias');
		rewrite(archCategorias);
		write(archCategorias, m);		
		close(archCategorias);
	end;

// ---------------------------- PROGRAMA PRINCIPAL ----------------------------
var
	m: matrCategorias;
begin
	clrscr;
	cargaMatriz(m);
	cargaArchivo(m);
end.
