program gameplayTEST01;
uses crt, SysUtils, libInterfazUsuario, libCargaArch, libType;

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
                    if (catActual in completadas) then begin
                       writeln('Categoria ya completada'); // ---------------------------------------------------------------- HACER UI
                       Valido:= false;
                    end;
             end;
		  end;

Procedure Preguntas(Preguntas: Lista; var puntaje, error: integer; var ok: boolean);
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
                           Preguntas:= Preguntas^.sig;
                        end
                        
                        // caso que la respuesta se incorrecta
                        else begin
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

procedure partida(vdl: vdlCategorias; res: boolean; var puntaje, error: integer);
          var
             catActual: subrCategorias;
             valido, ok: boolean; // valido: variable booleana que compara si el valor actual de color es adecuado ;ok: variable booleana que compara si la partida se puede continuar o no
             completadas: conjCompletadas;
          begin
			   // inicializo
               valido:= false;
               ok:= true;
               res:= false;
               completadas:= []; // conjunto de categorias completadas
               error:= 0;
               puntaje:= 0;
               
               // repito hasta que se cumpla alguna de las condiciones de game over
			   while (ok) and (error < constERRORES) do begin
					  // leo colores hasta encontrar un color valido
					  repeat
					  		// presento cada color y comparo si se completo o es un color valido
					  		presentarColor(completadas, error);
					  		elegirColor(catActual, completadas, valido);
					  		
					  until (Valido);
					  Preguntas(vdl[catActual], puntaje, error, ok);
					  
				end;
				
				// actualizo resultado en caso que el jugador pierde
				res:= error > 3;
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
     cargarVDL(vdl); // normalmente en la practica trabajamos con un "se dispone", decidimos crear un archivo 'categorias.txt' para cargar el vector de listas

     // principal
     intro();
     while not(ok) do begin
           partida(vdl, resultado, puntaje, error);

           if (resultado) then jugadorGano()
                          else jugadorPerdio();
           presentarPuntuacion(puntaje, error);
           nuevaPartida(ok);
     end;
     // termina el juego
     precESC();
     liberarMemVDL(vdl);
end.

