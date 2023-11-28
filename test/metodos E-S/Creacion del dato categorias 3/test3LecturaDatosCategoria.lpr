program test3LecturaDatosCategoria;
const
     constOPCIONES = 'C';
     constCATEGORIAS = 5;
type
    subrOpciones = 'A'..constOPCIONES;
    subrCategorias = 1 .. constCATEGORIAS;
    cadenaPreg = string;
    cadenaOpci = string;

    arrOpciones = array [subrOpciones] of cadenaOpci;
    tipoPreguntas = record
                  numCategoria: subrCategorias;
                  pregunta: cadenaPreg;
                  opciones: arrOpciones;
		  respuesta: subrOpciones;
	end;

    lista = ^nodo;
    nodo = record
                  datos: tipoPreguntas;
                  sig: lista;
    end;

    vdlCategorias = array [subrCategorias] of lista;

// MODULOS
procedure imprimirPregunta(p: tipoPreguntas);
	var I: subrOpciones;
	begin
		with p do begin
                        writeln(' - Categoria: ', numCategoria);
			writeln(' -- Pregunta: ', pregunta);
			writeln(' --- Opciones:');
			for I:='A' to constOPCIONES do
				writeln(' ---- [', I,']: ', p.opciones[I]);
			writeln(' -- Respuesta: ', respuesta);
			writeln;
		end;
	end;
procedure imprimirVDL(vdl: vdlCategorias);
	var
		I: subrCategorias;
	begin
		for I:=1 to constCATEGORIAS do begin
			writeln(' ---------------- Categoria ', I, ' ----------------');
			while (vdl[I]<>nil) do begin
				imprimirPregunta(vdl[I]^.datos);
                                vdl[I]:= vdl[I]^.sig;
                        end;
                end;
	end;

procedure cargarVDL(var vdl: vdlCategorias);
          procedure agregarFinal(var l: lista; elem: tipoPreguntas);
                    var act, ant, nue: lista;
                    begin
                            new(nue); nue^.datos:= elem; nue^.sig:= nil;
                            if (l=nil) then l:=nue
                                       else begin
                                            act:=l; ant:=l;
                                            while (act<>nil) do begin
                                                         ant:= act;
                                                         act:= act^.sig;
                                            end;
                                            ant^.sig:= nue;
                            end;
                    end;

          procedure inicializarVDL(var vdl: vdlCategorias);
                    var I: subrCategorias;
                    begin
                            for I:=1 to constCATEGORIAS do   vdl[I]:= nil;
                    end;

          type
              auxBool = string[6];
              tipoLinea = record
                    cat: subrCategorias;
                    cara: auxBool;
                    preg: cadenaPreg;
                    opci: cadenaOpci;
                    resp: char;
              end;

          var
             act: tipoPreguntas;
             archCategorias: text;
             linea: tipoLinea;
             Iopciones: subrOpciones;
             I: subrCategorias;
          begin
                  assign(archCategorias, 'DEBUGcategorias.txt');
                  reset(archCategorias);
                  while not(eof(archCategorias)) do begin
                          // leo a que categoria pertenece la pregunta
                          with linea do begin
                            readln(archCategorias, cat);
                            act.numCategoria:= cat;

                            // leo la pregunta en si y sus opciones
                            readln(archCategorias, preg);
                            act.pregunta:= preg;
                            for Iopciones:= 'A' to constOPCIONES do begin
                                    readln(archCategorias, opci);
                                    act.opciones[Iopciones]:= opci;
                            end;
                            readln(archCategorias, resp);
                            act.respuesta:= resp;
                          end;

                          // agrego al Vector De Listas
                          agregarFinal(vdl[act.numCategoria], act);

                  end;
                  close(archCategorias);
          end;

var
   vdl: vdlCategorias;
begin
  cargarVDL(vdl);
  imprimirVDL(vdl);
  readln;
end.

