unit libMatrices;

interface
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
		
	procedure imprimirPregunta(p: tipoPreguntas);
	procedure imprimirMatriz(m: matrCategorias);

implementation

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
end.
