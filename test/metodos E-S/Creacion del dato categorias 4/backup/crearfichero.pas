unit crearFichero;
interface

         uses  typeYcargaLista, libUserInterface, crt, SysUtils;

         procedure cargaOpciones(var v:arrOpciones); // CARGA EL VECTOR DE OPCIONES
         procedure cargaRespuesta(var r: subrOpciones); // CARGA DEL VALOR DE RESPUESTA
         function verificacionPreg(act: tipoPreguntas): boolean; // CHEQUEO DE CADA PREGUNTA PARA EL USUARIO
         procedure cargarPregunta(var act: tipoPreguntas); // LEE LA PREGUNTA ACTUAL
         procedure cargarArchivo(); // CARGA EL ARCHIVO 'CATEGORIAS'

implementation
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

end.

