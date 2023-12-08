unit ModuloCambioPosicion;

interface

uses
  SysUtils;

type
  tipoLista = record
    pri, ult: lista;
  end;

  lista = ^nodo;
  nodo = record
    datos: tipoPreguntas;
    sig: lista;
  end;

procedure CambiarPosicionElemento(var lista: tipoLista; elemento: tipoPreguntas; nuevaPosicion: Integer);

implementation

procedure CambiarPosicionElemento(var lista: tipoLista; elemento: tipoPreguntas; nuevaPosicion: Integer);
var
  actual, anterior, temporal: lista;
  contador: Integer;
begin
  actual := lista.pri;
  anterior := nil;
  contador := 1;

  // Buscar el elemento en la lista
  while (actual <> nil) and (contador < nuevaPosicion) do
  begin
    anterior := actual;
    actual := actual^.sig;
    Inc(contador);
  end;

  // Verificar si se encontró la posición deseada
  if (actual <> nil) and (contador = nuevaPosicion) then
  begin
    // Desconectar el elemento de su posición actual
    if anterior = nil then
      lista.pri := actual^.sig
    else
      anterior^.sig := actual^.sig;

    // Conectar el elemento en la nueva posición
    temporal := lista.pri;
    for contador := 1 to nuevaPosicion - 1 do
    begin
      anterior := temporal;
      temporal := temporal^.sig;
    end;

    if anterior = nil then
    begin
      // El elemento se mueve a la primera posición
      lista.pri := actual;
      actual^.sig := temporal;
    end
    else
    begin
      // El elemento se mueve a una posición intermedia
      anterior^.sig := actual;
      actual^.sig := temporal;
    end;
  end
  else
    Writeln('Error: La nueva posición especificada no es válida.');
end;

end.

