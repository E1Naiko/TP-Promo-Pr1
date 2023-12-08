unit typeYcargaLista;
interface
                uses TEST4LecturaDatosCategoria;

                procedure inicializarVDL(var vdl: vdlCategorias);
                procedure insertarFinal(var l: tipoLista; elem: tipoPreguntas);
                procedure liberarMemVDL(var vdl: vdlCategorias);


implementation
procedure insertarFinal(var l: tipoLista; elem: tipoPreguntas); // ----------------------------------------------------------- optimizar
		var nue: lista;
		begin
				new(nue); nue^.datos:= elem; nue^.sig:= nil;
				if (l.pri = nil) then l.pri:= nue
								 else l.ult^.sig:= nue;
				l.ult:= nue;
		end;
procedure inicializarVDL(var vdl: vdlCategorias);
          var I: subrCategorias;
          begin
               for I:=1 to constCATEGORIAS do begin
					vdl[I].pri:= nil;
					vdl[I].ult:= nil;
	       end;
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

