program prarch1;
var
    nombreArchivoSalida : string[14];
    i:byte;
    archivoSalida: file of byte;
begin
     // ESTE PROGRAMA BORRA Y REESCRIVE UN ARCHIVO EXISTENTE
     writeln('Escribir un byte de datos a un archivo nuevo');
     writeln('Escriba el nombre del archivo de salida');
     readln(nombreArchivoSalida);

     assign(archivoSalida, nombreArchivoSalida);
     rewrite(archivoSalida); // ABRE UN ARCHIVO NUEVO

     writeln('De un valor byte para escribirlo a ', nombreArchivoSalida, ':');
     readln(i);
     write(archivoSalida, i);
     readln;
     close(archivoSalida);
end.
