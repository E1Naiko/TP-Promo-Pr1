# TP-Promo-Pr1

---------------------------------------------------------------------------------

## TYPE
```
uses crt, SysUtils;
const
     constOPCIONES = 'C';
     constCATEGORIAS = 5;
type
    subrOpciones = 'A' .. constOPCIONES;
    subrCategorias = 1 .. constCATEGORIAS;
    conjCompletadas = set of subrCategorias;
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
```

---------------------------------------------------------------------------------

## MODULOS DISPONIBLES:

### UI
  ```
  procedure imprimirPregunta(p: tipoPreguntas); // UI - imprime la pregunta actual
  procedure precEnter(); // espera a que el jugador precione "ENTER" para continuar
  procedure precESC(); // espera a que el jugador precione "ESC" para continuar
  procedure nuevaPartida(var ok:boolean); // espera a que el jugador precione "ESC" o "ENTER"
  procedure intro(); // imprime la portada del juego
   {INTERNO A INTRO} procedure apertura(); // UI - imprime la portada del juego y narra la historia del mismo
   {INTERNO A INTRO} procedure reglas(); // UI - imprime las reglas del juego
  procedure jugadorGano(); // imprime la pantalla de juego terminado-Victoria
  procedure jugadorPerdio(); // imprime la pantalla de juego terminado-Derrota
  procedure contesto(ok: boolean; p: tipoPreguntas); // imprime en pantalla si la respuesta del jugador es correcta y su explicacion
  procedure presentarColor(); // presenta las opciones de colores
  procedure presentarPuntuacion(puntaje, error: integer); // presenta el puntaje final de cada partida
  ```

### JUEGO
  ```
  procedure Preguntas (Preguntas:Lista; error:integer);
  procedure partida(vdl: vdlCategorias; res: boolean);
  ```

### SISTEMA
  ```
  procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y se lo asigna a un Vector De Listas
   {INTERNO A CARGARVDL} procedure agregarFinal(var l: lista; elem: tipoPreguntas); // agrega un elemento al final de la lista
  procedure liberarMemVDL(var vdl: vdlCategorias); // libera la memoria ocupada por el Vector De Listas
  ```
