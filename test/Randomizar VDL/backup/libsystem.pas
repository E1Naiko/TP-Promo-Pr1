unit libSystem;

interface

uses
  Classes, SysUtils, libUserInterface;

  procedure agregarFinal(var l: tipoLista; elem: tipoPreguntas);
  procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y carga una cantidad aleatoria de listas
  procedure liberarMemVDL(var vdl: vdlCategorias); // libera la memoria ocupada por el Vector De Listas

implementation
procedure agregarFinal(var l: tipoLista; elem: tipoPreguntas);
		var nue: lista;
		begin
				new(nue); nue^.datos:= elem; nue^.sig:= nil;
				if (l.pri = nil) then l.pri:= nue
								 else l.ult^.sig:= nue;
				l.ult:= nue;
		end;
procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y carga una cantidad aleatoria de listas
		var
			act: tipoPreguntas;
			archCategorias: text;
			Iopciones: subrOpciones;
			I: subrCategorias;
		begin
				// inicializo el VDL
				for I:=1 to constCATEGORIAS do begin
						vdl[I].pri:= nil;
						vdl[I].ult:= nil;
				end;

				// cargo datos desde el archivo 'categorias.txt'
				assign(archCategorias, 'categorias.txt');
				reset(archCategorias);
				while not(eof(archCategorias)) do begin
					// leo a que categoria pertenece la pregunta
					readln(archCategorias, act.numCategoria);

					// leo la pregunta en si y sus opciones
					readln(archCategorias, act.pregunta);
					for Iopciones:= 'A' to constOPCIONES do begin
							readln(archCategorias, act.opciones[Iopciones]);
					end;

					// leo la respuesta correcta y sus respuestas
					readln(archCategorias, act.respuesta);
					readln(archCategorias, act.explicacion);

					// agrego al Vector De Listas
					agregarFinal(vdl[act.numCategoria], act);

				end;
				close(archCategorias);
		end;

procedure liberarMemVDL(var vdl: vdlCategorias); // libera la memoria ocupada por el Vector De Listas
		var
			aux: lista;
			I: subrCategorias;
		begin
			// recorro el vector de listas
			for I:=1 to constCATEGORIAS do begin

				// libero memoria de la lista actual
				while (vdl[I].pri<>nil) do begin
						aux:= vdl[I].pri;
						vdl[I].pri:= vdl[I].pri^.sig;
						dispose(aux);
				end;
			end;
		end;

end.

