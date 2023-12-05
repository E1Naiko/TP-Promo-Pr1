program tpPromoMain;
uses crt, SysUtils;
const
	constOPCIONES = 'C';
	constCATEGORIAS = 5;
	constERRORES = 3;
type
	subrOpciones = 'A' .. constOPCIONES;
	subrCategorias = 1 .. constCATEGORIAS;
	
	conjCompletadas = set of subrCategorias;
	conjRespuestas = set of char;
			
	cadenaPreg = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD
	cadenaOpci = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD
	cadenaColores = string[6];
		
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
		
	vdlCategorias = array [subrCategorias] of lista;




















// --------------------------- MODULOS DE INTERFAZ DE USUARIO ---------------------------
procedure imprimirPregunta(p: tipoPreguntas); // UI - imprime la pregunta actual
          var I: subrOpciones;
          begin
               clrscr;
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

procedure presentarColor({comp: conjCompletadas}); // presenta las opciones de colores ------------------------------------------------------------ REVISAR OPCIONES YA COMPLETADAS
          begin
               writeln('                ------------------------------------------------------------------------------');
               writeln;
               writeln('                                    ¿Que cara del Diamante deseas intentar completar?');
               writeln;
               writeln();
               TextColor(Red);
               write('Rojo: "1 - Conceptos Introductorios" ');
               TextColor(LightGreen);
               write('Verde: "II - Modularización, parámetros" ');
               TextColor(Blue);
               write('Azul: "III - Organizacion" ');
               TextColor(Yellow);
               write('Amarillo: "IV - Estructuras de control de datos y registros" ');
               TextColor(LightMagenta);
               write('Morado: "V - Arreglos y Listas" ');
               TextColor(white);
          end;

procedure presentarPuntuacion(puntaje, error: integer); // presenta el puntaje final de cada partida
          begin
               writeln('DEBUG');
               writeln('Puntaje: ', puntaje);
               writeln('Errores: ', error, '/', constERRORES)

          end;
          
procedure presentarColor(comp: conjCompletadas; errores: integer); // presenta las opciones de colores ------------------------------------------------------------ REVISAR OPCIONES YA COMPLETADAS
          begin
                ClrScr;
		writeln('                ------------------------------------------------------------------------------');
		writeln;
		writeln('                                             -- Errores: ', errores, '/', constERRORES);
		writeln('                                    ¿Que cara del Diamante deseas intentar completar?');
		writeln;
					
		// IMPRIMIMOS LAS CATEGORIAS
		TextColor(Red);
					
		IF (1 in comp) then writeln('         -- CARA ROJA OBTENIDA --')
		  	       else writeln('         -- Rojo: "1 - Conceptos Introductorios" -- ');
					
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
		writeln('		categoria: ', p.numCategoria, ' -- Errores: ', errores, '/', constERRORES);
		imprimirPregunta(p);
	end;




















// --------------------------- MODULOS JUEGO ---------------------------
procedure elegirColor(var catActual: subrCategorias; completadas: conjCompletadas; var valido: boolean);
          var
	     color: string;
	  begin
             readln(color);
             color:= LowerCase(color);
			
             case color of
                  'rojo' : begin
                                Valido:= true;
                                catActual:= 1;
                           end;
                  'verde' : begin
                                Valido:= true;
                                catActual:= 2;
                            end;
                  'azul' : begin
                                Valido:= true;
                                catActual:= 3;
                              end;
                  'amarillo' : begin
                                Valido:= true;
                                catActual:= 4;
                              end;
                  'morado' : begin
                                Valido:= true;
                                catActual:= 5;
                             end;
                  else Valido:= false;

                    // ------------------------------------------------------------------------------------------------------- O ELIMINAR
                    if (catActual in completadas) then begin
                       writeln('Categoria ya completada'); // ---------------------------------------------------------------- HACER UI
                       Valido:= false;
                    end;
             end;
		  end;

