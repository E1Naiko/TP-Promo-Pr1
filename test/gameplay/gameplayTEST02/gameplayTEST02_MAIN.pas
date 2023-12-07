program gameplayTEST02;
uses crt, SysUtils, libSistem, libType, libUserInterface;

// --------------------------- MODULOS JUEGO ---------------------------
procedure elegirColor(var catActual: subrCategorias; completadas: conjCompletadas; var valido: boolean);
          var
	     color: string;
	  begin
             readln(color);
             color:= LowerCase(color);
			
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
		     Preguntas(vdl[catActual].pri, puntaje, error, ok, completadas);
		     ok:= true;
		end;
				
               puntaje:= puntaje-error;
               // actualizo resultado en caso que el jugador pierde
	       res:= (error < constERRORES) and (completadas = fin);
	  end;

// --------------------------- PROGRAMA PRINCIPAL ---------------------------
var
   vdl: vdlCategorias;
   resultado, ok: boolean;
   puntaje, error: integer;
begin
     // inicializacion
     writeln('--------------------- Cargando MIRACLUS ---------------------');
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
     liberarMemVDL(vdl);
     outro();
end.
