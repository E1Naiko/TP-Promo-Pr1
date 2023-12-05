unit libCargaArch;
interface
		uses crt, SysUtils, libType;
		procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y se lo asigna a un Vector De Listas
		procedure liberarMemVDL(var vdl: vdlCategorias); // libera la memoria ocupada por el Vector De Listas

implementation
		procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y se lo asigna a un Vector De Listas
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
				var
					act: tipoPreguntas;
					archCategorias: text;
					Iopciones: subrOpciones;
					I: subrCategorias;
				begin
						// inicializo el VDL
						for I:=1 to constCATEGORIAS do   vdl[I]:= nil;
		
						// cargo datos desde el archivo 'categorias.txt'
						assign(archCategorias, 'DEBUGcategorias.txt'); // ------------------------------------------------------------- CAMBIARLO A categorias.txt
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
						while (vdl[I]<>nil) do begin
								aux:= vdl[I];
								vdl[I]:= vdl[I]^.sig;
								dispose(aux);
						end;
					end;
				end;
end.
