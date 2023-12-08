program TEST4LecturaDatosCategoria(input,DEBUG2categorias);
uses crt, SysUtils;
const
	constOPCIONES = 'C';
       constCATEGORIAS = 5;
       constERRORES = 3;
type
           subrOpciones = 'A' .. constOPCIONES;
       subrCategorias = 0 .. constCATEGORIAS;

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

       tipoLista = record
       		pri, ult: lista;
               		end;

       vdlCategorias = array [subrCategorias] of tipoLista;

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

procedure cargaOpciones(var v:arrOpciones); // CARGA EL VECTOR DE OPCIONES
	var I: subrOpciones;
	begin
		for I:='A' to constOPCIONES do begin
			writeln(' -- Introduzca Opcion "', I, '"');
			readln(v[I]);
		end;
	end;

procedure cargaRespuesta(var r: subrOpciones); // CARGA DEL VALOR DE RESPUESTA
	type conjVal = set of char;
	var
		act: char;
		ok: boolean;
		conj: conjVal;
	begin
		conj:= ['A'..constOPCIONES];
		ok:=false;

		while not(ok) do begin
			writeln('Introduca la opcion correcta:');
			readln(act);
			act:= UpCase(act);

			if (act in conj) then ok:= true
					 else writeln('ERROR');
		end;
		r:= act;
	end;

function verificacionPreg(act: tipoPreguntas): boolean; // CHEQUEO DE CADA PREGUNTA PARA EL USUARIO
	var verificacion: string[2];
	begin
		Writeln('------------------------------------------------------');
		writeln(' Pregunta:');
		imprimirPregunta(act);
		writeln(' ----- ¿Autoriza el ingreso de la pregunta a la base de datos? (si) -----');
		readln(verificacion);
		verificacion:= UpperCase(verificacion);
		verificacionPreg:= verificacion = 'SI';
	end;

procedure cargarPregunta(var act: tipoPreguntas); // LEE LA PREGUNTA ACTUAL

             begin
	          writeln('Introduzca el numero de categoria: ');
                  readln(act.numCategoria);
	          if not(act.numCategoria<>0) then begin
                        writeln('Introduzca la pregunta: ');
		        readln(act.pregunta);
		        cargaOpciones(act.opciones);
		        cargaRespuesta(act.respuesta);
                        writeln('Introduzca el numero de categoria: ');
                        readln(act.numCategoria);
		  end;
	     end;

 procedure cargarArchivo(); // CARGA EL ARCHIVO 'CATEGORIAS'
           var
             act: tipoPreguntas;
             archCategorias: file of tipoPreguntas;
           begin
                cargarPregunta(act);
                while (act.numCategoria<>0) do begin

                        cargarPregunta(act);
                end;
           end;

procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y carga una cantidad aleatoria de listas
          var
            act: tipoPreguntas;
	    archCategorias: file of tipoPreguntas;
	    Iopciones: subrOpciones;
	    I: subrCategorias;
          begin
            inicializarVDL(vdl);
            // cargo datos desde el archivo 'categorias'
	    assign(archCategorias, 'DEBUG2categorias'); // ------------------------------------------------------------- CAMBIARLO A categorias.txt
	    reset(archCategorias);
	    while not(eof(archCategorias)) do begin
              readln(archCategorias,act);
              insertarFinal(vdl[act.numCategoria],act);
            end;
            close(archCategorias);

          end;

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

var
  vdl: vdlCategorias;
begin

  precESC();
end.

