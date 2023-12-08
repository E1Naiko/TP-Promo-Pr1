program TEST4LecturaDatosCategoria;

uses typeYcargaLista, libUserInterface, crearFichero;

procedure cargarVDL(var vdl: vdlCategorias); // busca el archivo 'categorias.txt' y carga una cantidad aleatoria de listas
          var
            act: tipoPreguntas;
	    archCategorias: tipoArchCategorias;
	    Iopciones: subrOpciones;
	    I: subrCategorias;
          begin
            inicializarVDL(vdl);
            // cargo datos desde el archivo 'categorias.txt'
	    assign(archCategorias, 'DEBUG2categorias'); // ------------------------------------------------------------- CAMBIARLO A categorias.txt
	    reset(archCategorias);
	    while not(eof(archCategorias)) do begin
              readln(archCategorias,act);
              agregarFinal(vdl[act.]);
            end;
            close(archCategorias);

          end;

var
  vdl: vdlCategorias;
begin
  vdl[1].pri:= nil;

  precESC();
end.

