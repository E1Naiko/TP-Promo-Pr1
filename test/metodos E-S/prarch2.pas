program prarch2;
var
  nombreArchivoEntrada: string[14];
  i:byte;
  archivoEntrada: file of byte;
begin
     writeln('Se lee un byte de datos de un archivo');
     writeln;
     writeln('De el nombre del archivo de entrada');
     readln(nombreArchivoEntrada);
     assign(archivoEntrada, nombreArchivoEntrada);
     reset(archivoEntrada); // se abre un archivo y existente
     read(archivoEntrada, i);
     writeln('El byte de ', nombreArchivoEntrada, ' es', i);

     readln;
     close(archivoEntrada);
end.
