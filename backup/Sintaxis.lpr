program Sintaxis;

uses Datos, Lexico,crt, Sintactico;
var
  ar,ar_arbol : t_archivo;
  i: integer;
  desplazamiento,lexema:string;
  A,compolex:t_simgramatical;
  tas:t_tas;
  arbol:t_arbol;
  pila:t_pila;
  asd:t_nodo_arbol;

begin
  abrir_archivo(ar);
  Abrir_Archivo_Arbol(ar_arbol);
  crear_taS(TAS);
  CARGAR_TAS(TAS);
  i:=0;
  { while i<(filesize(ar)) do
  begin
  obtenersigcomplex(ar,i,compolex,lexema);
  writeln('Componentelexico : ',compolex , '   Lexema : ',lexema);
  end;
  readkey;
  clrscr;    }
  crear_arbol(arbol);
  obtener_arbol_derivacion(ar,pila,TAS,arbol);
  guardar_arbol_enarchivo (ar_arbol,arbol);
  readkey;
  cerrar_Archivo(ar);
end.