Procedure Preguntas(var Preguntas: Lista; var puntaje, error: integer; var ok: boolean; var completadas: conjCompletadas);
          var
             respuesta: subrOpciones;
             conjres: conjRespuestas;
          begin
			   // inicializo
               conjres:= ['A','B','C'];
               
               // recorro cada preguntas
               while (Preguntas <> nil) and (ok) and (error < constERRORES) do begin
                     presentarPregunta(Preguntas^.datos, error);
					 
		     // detecto que llego a la ultima pregunta: pregunta que da la cara del diamante
                     If (Preguntas^.sig = nil) then
                        writeln('ESTA PREGUNTA TE PUEDE OTORGAR UNA CARA DEL DIAMANTE.');
                     
                     writeln('Escribir Respuesta: ');
                     readln(respuesta);
                     respuesta:= UpCase(respuesta);
                     
                     // detecto si la respuesta es valida
                     if (respuesta in conjres) then begin

                        // caso que la pregunta sea correcta
                        if (respuesta = Preguntas^.datos.respuesta) then begin
                           puntaje:= puntaje + 1;
                           contesto(ok,Preguntas^.datos);

                           if (preguntas^.sig = nil) then completadas:= completadas + [Preguntas^.datos.numCategoria];
                           Preguntas:= Preguntas^.sig;

                        end
                        
                        // caso que la respuesta se incorrecta
                        else begin
                             // ------------------------------------------------------------------------------------ agregar caso que sea la ultima pregunta
                             ok:= false;
                             error:= error + 1;
                             contesto(ok,Preguntas^.datos);
                             Preguntas:= Preguntas^.sig;
                        end;
                        
                        { ------------------------------------------------------------------------------------------------------- IMPLEMENTAR DE OTRA FORMA
                        // caso que la respuesta sea invalida
                        else begin
							writeln('Respuesta Invalida ingreselo de nuevo: ');
						end;
					}
		     end;
	       end;
	  end;

procedure partida(vdl: vdlCategorias; var res: boolean; var puntaje, error: integer);
          var
             catActual: subrCategorias;
             valido, ok: boolean; // valido: variable booleana que compara si el valor actual de color es adecuado ;ok: variable booleana que compara si la partida se puede continuar o no
             completadas, fin: conjCompletadas;
          begin
			   // inicializo
               valido:= false;
               ok:= true;
               res:= false;
               completadas:= []; // conjunto de categorias completadas
               fin:= [1,2,3,4,5];
               
               // repito hasta que se cumpla alguna de las condiciones de game over
	       while (ok) and (error < constERRORES) and not(completadas = fin) do begin

	             // leo colores hasta encontrar un color valido
		     repeat
				// presento cada color y comparo si se completo o es un color valido
		  		presentarColor(completadas, error);
		  		elegirColor(catActual, completadas, valido);

		     until (Valido);
		     Preguntas(vdl[catActual], puntaje, error, ok, completadas);
		     ok:= true;
		end;
				
               puntaje:= puntaje-error;
               // actualizo resultado en caso que el jugador pierde
	       res:= (error < constERRORES) and (completadas = fin);
	  end;




















// --------------------------- MODULOS DE SISTEMA ---------------------------
procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y se lo asigna a un Vector De Listas
          procedure agregarFinal(var l: lista; elem: tipoPreguntas); // ----------------------------------------------------------- optimizar
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




















// --------------------------- PROGRAMA PRINCIPAL ---------------------------
var
   vdl: vdlCategorias;
   resultado, ok: boolean;
   puntaje, error: integer;
begin
     // inicializacion
     resultado:= false;
     ok:= false;

     cargarVDL(vdl); // normalmente en la practica trabajamos con un "se dispone", decidimos crear un archivo 'categorias.txt' para cargarlo

     // principal
     intro();
     while not(ok) do begin
           error:= 0;
           puntaje:= 0;
           partida(vdl, resultado, puntaje, error);

           if (resultado) then jugadorGano()
                          else jugadorPerdio();
           presentarPuntuacion(puntaje, error);
           nuevaPartida(ok);
     end;
     // termina el juego
     outro();
     liberarMemVDL(vdl);
end.
