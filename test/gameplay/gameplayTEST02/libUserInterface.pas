unit libUserInterface;
interface
	uses libType, crt, SysUtils;
	
	procedure imprimirPregunta(p: tipoPreguntas); // UI - imprime la pregunta actual
	procedure precEnter(); // espera a que el jugador precione "ENTER" para continuar
	procedure precESC(); // espera a que el jugador precione "ESC" para continuar
	procedure nuevaPartida(var ok:boolean); // espera a que el jugador precione "ESC" o "ENTER"
	procedure intro();
	procedure outro();
	procedure jugadorGano();
	procedure jugadorPerdio();
	procedure contesto(ok: boolean; p: tipoPreguntas);
	procedure presentarPuntuacion(puntaje, error: integer); // presenta el puntaje final de cada partida
	procedure presentarColor(comp: conjCompletadas; errores: integer); // presenta las opciones de colores ------------------------------------------------------------ REVISAR OPCIONES YA COMPLETADAS
	procedure presentarPregunta(p: tipoPreguntas; errores: integer); // ----------------------------------------------------------------------------------------------------------- SIN TERMINAR
	
implementation
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
				writeln;
				writeln('                                     ¿USARAS TUS PODERES PARA EL BIEN?');
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
	
	procedure presentarPuntuacion(puntaje, error: integer); // presenta el puntaje final de cada partida
			begin
				writeln('											-- Puntuacion Final --');
				writeln('										   -- Puntaje obtenido: ', puntaje, ' --');
				writeln('Errores: ', error, '/', constERRORES)
	
			end;
			
	procedure presentarColor(comp: conjCompletadas; errores: integer); // presenta las opciones de colores ------------------------------------------------------------ REVISAR OPCIONES YA COMPLETADAS
			begin
					ClrScr;
			writeln('                ------------------------------------------------------------------------------');
			writeln;
			writeln('                                              -- Errores: ', errores, '/', constERRORES, ' --');
			writeln('                                    ¿Que cara del Diamante deseas intentar completar?');
			writeln;
						
			// IMPRIMIMOS LAS CATEGORIAS
			TextColor(Red);
						
			IF (1 in comp) then writeln('         -- CARA ROJA OBTENIDA --')
					else writeln('         -- Rojo: "I - Conceptos Introductorios" -- ');
						
			TextColor(LightGreen);
			IF (2 in comp) then writeln('         -- CARA VERDE OBTENIDA --')
					else writeln('         -- Verde: "II - Modularización, parámetros" -- ');
						
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
			writeln('Introduzca que clase desea intentar:');					
		end;
					
	procedure presentarPregunta(p: tipoPreguntas; errores: integer); // ----------------------------------------------------------------------------------------------------------- SIN TERMINAR
		begin
			clrscr;
			writeln('                ------------------------------------------------------------------------------');
			write('		Categoria: ', p.numCategoria, ' - ');
			write(' -- Errores: ', errores, '/', constERRORES);
			writeln;
			imprimirPregunta(p);
		end;
	
end.
