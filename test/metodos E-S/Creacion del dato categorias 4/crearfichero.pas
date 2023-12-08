unit crearFichero;
interface

         uses  typeYcargaLista, libUserInterface, crt, SysUtils;

         procedure cargaOpciones(var v:arrOpciones); // CARGA EL VECTOR DE OPCIONES
         procedure cargaRespuesta(var r: subrOpciones); // CARGA DEL VALOR DE RESPUESTA
         function verificacionPreg(act: tipoPreguntas): boolean; // CHEQUEO DE CADA PREGUNTA PARA EL USUARIO
         procedure cargarPregunta(var act: tipoPreguntas); // LEE LA PREGUNTA ACTUAL
         procedure cargarArchivo(); // CARGA EL ARCHIVO 'CATEGORIAS'

implementation


end.

