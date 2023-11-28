program testLecturaDatosCategoria;
uses libMatrices;

procedure cargaCategorias(var m: matrCategorias);
	var archCategorias: file of matrCategorias;
	begin
		assign(archCategorias, 'TESTcategorias');
		reset(archCategorias);
		read(archCategorias, m);
		close(archCategorias);
	end;
var
	m: matrCategorias;
	
begin
	cargaCategorias(m);
	imprimirMatriz(m);
	readln;
end.
