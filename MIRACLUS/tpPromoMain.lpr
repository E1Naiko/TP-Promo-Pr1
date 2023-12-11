program tpPromoMain;
uses crt, SysUtils;
const
	constOPCIONES = 'C';
	constCATEGORIAS = 5;
	constERRORES = 3;
        constERRORDESAFIO = 2;
type
	subrOpciones = 'A' .. constOPCIONES;
	subrCategorias = 1 .. constCATEGORIAS;

	conjCompletadas = set of subrCategorias;
	conjRespuestas = set of char;

	cadenaPreg = string[110];
	cadenaOpci = string[240];

	arrOpciones = array [subrOpciones] of cadenaOpci;

	tipoPreguntas = record
		numCategoria: subrCategorias;
		pregunta: cadenaPreg;
		opciones: arrOpciones;
		respuesta: subrOpciones;
		explicacion: cadenaOpci;
	end;

	lista = ^nodo;
	nodo = record
		datos: tipoPreguntas;
		sig: lista;
	end;

	tipoLista = record
			pri, ult: lista;
		end;

	vdlCategorias = array [subrCategorias] of tipoLista;






// --------------------------- MODULOS DE INTERFAZ ---------------------------
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

procedure nuevaPartida(var ok: boolean); // espera a que el jugador precione "ESC" o "ENTER"
                // como en la catedra no nos recomiendan imprimir o leer desde teclado dentro de una funcion decidimos usar un procedimiento
                var K: char;
		begin
		     writeln;
		     writeln('                      - Precione "ENTER" para jugar de nuevo o "ESC" para terminar -');
		     writeln('                ------------------------------------------------------------------------------');
		     repeat K:= readkey
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
				writeln;
				writeln('            Deberas elegir entre 5 colores correspondientes a la cara del diamante,');
				writeln('     si contestas bien todas las preguntas correspondientes a cada cara del DIAMANTE DEL LEON ');
				writeln;
			  end;

		begin
                     clrscr;
		     apertura();
		     precEnter();

		     clrscr;
		     reglas();
		     precEnter();

		     clrscr;
		end;

procedure outro();
		begin
		     ClrScr;
		     writeln('                ------------------------------------------------------------------------------');
		     writeln('                                                 --MIRACLUS--');
		     writeln('                                                  _________');
		     writeln('                                               _ /_|_____|_\ _');
		     writeln('                                                 *. \ M / .*');
		     writeln('                                                   *.\ /.*');
		     writeln('                                                     *.*');
		     writeln;
		     writeln('                                              Gracias Por Jugar');
		     precESC();
		end;

procedure jugadorGano();
		begin
		     clrscr;
		     writeln('                ------------------------------------------------------------------------------');
		     writeln;
		     writeln('                                               FELICIDADES');
		     writeln('                                        CONSEGUISTE TODAS LAS CARAS');
		     writeln('                                          DEL DIAMANTE DEL LEON');
                     writeln('                                     DESCIFRASTE EL CODIGO MIRACLUS!!!!');
		     writeln;
		     writeln('                                      USARAS TUS PODERES PARA EL BIEN?');
		     writeln;
		     writeln;

		end;

procedure jugadorPerdio();
		begin
		     clrscr;
		     writeln('                ------------------------------------------------------------------------------');
		     writeln;
		     writeln('                                               JUEGO TERMINADO');
		     writeln('                                     FALLASTE EN CONSEGUIR TODAS LAS CARAS');
		     writeln('                                            DEL DIAMANTE DEL LEON');
		     writeln;
		end;

procedure contesto(ok: boolean; p: tipoPreguntas);
		begin
		     if (ok) then writeln(' - Correcto la respuesta es ', p.respuesta, ' ya que:')
		             else writeln(' - Fallaste la respuesta es ', p.respuesta, ' ya que:');
                     writeln(p.explicacion);
		     writeln;
		     precEnter();
		end;

procedure presentarPuntuacion(puntaje, error, errordesafio: integer); // presenta el puntaje final de cada partida
		begin
		     writeln('                                               -- Puntuacion Final --');
		     writeln('                                            -- Puntaje obtenido: ', puntaje, ' --');
		     writeln('                                                -- Errores: ', error, '/', constERRORES, '--');
                     writeln('                                    -- Intentos de caras de diamante: ', errordesafio, '/', constERRORDESAFIO, ' --');
		end;

