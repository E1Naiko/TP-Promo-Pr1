program tpPromoMain;
uses crt, SysUtils;
const
     totalFallos = 3;
     constOPCIONES = 'C';
     constFILAS = 2;
     constCOLUMNAS = 2;
type
    subrOpciones = 'A'..constOPCIONES;
    cadena = string;
    cadVerif = string[2];

    arrOpciones = array [subrOpciones] of cadena;
    tipoPreguntas = record
              	pregunta: cadena;
        	opciones: arrOpciones;
        	respuesta: subrOpciones;
        end;

    subrFila = 1..constFILAS;
    subrColumna = 1..constCOLUMNAS;
    matrCategorias = array [subrFila, subrColumna] of tipoPreguntas;


// --------------------------- MODULOS DE INTERFAZ DE USUARIO ---------------------------
procedure imprimirPregunta(p: tipoPreguntas);
          var I: subrOpciones;
          begin
               with p do begin
                    writeln(' - Pregunta: ', pregunta);
                    writeln(' -- Opciones:');
                    for I:='A' to constOPCIONES do
                        writeln(' --- [', I,']: ', p.opciones[I]);
                    end;
          end;

procedure inputJugador();
          var K: char;
          begin
               writeln('                                     - Precione "INTRO" para continuar -');
               writeln('                ------------------------------------------------------------------------------');
               repeat K:= readkey;
                      until K = #13;
          end;
procedure intro();
          procedure apertura();
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
                         writeln('     En una remota isla perdida en medio del océano, entre unas ruinas antiguas, hallas un mapa ancestral');
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
          procedure reglas();
                    begin
                         writeln('                                                  --REGLAS--');
                         writeln('Deberas elegir entre 5 colores correspondientes a la cara del diamante, si contestas bien todas las preguntas correspondientes a cada cara del DIAMANTE DEL LEON ');
                    end;

          begin
               apertura();
               inputJugador();

               clrscr;
               reglas();
               inputJugador();

               clrscr;
         end;

procedure cerrarPrograma();
          var K: char;
          begin
               writeln('                ------------------------------------------------------------------------------');
               writeln('                                Precione "ESC" para cerrar el programa');
               writeln('                ------------------------------------------------------------------------------');
               repeat K:= readkey;
               until K = #27;
          end;

// --------------------------- MODULOS JUEGO ---------------------------
procedure partida();
          begin

          end;



// --------------------------- PROGRAMA PRINCIPAL ---------------------------
begin
     clrscr;
     intro();
     partida();
     cerrarPrograma();
end.

