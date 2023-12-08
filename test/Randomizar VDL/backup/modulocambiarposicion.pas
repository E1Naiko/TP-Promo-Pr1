unit ModuloCambiarPosicion;

interface

uses
  crt, SysUtils;

type
  tipoLista = record
    pri, ult: lista;
  end;

procedure CambiarPosicion(var lista: tipoLista; posicionActual, nuevaPosicion: integer);

implementation

procedure CambiarPosicion(var lista: tipoLista; posicionActual, nuevaPosicion: integer);
var
  nodoActual, nodoAnterior, nodoNuevoAnterior, nodoNuevoSiguiente: lista;
  contador: integer;
begin
  if (posicionActual = nuevaPosicion) or (posicionActual < 1) or (nuevaPosicion < 1) then
    Exit; // No hay cambios necesarios o posiciones inválidas

  contador := 1;
  nodoActual := lista.pri;
  nodoAnterior := nil;

  // Buscar el nodo en la posición actual
  while (nodoActual <> nil) and (contador < posicionActual) do
  begin
    Inc(contador);
    nodoAnterior := nodoActual;
    nodoActual := nodoActual^.sig;
  end;

  if (nodoActual = nil) or (contador <> posicionActual) then
    Exit; // La posición actual no existe en la lista

  // Eliminar el nodo de la posición actual
  if nodoAnterior = nil then
    lista.pri := nodoActual^.sig
  else
    nodoAnterior^.sig := nodoActual^.sig;

  // Buscar el nodo en la nueva posición
  contador := 1;
  nodoNuevoAnterior := nil;
  nodoNuevoSiguiente := lista.pri;

  while (nodoNuevoSiguiente <> nil) and (contador < nuevaPosicion) do
  begin
    Inc(contador);
    nodoNuevoAnterior := nodoNuevoSiguiente;
    nodoNuevoSiguiente := nodoNuevoSiguiente^.sig;
  end;

  // Insertar el nodo en la nueva posición
  if nodoNuevoAnterior = nil then
  begin
    nodoActual^.sig := lista.pri;
    lista.pri := nodoActual;
  end
  else
  begin
    nodoActual^.sig := nodoNuevoSiguiente;
    nodoNuevoAnterior^.sig := nodoActual;
  end;

  // Actualizar ult si el nodo se movió a la última posición
  if nodoNuevoSiguiente = nil then
    lista.ult := nodoActual;
end;

end.