procedure presentarColor(comp: conjCompletadas; errores, errordesafio: integer); // presenta las opciones de colores
		begin
		     ClrScr;
		     writeln('                ------------------------------------------------------------------------------');
                     writeln;
		     writeln('                                                  -- Errores: ', errores, '/', constERRORES, ' --');
                     writeln('                                      -- Intentos de caras del diamante: ', errordesafio, '/', constERRORDESAFIO, ' --');
		     writeln('                                -- Que cara del Diamante deseas intentar completar? --');
		     writeln;

		     // IMPRIMIMOS LAS CATEGORIAS
		     TextColor(Red);

		     IF (1 in comp) then writeln('         -- CARA ROJA OBTENIDA --')
				    else writeln('         -- Rojo: "I - Conceptos Introductorios" -- ');

		     TextColor(LightGreen);
		     IF (2 in comp) then writeln('         -- CARA VERDE OBTENIDA --')
				    else writeln('         -- Verde: "II - Modularizacion, parametros" -- ');

		     TextColor(LightBlue);
		     IF (3 in comp) then writeln('         -- CARA AZUL OBTENIDA --')
				    else writeln('         -- Azul: "III - Organizacion" -- ');

                     TextColor(Yellow);
		     IF (4 in comp) then writeln('         -- CARA AMARILLA OBTENIDA --')
				    else writeln('         -- Amarillo: "IV - Estructuras de control de datos y registros" -- ');

		     TextColor(LightMagenta);
		     IF (5 in comp) then writeln('         -- CARA MORADA OBTENIDA --')
				    else writeln('         -- Morado: "V - Arreglos y Listas" --');

		     TextColor(white);
		     writeln;
		     writeln('Introduzca la cara del diamante que desea intentar completar:');
	        end;

procedure presentarPregunta(p: tipoPreguntas; errores, errordesafio: integer);
                begin
		     clrscr;
		     writeln('                ------------------------------------------------------------------------------');
		     write('	        Categoria: ', p.numCategoria);
		     write(' -- Errores: ', errores, '/', constERRORES);
                     write(' -- Intentos de caras del diamante: ', errordesafio,'/', constERRORDESAFIO, ' --');
		     writeln;
		     imprimirPregunta(p);
	        end;
// --------------------------- FIN MODULOS DE INTERFAZ ---------------------------






// --------------------------- MODULOS DEL JUEGO ---------------------------
procedure elegirColor(var catActual: subrCategorias; var valido: boolean);
                var color: string;
	        begin
                     readln(color);
                     color:= LowerCase(color);

                     // detecto que color eligio el jugador
                     case color of
                          'rojo', '1' : begin
                                Valido:= true;
                                catActual:= 1;
                           end;
                          'verde', '2' : begin
                                Valido:= true;
                                catActual:= 2;
                            end;
                          'azul', '3' : begin
                                Valido:= true;
                                catActual:= 3;
                              end;
                          'amarillo', '4' : begin
                                Valido:= true;
                                catActual:= 4;
                              end;
                          'morado', '5' : begin
                                Valido:= true;
                                catActual:= 5;
                             end;
                          else Valido:= false;
                     end;
		end;

Procedure Preguntas(var Preguntas: Lista; var puntaje, error, errordesafio: integer; var continuarPartida: boolean; var completadas: conjCompletadas);
                        // recorre las preguntas de la categoria
          var
             respuesta: subrOpciones;
             conjres: conjRespuestas;
          begin
			   // inicializo
               conjres:= ['A','B','C'];

               // recorro cada preguntas
               while (Preguntas <> nil) and (continuarPartida) and (error < constERRORES) and (errordesafio < constERRORDESAFIO) do begin
                     presentarPregunta(Preguntas^.datos, error, errordesafio);

		     // detecto que llego a la ultima pregunta: pregunta que da la cara del diamante
                     If (Preguntas^.sig = nil) then
                        writeln('ESTA PREGUNTA TE PUEDE OTORGAR UNA CARA DEL DIAMANTE.');

                     // input del jugador
                     writeln('Escribir Respuesta: ');
                     readln(respuesta);
                     respuesta:= UpCase(respuesta);

                     // detecto si la respuesta es valida
                     if (respuesta in conjres) then begin

                        // caso que la pregunta sea correcta
                        if (respuesta = Preguntas^.datos.respuesta) then begin
                           puntaje:= puntaje + 1;
                           contesto(continuarPartida, Preguntas^.datos);

                           // caso que conteste bien la ultima pregunta
                           if (preguntas^.sig = nil) then completadas:= completadas + [Preguntas^.datos.numCategoria];
                           Preguntas:= Preguntas^.sig;
                     end

                     // caso que la respuesta se incorrecta
                     else begin
                           // en caso que se conteste mal la pregunta desafio
                           if (preguntas^.sig = nil) then begin
                                errordesafio:= errordesafio + 1;
                                writeln('VUELVE A RESPONDER LA CARA DEL DIAMANTE SI FALLAS PIERDE EL JUEGO');

                           // cualquier otra pregunta
                           end else begin
                                continuarPartida:= false;
                                error:= error + 1;
                                contesto(continuarPartida, Preguntas^.datos);
                             end;
                           end;
		     end;
	       end;
	  end;

