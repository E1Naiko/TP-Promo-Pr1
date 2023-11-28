program test2LecturaDatosCategoria;
const
     constOPCIONES = 'C';
     constFILAS = 5;
     constCOLUMNAS =5;
type
    subrOpciones = 'A'..constOPCIONES;
    cadena = string;

    arrOpciones = array [subrOpciones] of cadena;
    tipoPreguntas = record
                  pregunta: cadena;
                  opciones: arrOpciones;
		  respuesta: subrOpciones;
	end;

    subrFila = 1..constFILAS;
    subrColumna = 1..constCOLUMNAS;
    matrCategorias = array [subrFila, subrColumna] of tipoPreguntas;

// MODULOS
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
			writeln(' ---------------- Columna ', J, ' ----------------');
			for I:=1 to constFILAS do
				imprimirPregunta(m[I,J]);
		end;
	end;

procedure cargarMatriz(var m: matrCategorias);
          var
             act: tipoPreguntas;
             archCategorias: text;
             lineaStr: cadena;
             lineaChar: char;
             Iopciones: subrOpciones;
             J: subrColumna;
             I: subrFila;
          begin
                  assign(archCategorias, 'categorias');
                  reset(archCategorias);
                  while not(eof(archCategorias)) do begin
                        for J:=1 to constCOLUMNAS do begin
                            for I:=1 to constFILAS do begin
                                        readln(archCategorias, lineaStr);
                                        act.pregunta:= lineaStr;
                                        for Iopciones:= 'A' to constOPCIONES do begin
                                              readln(archCategorias, lineaStr);
                                              act.opciones[Iopciones]:= lineaStr;
                                        end;
                                        readln(archCategorias, lineaChar);
                                        act.respuesta:= lineaChar;
                                        m[I,J]:= act;
                                  end;
                          end;
                  end;
                  close(archCategorias);
          end;

var
   m: matrCategorias;
begin
  cargarMatriz(m);
  imprimirMatriz(m);
  readln;
end.

