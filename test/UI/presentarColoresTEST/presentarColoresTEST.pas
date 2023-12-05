program presentarColoresTEST;
uses crt, SysUtils;
const
     constOPCIONES = 'C';
     constCATEGORIAS = 5;
     constERRORES = 3;
type
    subrOpciones = 'A' .. constOPCIONES;
    subrCategorias = 1 .. constCATEGORIAS;
    conjCompletadas = set of subrCategorias;
    cadenaPreg = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD
    cadenaOpci = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD

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


procedure presentarColor(comp: conjCompletadas); // presenta las opciones de colores ------------------------------------------------------------ REVISAR OPCIONES YA COMPLETADAS
          begin
               writeln('                ------------------------------------------------------------------------------');
               writeln;
               writeln('                                    ¿Que cara del Diamante deseas intentar completar?');
               writeln;
               writeln();
               
               // IMPRIMIMOS LAS CATEGORIAS
               write('         -- ');
               TextColor(Red);
               
               IF (1 in comp) then write('CARA ROJA OBTENIDA -- ')
                              else write('Rojo: "1 - Conceptos Introductorios" -- ');
               
               TextColor(LightGreen);
               IF (2 in comp) then write('CARA VERDE OBTENIDA --')
                              else write('Verde: "II - Modularización, parámetros" -- ');
               
               TextColor(Blue);
               IF (3 in comp) then write('CARA AZUL OBTENIDA --')
                              else write('Azul: "III - Organizacion" -- ');
               
               TextColor(Yellow);
               IF (4 in comp) then write('CARA AMARILLA OBTENIDA --')
                              else write('Amarillo: "IV - Estructuras de control de datos y registros" -- ');
               
               TextColor(LightMagenta);
               IF (5 in comp) then write('CARA MORADA OBTENIDA --')
                              else write('Morado: "V - Arreglos y Listas" --');
               
               TextColor(white);
          end;
          
var
    comp: conjCompletadas;
begin
    comp:= [1,3,5];
    presentarColor(comp);
end.



