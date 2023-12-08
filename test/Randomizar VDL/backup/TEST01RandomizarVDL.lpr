program TEST01RandomizarVDL;
uses libUserInterface, crt, SysUtils, libSystem, ModuloCambiarPosicion;

procedure randomizarVDL_GPT(var vdl: vdlCategorias);
          var
            J: subrCategorias;
            I, total: integer;
          begin
            randomize;
            for J:=1 to constCATEGORIAS do begin
                total:= random(5)+1;
                for I:=1 to total do begin
                    CambiarPosicion(vdl[J], random(4), random(5));
                end;
            end;
          end;
procedure randomizarVDL(var vdl: vdlCategorias); // toma un vector de listas y randomiza la posicion de sus elementos
          Procedure eliminarValor (var pri: Lista; n:integer); // MODULO DE LA CATEDRA
                    Var act,ant:lista; ok:boolean;
                    Begin
                         act:= pri; ant:= pri; ok:= false;
                         while (act <> nil) and (not ok)do begin
                               if (act^.datos = n) then ok:= true
                               else begin
                                    ant:=act;
                                    act:= act^.sig;
                               end;
                         if (ok) then begin
                            if (act = pri) then pri:= act^.sig
                                           else ant^.sig:= act^.sig
                            dispose (act);
                         End;
                       End;
                    end;
          Procedure InsertarNodo (var pri: Lista; pos: integer; elem: tipoPreguntas); // MODULO DE LA CATEDRA
                    var
                      ant, nue, act: Lista;
                      encontre: boolean;
                      I: integer;
                    begin
                         encontre:= false;
                         new (nue); nue^.datos := elem;
                         act := pri; ant := pri;
                         I:=0;

                         while (act<>NIL) and (not encontre)) do begin
                               If (pos < I) then encontre:=true
                                  else begin
                                       I:=I+1;
                                       ant := act;
                                       act := act^.sig ;
                                  end;
                         end;
                         if (ant = act) then pri := nue
                                        else ant^.sig := nue;
                         nue^.sig := act ;
                    end;

          begin

          end;

procedure imprimirVDL(vdl: vdlCategorias);
            var I: subrCategorias;
            begin
              for I:=1 to constCATEGORIAS do begin
                  while (vdl[I].pri<>nil) do begin
                    writeln(vdl[I].pri^.datos.numPregunta,'/',vdl[I].pri^.datos.numCategoria);
                    vdl[I].pri:=vdl[I].pri^.sig;
                  end;
                  writeln;
              end;
            end;

var
  vdl: vdlCategorias;
  ver: string;

begin
  cargarVDL(vdl);
  imprimirVDL(vdl);
  readln(ver);
  ver:= UpperCase(ver);

  while (ver <> 'FIN') do begin
    randomizarVDL_GPT(vdl);
    imprimirVDL(vdl);
    writeln('grp');
    readln;

    randomizarVDL(vdl);
    readln(ver);
    ver:= UpperCase(ver);
  end;

  precESC();
  liberarMemVDL(vdl);
end.