procedure partida(vdl: vdlCategorias; var resultado: boolean; var puntaje, error, errordesafio: integer);
          var
             catActual: subrCategorias;
             // valido: variable booleana que compara si el valor actual de color es adecuado; ok: variable booleana que compara si la partida se puede continuar o no
             valido, continuarPartida: boolean;
             completadas, fin: conjCompletadas;
          begin
	       // inicializo
               valido:= false;
               continuarPartida:= true;
               resultado:= false;
               completadas:= [];
               fin:= [1..constCATEGORIAS];

               // repito hasta que se cumpla alguna de las condiciones de game over
	       while (continuarPartida) and (error < constERRORES) and (errordesafio < constERRORDESAFIO) and not(completadas = fin) do begin

	             // leo colores hasta encontrar un color valido
		     repeat
				// presento cada color y comparo si se completo o es un color valido
		  		presentarColor(completadas, error, errordesafio);
		  		elegirColor(catActual, valido);

		     until (Valido);
		     Preguntas(vdl[catActual].pri, puntaje, error, errordesafio, continuarPartida, completadas);
		     continuarPartida:= true;
		end;

               puntaje:= puntaje-error;
               // actualizo resultado en caso que el jugador pierde
	       resultado:= (error < constERRORES) and (completadas = fin);
	  end;
// --------------------------- FIN MODULOS DEL JUEGO ---------------------------






// --------------------------- MODULOS DEL SISTEMA ---------------------------
procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y carga una cantidad aleatoria de listas
                procedure inicializarVDL(var vdl: vdlCategorias);
                          var
                             I: subrCategorias;
                          begin
                               for I:=1 to constCATEGORIAS do begin
						vdl[I].pri:= nil;
						vdl[I].ult:= nil;
				end;
                          end;

                procedure agregarFinal(var l: tipoLista; elem: tipoPreguntas);
                		var nue: lista;
                		begin
                				new(nue); nue^.datos:= elem; nue^.sig:= nil;
                				if (l.pri = nil) then l.pri:= nue
                								 else l.ult^.sig:= nue;
                				l.ult:= nue;
                		end;
		var
		     act: tipoPreguntas;
		     archCategorias: text;
		     Iopciones: subrOpciones;
		begin
                        {
                           sabemos que el tiempo de carga es 6 veces mas que el de un archivo de registros
                           (debido a la lectura de cada uno los campos) pero no logramos que funcione y excede los contenidos de la catedra,
                           por lo tanto decidimos usar un dato del tipo text
                        }
                        inicializarVDL(vdl);

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
                        	
			 	// agrego al final del Vector De Listas
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
// --------------------------- MODULOS DEL SISTEMA ---------------------------






// --------------------------- PROGRAMA PRINCIPAL ---------------------------
var
   vdl: vdlCategorias;
   resultado, ok: boolean;
   puntaje, error, errordesafio: integer;
begin
     // inicializacion
     resultado:= false;
     ok:= false;

     // normalmente en la practica trabajamos con un "se dispone", decidimos crear un archivo 'categorias.txt' para cargarlo
     cargarVDL(vdl);

     // principal
     intro();
     while not(ok) do begin
           error:= 0;
           errordesafio:= 0;
           puntaje:= 0;
           partida(vdl, resultado, puntaje, error, errordesafio);

           if (resultado) then jugadorGano()
                          else jugadorPerdio();
           presentarPuntuacion(puntaje, error, errordesafio);
           nuevaPartida(ok);
     end;
     // termina el juego
     outro();
     liberarMemVDL(vdl);
end.
