program Sintaxis;

uses Datos, Lexico,crt, Sintactico, TypInfo, Evaluador, Lista;
var
  ar : t_archivo;
  i: integer;
  desplazamiento,lexema:string;
  compolex:t_simgramatical;
  tas:t_tas;
  arbol:t_arbol;
  pila:t_pila;
  asd:t_nodo_arbol;
  ar_arbol : text;
  L : t_lista;

begin
  abrir_archivo(ar);
  Abrir_Archivo_Arbol(ar_arbol);
  crear_taS(TAS);
  CARGAR_TAS(TAS);
  i:=0;
  writeln('hola');
 {  while i<(filesize(ar)-10) do
  begin
  obtenersigcomplex(ar,i,compolex,lexema,l);
  writeln('Componentelexico : ',compolex , '   Lexema : ',lexema);
  end;
  readkey;
  clrscr;  }
  crear_arbol(arbol);
  obtener_arbol_derivacion(ar,pila,TAS,arbol,L);
  guardar_arbol_enarchivo (ar_arbol,arbol,desplazamiento) ;
  primero(l);
 { while not (fin_lista(l)) do
  begin
    writeln(recuperar_lista(L).variable);
    siguiente(l);
  end;     }
  readkey;
  cerrar_Archivo(ar);
  cerrar_archivo_Arbol(ar_arbol);
end.

