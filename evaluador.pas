unit Evaluador;



interface

uses
  Sintactico, SysUtils,Lista,Datos;


Procedure EvaluarQ(Arbol : t_arbol;var Estado: t_lista);
Procedure EvaluarListaId(Arbol : t_arbol;var Estado: t_lista);
Procedure EvaluarListaSentencias(Arbol : t_arbol;var Estado: t_lista);
procedure EvaluarU(Arbol : t_arbol;var Estado: t_lista);
Procedure EvaluarSentencia(Arbol : t_arbol;var Estado: t_lista);
Procedure EvaluarAsignacion(Arbol : T_arbol ;var Estado : t_lista);
Procedure EvaluarLectura(Arbol : T_arbol ;var Estado : t_lista);
procedure EvaluarEscritura(Arbol : T_arbol ;var Estado : t_lista);
procedure EvaluarCondicional(Arbol : T_arbol ;var Estado : t_lista);
Procedure EvaluarD(Arbol : T_arbol ;var Estado : t_lista);
Procedure EvaluarCiclo(Arbol : T_arbol ;var Estado : t_lista);
procedure EvaluarOP(Arbol : T_arbol ;var Estado : t_lista; var resultado1 : real);
Procedure EvaluarT(Arbol : T_arbol ;var Estado : t_lista; var resultado1 : real);
procedure EvaluarR(Arbol : T_arbol ;var Estado : t_lista; var resultado1 : real);
Procedure EvaluarX(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
procedure EvaluarZ(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
procedure EvaluarL(Arbol : T_arbol ;var Estado : t_lista;var resultado2 : real);
procedure EvaluarB(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
procedure EvaluarK(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
Procedure EvaluarTalcosa(Arbol : T_arbol ; var Estado : t_lista;var resultado1 : boolean);
Procedure EvaluarC(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
procedure EvaluarF(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
Procedure EvaluarN(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
Procedure EvaluarW(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
Procedure EvaluarG(Arbol : T_arbol; var Estado : t_lista;var Resultado1:Boolean; var Resultado2:real) ;
procedure EstadoAgregarVariable( var Estado : t_lista ; variable : string );
procedure EstadoAsignarValor(  var Estado : t_lista ; variable: string; var resultado1:real );
function Recuperar_valor(var estado : t_lista ; variable: string):real;

implementation


//Q →   Program id var ListaId Cuerpo [ListaSentencias]

Procedure EvaluarQ(Arbol : t_arbol; var Estado: t_lista);
Begin
EvaluarListaId(Arbol^.Hijos[4], Estado);
EvaluarListaSentencias(Arbol^.Hijos[7], Estado);
end;

//ListaId →  id;ListaId | epsilon
Procedure EvaluarListaId(Arbol : t_arbol;var Estado: t_lista);
begin
If  not (arbol^.cant_hijos = 0) then
begin
EstadoAgregarVariable(Estado, Arbol^.Hijos[1]^.Lexema);
EvaluarListaId(Arbol^.Hijos[3], Estado);
end ;
end;

//ListaSentencias→  Sentencia; U
Procedure EvaluarListaSentencias(Arbol : t_arbol;var Estado: t_lista);
begin
EvaluarSentencia(Arbol^.Hijos[1],Estado);
EvaluarU(Arbol^.Hijos[3],Estado);
end;

//U→ ListaSentencias | epsilon
procedure EvaluarU(Arbol : t_arbol;var Estado: t_lista);
begin
If  arbol^.cant_hijos <> 0 then
    EvaluarListaSentencias(Arbol^.Hijos[1],Estado);
end;

//Sentencia →  Asignacion | Lectura | Escritura | Condicional | Ciclo
Procedure EvaluarSentencia(Arbol : t_arbol;var Estado: t_lista);
begin
	case Arbol^.Hijos[1]^.simb of
        VAsignacion : EvaluarAsignacion(Arbol^.Hijos[1],Estado);
	VLectura: EvaluarLectura(Arbol^.Hijos[1],Estado);
	VEscritura: EvaluarEscritura(Arbol^.Hijos[1],Estado);
	VCondicional: EvaluarCondicional(Arbol^.Hijos[1],Estado);
	VCiclo: EvaluarCiclo(Arbol^.Hijos[1],Estado) ;
end;
end;

//Asignacion →  id (= OP
Procedure EvaluarAsignacion(Arbol : T_arbol ;var Estado : t_lista);
var resultado1 : real;
begin
EvaluarOP(Arbol^.Hijos[3], Estado, Resultado1) ;
EstadoAsignarValor(estado,Arbol^.Hijos[1]^.Lexema,Resultado1);
end;

//Lectura →  Aver(cadena,id)
Procedure EvaluarLectura(Arbol : T_arbol ;var Estado : t_lista);
var X : real;
begin
Writeln(Arbol^.Hijos[3]^.Lexema);
Readln(X);
EstadoAsignarValor(Estado, Arbol^.Hijos[5]^.Lexema,X);
end;

//Escritura →  Mira(cadena.OP)
procedure EvaluarEscritura(Arbol : T_arbol ;var Estado : t_lista);
var resultado1 : real;
begin
evaluarOP(Arbol^.Hijos[5],estado,resultado1);
Writeln(Arbol^.Hijos[3]^.Lexema,' ',Resultado1:0:2);
end;

//Condicional →  Sipasa TalCosa [ListaSentencias] D
procedure EvaluarCondicional(Arbol : T_arbol ;var Estado : t_lista);
var resultado1 : boolean;
begin
EvaluarTalCosa(Arbol^.Hijos[2],Estado,Resultado1);
If resultado1 then
EvaluarListaSentencias(Arbol^.Hijos[4],Estado)
else
EvaluarD(Arbol^.Hijos[6],Estado);
end;
//D →  Sinopasa [ListaSentencias] | epsilon
Procedure EvaluarD(Arbol : T_arbol ;var Estado : t_lista);
begin
If arbol^.cant_hijos <> 0 then
EvaluarListaSentencias(Arbol^.Hijos[3],Estado)  ;
end;

//Ciclo → Durante TalCosa[ListaSentencias]
Procedure EvaluarCiclo(Arbol : T_arbol ;var Estado : t_lista);
var resultado1 : boolean;
begin
EvaluarTalCosa(Arbol^.Hijos[2],Estado,Resultado1);
while resultado1 do
begin
EvaluarListaSentencias(Arbol^.Hijos[4],Estado) ;
EvaluarTalCosa(Arbol^.Hijos[2],Estado,Resultado1);
end;
end;

// OP → TB
procedure EvaluarOP(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
begin
EvaluarT(Arbol^.Hijos[1],Estado,Resultado1);
EvaluarB(Arbol^.Hijos[2],Estado,Resultado1);
end;

//T  →  RZ
Procedure EvaluarT(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
begin
EvaluarR(Arbol^.Hijos[1],Estado,Resultado1);
EvaluarZ(Arbol^.Hijos[2],Estado,Resultado1);
end;

//R  → Raiz(OP.entero) | Potencia(OP.entero) | X
procedure EvaluarR(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
var resultado2,resultado3 : real;
    i:integer;
begin
If (Arbol^.Hijos[1]^.simb = TRaiz)  then
begin
     EvaluarOP(Arbol^.Hijos[3],Estado,Resultado1);
     val(Arbol^.Hijos[5]^.Lexema,resultado2,i);
     Resultado1:=Exp(1/resultado2)*ln(Resultado1);
end;
If (Arbol^.Hijos[1]^.simb = TPotencia) then
begin
     EvaluarOP(Arbol^.Hijos[3],Estado,Resultado1);
     val(Arbol^.Hijos[5]^.Lexema,resultado2,i);
     Resultado1:=exp(resultado2*ln(resultado1));
end;
If (Arbol^.Hijos[1]^.simb= VX) then
   EvaluarX(Arbol^.Hijos[1],Estado,Resultado1);

end;
//X → (OP) | id | num | entero | -X
Procedure EvaluarX(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
var i:integer;
begin
case Arbol^.hijos[1]^.simb of
     TparA: EvaluarOP(Arbol^.Hijos[2],Estado,Resultado1);
     Tresta: begin
                  EvaluarX(Arbol^.Hijos[2],Estado,Resultado1);
	          resultado1:= -1 * resultado1
              end;
     Tid: Resultado1:=Recuperar_valor(estado,Arbol^.Hijos[1]^.Lexema);
     Tnum: Val(Arbol^.Hijos[1]^.Lexema,Resultado1,i);
     Tentero: Val(Arbol^.Hijos[1]^.Lexema,Resultado1,i);
end;
end;

//Z → LZ | epsilon
procedure EvaluarZ(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
begin
     if Arbol^.cant_hijos <> 0 then
     begin
        EvaluarL(Arbol^.Hijos[1],Estado,Resultado1);
	EvaluarZ(Arbol^.Hijos[2],Estado,Resultado1);
     end;
end;

//L → *R | /R
procedure EvaluarL(Arbol : T_arbol ;var Estado : t_lista;var resultado2 : real);
var resultado1 :real;
begin
If (Arbol^.hijos[1]^.simb = Tproducto)  then
begin
   EvaluarR(Arbol^.hijos[2],Estado,Resultado1)  ;
   Resultado2:=Resultado2*Resultado1  ;
end;
If (Arbol^.hijos[1]^.simb = Tdiv)  then
begin
   EvaluarR(Arbol^.hijos[2],Estado,Resultado1) ;
   If Resultado1 <>0  then
      Resultado2:=trunc(Resultado2/Resultado1)
   else
    Writeln('La division no se realizo, revisa tus hojas, no se puede dividir por cero');
end;
end;

//B  → KB | epsilon
procedure EvaluarB(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
begin
if Arbol^.cant_hijos <> 0 then
begin
EvaluarK(Arbol^.hijos[1],Estado,Resultado1);
EvaluarB(Arbol^.hijos[2],Estado,Resultado1);
end;
end;

//K →  + T | -T
procedure EvaluarK(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : real);
var resultado2 :real;
begin
If (Arbol^.hijos[1]^.simb = Tsuma)  then
begin
     EvaluarT(Arbol^.hijos[2],Estado,Resultado2);
     Resultado1:=Resultado1 + Resultado2;
end;
If (Arbol^.hijos[1]^.simb = Tresta)  then
begin
     EvaluarT(Arbol^.hijos[2],Estado,Resultado2) ;
     Resultado1:=Resultado1 - Resultado2 ;
end;
end;


//TalCosa → NC
Procedure EvaluarTalcosa(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
begin
     EvaluarN(Arbol^.hijos[1],Estado,Resultado1);
     EvaluarC(Arbol^.hijos[2],Estado,Resultado1);
end;


//C → O Talcosa | F
Procedure EvaluarC(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
var resultado2 : boolean;
begin
if (Arbol^.hijos[1]^.simb = Tero)  then
begin
     EvaluarTalcosa(Arbol^.hijos[2],Estado,Resultado2) ;
     Resultado1:= Resultado1 or Resultado2 ;
end;
If (Arbol^.hijos[1]^.simb = VF) then
     EvaluarF(Arbol^.hijos[1],Estado,Resultado1);
end;


//F → Y talcosa | epsilon
procedure EvaluarF(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
var resultado2:boolean;
begin
If (Arbol^.cant_hijos <> 0) then
begin
     EvaluarTalcosa(Arbol^.hijos[2],Estado,Resultado2);
     Resultado1:= Resultado1 and Resultado2 ;
end;
end;

//N → Nel W | W
Procedure EvaluarN(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
begin
If (Arbol^.hijos[1]^.simb = Tnel)then  begin
   EvaluarW(Arbol^.hijos[2],estado,resultado1);
   resultado1:= not resultado1 ;
end
else
EvaluarW(Arbol^.hijos[1],estado,resultado1);
end;


//W →  OP G  | {Talcosa}
Procedure EvaluarW(Arbol : T_arbol ;var Estado : t_lista;var resultado1 : boolean);
var resultado2:real;
begin
if (Arbol^.hijos[1]^.simb = VOP) then
begin
   EvaluarOP(Arbol^.hijos[1],Estado,Resultado2);
   EvaluarG(Arbol^.hijos[2],Estado,Resultado1,Resultado2);
end;
If (Arbol^.hijos[1]^.simb = TllaveA) then
   EvaluarTalcosa(Arbol^.hijos[2],Estado,Resultado1)
end;



//G →  Comparador OP
Procedure EvaluarG(Arbol : T_arbol; var Estado : t_lista; var Resultado1:Boolean;var Resultado2:real) ;
var resultado3 :real;
begin
EvaluarOP(Arbol^.hijos[2],Estado,Resultado3);
case Arbol^.hijos[1]^.lexema of
'=>' : resultado1:= resultado2 >= resultado3;
'<=' : Resultado1:= resultado2 <= Resultado3;
 '<' : Resultado1:= resultado2 < Resultado3 ;
 '>' : Resultado1:= Resultado2 > Resultado3 ;
 '=' : Resultado1:= Resultado2 = resultado3 ;
 '<>' : Resultado1:= Resultado2 <> resultado3 ;
end;
end;

procedure EstadoAgregarVariable(var Estado : t_lista ; variable: string );
begin
  If not(esta_en_lista(estado,variable)) then
     agregar_lista(estado,variable);
end;

procedure EstadoAsignarValor(  var Estado : t_lista ; variable: string;var resultado1:real );
begin
cambiar_valor(estado,variable,resultado1);
end;

function Recuperar_valor(var estado : t_lista ; variable: string):real;
begin
recuperar_valor:=recuperar_valor_buscado(estado,variable);
end;
end.

