unit lista;

interface


uses
  crt,datos;
type

  t_puntero=^t_nodo;

  t_nodo = record
                   variable: string;
                   valor: real;
                   sig : t_puntero;
                   end;
  t_lista = record
             cab,act: t_puntero ;
             tam : integer;
             end;

procedure crear_lista(var l : t_lista);
procedure agregar_lista(var l : t_lista; variable:string);
function recuperar_lista(var l: t_lista):t_nodo;
function lista_llena(var l :t_lista):boolean;
function lista_vacia(var l : t_lista):boolean;
procedure primero(var l : t_lista);
procedure siguiente(var l : t_lista);
function fin_lista(var l : t_lista):boolean;
procedure disposear_lista(var l : t_lista);
function esta_en_lista(var l:t_lista; buscado : string):boolean;
procedure cambiar_valor(var l:t_lista; buscado : string; valor:real);
function recuperar_valor_buscado(var l:t_lista; buscado : string):real;

implementation
 procedure crear_lista(var l : t_lista);
 begin
   l.tam:=0;
   l.act:=nil;
   l.cab:=nil;
 end;
 procedure agregar_lista(var l : t_lista; variable:string);
 var ant,dir : t_puntero;
 begin
     new(dir);
     dir^.variable:=variable;
     if ((l.cab=nil) or (l.cab^.variable>variable)) then
     begin
       dir^.sig:=l.cab;
       l.cab:=dir;
     end
     else begin
       ant:=l.cab;
       l.act:=l.cab^.sig;
       while ((l.act<>nil) and (l.act^.variable<variable)) do
       begin
             ant:=l.act;
             l.act:=l.act^.sig;
       end;
       dir^.sig:=l.act;
       ant^.sig:=dir;
       end;
       inc(l.tam);
 end;
 function recuperar_lista(var l: t_lista):t_nodo;
 begin
     recuperar_lista:=l.act^;
 end;
 function lista_llena(var l :t_lista):boolean;
 begin
     lista_llena:=getheapstatus.totalfree<sizeof(t_nodo);
 end;
 procedure primero(var l : t_lista);
 begin
     l.act:=l.cab;
 end;
 function fin_lista(var l : t_lista):boolean;
 begin
     fin_lista:=(l.act=nil)
 end;
 procedure siguiente(var l : t_lista);
 begin
     l.act:=l.act^.sig;
 end;
 procedure disposear_lista(var l : t_lista);
 begin
     while (not fin_lista(l)) do
           begin
                 L.act:=L.cab^.sig;
                 dispose(l.cab);
                 l.cab:=l.act;
           end;
     dispose(l.act);
 end;
 function lista_vacia(var l : t_lista):boolean;
 begin
     lista_vacia:=(l.cab=nil);
 end;

 function esta_en_lista(var l:t_lista; buscado : string):boolean;
 begin
   esta_en_lista:=false;
   l.act:=l.cab;
   while (not fin_lista(l)) do begin
        if (l.act^.variable<buscado) then
              siguiente(l);
        if not fin_lista(l) then begin
        if (l.act^.variable=buscado) then
           esta_en_lista:=true;
           siguiente(l);

        end;
   end;
 end;

  procedure cambiar_valor(var l:t_lista; buscado : string; valor:real);
 begin
   primero(l);

       while (l.act^.variable<buscado)do
              siguiente(l);
        if (l.act^.variable=buscado) then
           l.act^.valor:=valor;
 end;

 function recuperar_valor_buscado(var l:t_lista; buscado : string):real;
 begin
   l.act:=l.cab;
   If not (l.cab=nil) then   begin
   while (not fin_lista(l)) do begin
        if (l.act^.variable<buscado) then
              siguiente(l);
        if (l.act^.variable=buscado) then
           recuperar_valor_buscado:=l.act^.valor;
           siguiente(l);
   end;
 end;
 end;
end.

