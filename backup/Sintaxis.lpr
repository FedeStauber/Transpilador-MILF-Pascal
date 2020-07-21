program Sintaxis;

uses Datos, Lexico,crt, Sintactico;
var
  ar : t_archivo;
  i: integer;
  lexema:string;
  A,compolex:t_simgramatical;
  tas:t_tas;
  arbol:t_arbol;
  pila:t_pila;
  asd:t_nodo_arbol;
begin
  abrir_archivo(ar);
  crear_taS(TAS);
  CARGAR_TAS(TAS);
  i:=0;
  { while i<(filesize(ar)) do
  begin
  obtenersigcomplex(ar,i,compolex,lexema);
  writeln('Componentelexico : ',compolex , '   Lexema : ',lexema)
  end;
  readkey;
  clrscr; }

  crear_arbol(arbol);
  iniciar_arbol(asd);
  obtener_arbol_derivacion(ar,pila,TAS,arbol);
  readkey;
  cerrar_Archivo(ar);
end.

