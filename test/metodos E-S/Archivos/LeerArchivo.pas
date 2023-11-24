program Leer;
type
  estudiante=record
    nombre: string[50];
    edad:integer;
    carrera:string[30];
  end;

var
  estu:estudiante;
  e:file of estudiante;

begin
  assign(e,'estudiante.dat');
  reset(e);
  while not eof(e) do begin
    read(e,estu);
    writeln('Nombre ',estu.nombre);
    writeln('Edad ',estu.edad);
    writeln('Carrera: ',estu.carrera);
  end;
  close(e);
  readln;
end.
