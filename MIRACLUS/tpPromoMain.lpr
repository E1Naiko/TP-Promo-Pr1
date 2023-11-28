program tpPromoMain;
uses crt, SysUtils;
const
     constOPCIONES = 'C';
     constCATEGORIAS = 5;
type
    subrOpciones = 'A'..constOPCIONES;
    subrCategorias = 1 .. constCATEGORIAS;
    cadenaPreg = string;
    cadenaOpci = string;

    arrOpciones = array [subrOpciones] of cadenaOpci;

    tipoResultado = record
          correc, falso: cadenaOpci;
    end;

    tipoPreguntas = record
                  numCategoria: subrCategorias;
                  pregunta: cadenaPreg;
                  opciones: arrOpciones;
		  respuesta: subrOpciones;
                  result: tipoResultado;
	end;

    lista = ^nodo;
    nodo = record
                  datos: tipoPreguntas;
                  sig: lista;
    end;

    vdlCategorias = array [subrCategorias] of lista;













// --------------------------- MODULOS DE INTERFAZ DE USUARIO ---------------------------
procedure imprimirPregunta(p: tipoPreguntas); // UI - imprime la pregunta actual
          var I: subrOpciones;
          begin
               with p do begin
                    writeln(' - Pregunta: ', pregunta);
                    writeln(' -- Opciones:');
                    for I:='A' to constOPCIONES do
                        writeln(' --- [', I,']: ', p.opciones[I]);
                    end;
          end;

procedure precEnter(); // espera a que el jugador precione "ENTER" para continuar
          var K: char;
          begin
               writeln('                                     - Precione "INTRO" para continuar -');
               writeln('                ------------------------------------------------------------------------------');
               repeat K:= readkey;
                      until K = #13;
          end;

procedure precESC(); // espera a que el jugador precione "ESC" para continuar
          var K: char;
          begin
               writeln;
               writeln('                ------------------------------------------------------------------------------');
               writeln('                                Precione "ESC" para cerrar el programa');
               writeln('                ------------------------------------------------------------------------------');
               repeat K:= readkey;
               until K = #27;
          end;

