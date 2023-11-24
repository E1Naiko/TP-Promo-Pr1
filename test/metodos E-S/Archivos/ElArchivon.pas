program Archivo;
type
  estudiante= record
    nombre: string[50];
    edad: integer;
    carrera: string[30];
  end;

var
  estu: estudiante;
  e: file of estudiante;

begin
  Assign(e,'estudiante.dat');
  rewrite(e);
  estu.nombre:= 'Alam Meza';
  estu.edad:= 23;
  estu.carrera:='Ing en Computacion';
  write(e,estu);
  close(e);
end. 
