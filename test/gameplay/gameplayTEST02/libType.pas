unit libType;
interface
const
	constOPCIONES = 'C';
	constCATEGORIAS = 5;
	constERRORES = 3;
type
	subrOpciones = 'A' .. constOPCIONES;
	subrCategorias = 1 .. constCATEGORIAS;
	
	conjCompletadas = set of subrCategorias;
	conjRespuestas = set of char;
			
	cadenaPreg = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD
	cadenaOpci = string; // ---------------------------------------------------------------------------- CAMBIAR A NECESIDAD
	cadenaColores = string[6];
		
	arrOpciones = array [subrOpciones] of cadenaOpci;
		
	tipoPreguntas = record
		numCategoria: subrCategorias;
		pregunta: cadenaPreg;
		opciones: arrOpciones;
		respuesta: subrOpciones;
		explicacion: cadenaOpci;
	end;
		
	lista = ^nodo;
	nodo = record
		datos: tipoPreguntas;
		sig: lista;
	end;
	
	tipoLista = record
			pri, ult: lista;
		end;
		
	vdlCategorias = array [subrCategorias] of tipoLista;
implementation
end.