procedure nuevaPartida(var ok:boolean); // espera a que el jugador precione "ESC" o "ENTER"
          var K: char;
          begin
               writeln;
               writeln('                      - Precione "ENTER" para jugar de nuevo o "ESC" para terminar -');
               writeln('                ------------------------------------------------------------------------------');
               repeat K:= readkey;
                      until (K = #13) or (K = #27);
               ok:= K = #27;
          end;

procedure intro();
          procedure apertura(); // UI - imprime la portada del juego y narra la historia del mismo
                    begin
                         writeln('                ------------------------------------------------------------------------------');
                         writeln('                                                 --MIRACLUS--');
                         writeln('                             *  / \_ *   /\_      _  *        *   /\*__        *');
                         writeln('                               /    \   /   \,   ((        .    _/  /  \  *.   ');
                         writeln('                          .   /\/\  /\ /:  __ \_  `          _^/  ^/    `--.    ');
                         writeln('                             /    \/  \  _/  \- \      *    /.  ^_   \_   . \  *');
                         writeln('                           /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \ ');
                         writeln('                          /  `-.__ ^   / .- .--\ =-=~_=-=~=^/  _ `--./ .-   `- \ ');
                         writeln('                         //\_     `.  / /       `.~-^=-=~=^=.-        -._ `._   \');
                         writeln('                 ~~    ~   ~~  __...---\../-...__ ~~~     ~~ __...---\../-...____\_');
                         writeln('        ~~~~  ~_,--·        \.     _ _       _ _   - - - -         _ _    ./      `--.__ ~~    ~~');
                         writeln('    ~~~  __,--·              `\- -     - -                     - -       -/"             `--.__   ~~~');
                         writeln('    ·------......______                                                          ______......------` ~~');
                         writeln('  ~~~   ~    ~~      ~ `````--__________                           ____-----"""""  ~~   ~     ~~');
                         writeln('         ~~~~    ~~  ~~~~               ·---------__________·------      ~~~~~~  ~ ~~   ~~ ~~~  ~');
                         writeln('      ~~   ~   ~~~     ~~~ ~                                                      ~~       ~~');
                         writeln;
                         writeln('     En una remota isla perdida en medio del oceano, entre unas ruinas antiguas, hallas un mapa ancestral');
                         writeln('  cuidadosamente oculto,revelando las claves para descifrar el enigmático código MIRACLUS. Este codigo,');
                         writeln('  envuelto en misterio y leyenda, guardaba el secreto para desvelar la ubicación de una joya única:');
                         writeln('                                         - EL DIAMANTE DEL LEON -');
                         writeln('                                                  _________');
                         writeln('                                               _ /_|_____|_\ _');
                         writeln('                                                 *. \ M / .*');
                         writeln('                                                   *.\ /.*');
                         writeln('                                                     *.*');
                         writeln;
                    end;
          procedure reglas(); // UI - imprime las reglas del juego
                    begin
                         writeln('                                                  --REGLAS--');
                         writeln('Deberas elegir entre 5 colores correspondientes a la cara del diamante, si contestas bien todas las preguntas correspondientes a cada cara del DIAMANTE DEL LEON ');
                    end;

          begin
               apertura();
               precEnter();

               clrscr;
               reglas();
               precEnter();

               clrscr;
         end;

procedure jugadorGano();
          begin
            writeln('                ------------------------------------------------------------------------------');
            writeln;
            writeln('                                               FELICIDADES');
            writeln('                                        CONSEGUISTE TODAS LAS CARAS');
            writeln('                                          DEL DIAMANTE DEL LEON');
            writeln;
            writeln('                                     ¿USARAS TUS PODERES PARA EL BIEN?');
            writeln;
            writeln;

          end;

procedure jugadorPerdio();
          begin
               writeln('                ------------------------------------------------------------------------------');
               writeln;
               writeln('                                               JUEGO TERMINADO');
               writeln('                                     FALLASTE EN CONSEGUIR TODAS LAS CARAS');
               writeln('                                            DEL DIAMANTE DEL LEON');
               writeln;
               writeln('                                      ¿USARAS TUS PODERES PARA EL BIEN?');
               writeln;
               writeln;
          end;

procedure contesto(ok: boolean; p: tipoPreguntas);
          begin
               if (ok) then begin
                    writeln(' - Correcto la resupuesta es ', p.respuesta, ' ya que:');
                    writeln(p.result.correc);
               end else begin
                    writeln(' - Fallaste la resupuesta es ', p.respuesta, ' ya que:');
                    writeln(p.result.falso);
               end;
               writeln;
               precEnter();
          end;










// --------------------------- MODULOS JUEGO ---------------------------
procedure partida(vdl: vdlCategorias; res: boolean);
          begin

          end;













// --------------------------- MODULOS DE SISTEMA ---------------------------
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
                  assign(archCategorias, 'DEBUGcategorias.txt'); // CAMBIARLO A categorias.txt -------------------------------------------------------------
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
                          readln(archCategorias, act.result.correc);
                          readln(archCategorias, act.result.falso);

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

// --------------------------- PROGRAMA PRINCIPAL ---------------------------
var
   vdl: vdlCategorias;
   resultado, ok: boolean;
begin
     // inicializacion
     resultado:= false; ok:=false;
     cargarVDL(vdl); // normalmente en la practica trabajamos con un "se dispone", decidimos crear un archivo 'categorias.txt' para cargarlo
     clrscr;

     // principal
     intro();
     while not(ok) do begin
           partida(vdl, resultado);

           if (resultado) then jugadorGano()
                       else jugadorPerdio();
           nuevaPartida(ok);
     end;
     // termina el juego
     precESC();
     liberarMemVDL(vdl);
end.

