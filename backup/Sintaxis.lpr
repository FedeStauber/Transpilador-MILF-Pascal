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
   for i:=tas[elementopila.simb,compolex]^.cant downto 1 do
      writeln(i);
  crear_arbol(arbol);
  obtener_arbol_derivacion(ar,pila,TAS,arbol);
  readkey;
  cerrar_Archivo(ar);
end.

