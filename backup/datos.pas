unit Datos;
/holaa

interface

   const
  Emax = 8;

type
Q= 0..9;
Sigmaid= (LetraID,DigitoID,OtroID,caracterid);
Sigmanum= (DigitoNum,Coma,OtroNum);
Sigmacomparador= (Menor,Mayor,igual,OtroComp);
Sigmacadena= (LetraCad, DigitoCad,Comilla, OtroCad,caractercad);
t_deltaid=Array[Q,Sigmaid] of Q;
t_deltacad=Array[Q,Sigmacadena] of Q;
t_deltacomparador=Array[Q,Sigmacomparador] of Q;
t_deltaNum=Array[Q,Sigmanum] of Q;

T_Archivo = file of char;
t_simGramatical = (TProgram,Tid,Tvar,TCuerpo,TcorcheteA,TcorcheteC,Tpuntoycoma,Tasignacion,TAver,TMira,TparA,TparC,TSipasa,TSinopasa,TSuma,Tresta,Tproducto,Tdiv,TRaiz,Tcoma,TPotencia,TY,TerO,Tnel,Tcadena,TComparador,TllaveA,TllaveC,Tdurante,Tnum,pesos,error,VQ,VListaId,VListasentencias,VU,VSentencia,VAsignacion,VLectura,VEscritura,VCondicional,VD,VCiclo,VOP,VB,VK,VT,VZ,VL,VR,VX,VTalCosa,VC,VF,VN,VW,VG);  //resolver y agregar T'«', T'»',
t_arbol =  ^t_nodo_arbol;
t_nodo_arbol = record
              simb:t_simGramatical;
              Lexema:string;
              hijos : array[1..Emax] of  t_arbol;
              cant_hijos : 0..Emax;
              end;
t_pila = record
            punt: ^t_nodo_pila;
            cant_elementos:integer;
            end;
t_elemento_pila = record
                        simb: t_simGramatical;
                        p_arbol : t_arbol;
                        end;
t_nodo_pila = record
                    datos: t_elemento_pila;
                    siguiente:  t_pila;
                    end;
t_celda =  record
                 elementos: array[1..Emax] of t_simGramatical;
                 cant: byte;
                 end;
t_puntero_celda =   ^t_celda;
t_TAS = array[VQ..VG,Tprogram..pesos] of t_puntero_celda;



procedure Cerrar_Archivo(var ar:T_Archivo);
procedure Abrir_Archivo(var ar: T_Archivo);
function leer_archivo(var ar: T_Archivo; pos :cardinal):char;
Procedure crear_pila(tope:t_pila);
procedure Apilar(nuevoDato: t_elemento_pila; var puntero:t_pila);
function Desapilar(var puntero:t_pila): t_elemento_pila;
procedure crear_TAS(var TAS : t_TAS);
procedure cargar_TAS(var TAS : t_TAS);
procedure crear_arbol(var raiz : t_arbol);
procedure agregar_arbol(var raiz : t_arbol; N:integer; compolex:t_simGramatical; Lexema:string);
implementation
procedure Abrir_Archivo(var ar: T_Archivo);
begin
  assign(ar,'D:\archivos\archivo');
  {$I-}
  reset(ar);
  {$I+}
  if IOResult  <> 0 then
  rewrite(ar);
end;
procedure Cerrar_Archivo(var ar:T_Archivo);
begin
  close(ar);
end;
function leer_archivo(var ar: T_Archivo; pos :cardinal):char;
begin
  seek(ar,pos);
  read(ar,leer_Archivo);
end;
Procedure crear_pila(tope:t_pila);
begin
  tope.punt:=nil;
  tope.cant_elementos:=0;
end;
procedure Apilar(nuevoDato: t_elemento_pila; var puntero:t_pila);
var
    nuevoNodo: ^t_nodo_pila;
begin
    new(nuevoNodo);
    nuevoNodo^.datos := nuevoDato;
    nuevoNodo^.siguiente := puntero;
    puntero.punt := nuevoNodo;
    inc(puntero.cant_elementos);
end;
function Desapilar(var puntero:t_pila): t_elemento_pila;
var
    nuevoTope: t_pila;
begin
    Desapilar := puntero.punt^.datos;
    nuevoTope := puntero.punt^.siguiente;
    dispose(puntero.punt);
    puntero.punt := nuevoTope.punt;
    dec(puntero.cant_elementos);
end;
procedure crear_TAS(var TAS : t_TAS);
var  i,j : t_simGramatical;
    begin
        for i:= VQ to VG do
            for j:=Tprogram to pesos do
                TAS[i,j]:=nil;
    end;
PROCEDURE colocar_tas(var TAS : t_tas;F,C,Cosa:t_simgramatical;n,k:integer) ;
var nuevoElem: t_puntero_celda;
begin
    IF (TAS[F,C]=Nil)then begin
    new(nuevoElem);
    nuevoElem^.elementos[N]:=cosa;
    nuevoElem^.cant:=k;
    TAS[F,C]:=nuevoElem;
    end
    else
     TAS[F,C]^.elementos[N]:=cosa;
end;
procedure cargar_TAS(var TAS : t_TAS);
begin
 colocar_tas(tas,VQ,Tprogram,Tprogram,1,8);
 colocar_tas(tas,vq,tprogram,Tid,2,8);
 colocar_tas(tas,vq,tprogram,Tvar,3,8);
 colocar_tas(tas,vq,tprogram,VlistaiD,4,8);
 colocar_tas(tas,vq,tprogram,TCuerpo,5,8);
 colocar_tas(tas,vq,tprogram,TCorcheteA,6,8);
 colocar_tas(tas,vq,tprogram,VListaSentencias,7,8);
 colocar_tas(tas,vq,tprogram,TCorcheteC,8,8);

 colocar_tas(tas,VListaId,Tid,Tid,1,3);
 colocar_tas(tas,VListaId,Tid,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaId,Tid,VListaId,3,3);

 //TAS[VListaId,TCuerpo]:=EPSILON;

 colocar_tas(tas,VListaSentencias,Tid,VSentencia,1,3);
 colocar_tas(tas,VListaSentencias,Tid,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaSentencias,Tid,VU,3,3);

 colocar_tas(tas,VListaSentencias,TAver,VSentencia,1,3);
 colocar_tas(tas,VListaSentencias,TAver,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaSentencias,TAver,VU,3,3);

 colocar_tas(tas,VListaSentencias,TMira,VSentencia,1,3);
 colocar_tas(tas,VListaSentencias,TMira,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaSentencias,TMira,VU,3,3);

 colocar_tas(tas,VListaSentencias,TSipasa,VSentencia,1,3);
 colocar_tas(tas,VListaSentencias,TSipasa,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaSentencias,TSipasa,VU,3,3);

 colocar_tas(tas,VListaSentencias,TDurante,VSentencia,1,3);
 colocar_tas(tas,VListaSentencias,TDurante,Tpuntoycoma,2,3);
 colocar_tas(tas,VListaSentencias,TDurante,VU,2,3);

 colocar_tas(tas,VU,Tid,VListaSentencias,1,1);
 //TAS[VU,TCorcheteC]^.elementos:= EPSILON;
 //TAS[VU,TCorcheteC]^.cant := 1;

 colocar_tas(tas,VU,TAver,VListaSentencias,1,1);

 colocar_tas(tas,VU,TMira,VListaSentencias,1,1);

 colocar_tas(tas,VU,TSipasa,VListaSentencias,1,1);

 colocar_tas(tas,VU,TDurante,VListaSentencias,1,1);

 colocar_tas(tas,VSentencia,Tid,VAsignacion,1,1);

 colocar_tas(tas,VSentencia,TAver,VLectura,1,1);

 colocar_tas(tas,VSentencia,TMira,VEscritura,1,1);

 colocar_tas(tas,VSentencia,TSipasa,VCondicional,1,1);

 colocar_tas(tas,VSentencia,TDurante,VCondicional,1,1);

 colocar_tas(tas,VAsignacion,Tid,Tid,1,3);
 colocar_tas(tas,VAsignacion,Tid,TAsignacion,2,3);
 colocar_tas(tas,VAsignacion,Tid,VOP,3,3);

 colocar_tas(tas,VLectura,TAver,TAver,1,6);
 colocar_tas(tas,VLectura,TAver,TparA,2,6);
 colocar_tas(tas,VLectura,TAver,Tcadena,3,6);
 colocar_tas(tas,VLectura,TAver,Tcoma,4,6);
 colocar_tas(tas,VLectura,TAver,Tid,5,6);
 colocar_tas(tas,VLectura,TAver,TparC,6,6);

 colocar_tas(tas,VEscritura,TMira,TMira,1,6);
 colocar_tas(tas,VEscritura,TMira,TparA,2,6);
 colocar_tas(tas,VEscritura,TMira,Tcadena,3,6);
 colocar_tas(tas,VEscritura,TMira,Tcoma,4,6);
 colocar_tas(tas,VEscritura,TMira,VOP,5,6);
 colocar_tas(tas,VEscritura,TMira,TparC,6,6);

 colocar_tas(tas,VCondicional,TSipasa,TSipasa,1,6);
 colocar_tas(tas,VCondicional,TSipasa,VTalCosa,2,6);
 colocar_tas(tas,VCondicional,TSipasa,TCorcheteA,3,6);
 colocar_tas(tas,VCondicional,TSipasa,VListaSentencias,4,6);
 colocar_tas(tas,VCondicional,TSipasa,TCorcheteC,5,6);
 colocar_tas(tas,VCondicional,TSipasa,VD,6,6);

//TAS[VD,Tpuntoycoma]^.elementos[1]:= EPSILON;
//TAS[VD,Tpuntoycoma]^.cant:= 1;

 colocar_tas(tas,VD,TSinopasa,TSinopasa,1,4);
 colocar_tas(tas,VD,TSinopasa,TCorcheteA,2,4);
 colocar_tas(tas,VD,TSinopasa,VListaSentencias,3,4);
 colocar_tas(tas,VD,TSinopasa,TCorcheteC,4,4);

 colocar_tas(tas,VCiclo,TDurante,TDurante,1,5);
 colocar_tas(tas,VCiclo,TDurante,VTalCosa,2,5);
 colocar_tas(tas,VCiclo,TDurante,TCorcheteA,3,5);
 colocar_tas(tas,VCiclo,TDurante,VListaSentencias,4,5);
 colocar_tas(tas,VCiclo,TDurante,TCorcheteC,5,5);

 colocar_tas(tas,VOP,Tid,VT,1,2);
 colocar_tas(tas,VOP,Tid,VB,2,2);

 colocar_tas(tas,VOP,TparA,VT,1,2);
 colocar_tas(tas,VOP,TparA,VB,2,2);

 colocar_tas(tas,VOP, Tresta,VT,1,2);
 colocar_tas(tas,VOP, Tresta,VB,2,2);

 colocar_tas(tas,VOP,TRaiz,VT,1,2);
 colocar_tas(tas,VOP,TRaiz,VB,2,2);

 colocar_tas(tas,VOP,TPotencia,VT,1,2);
 colocar_tas(tas,VOP,TPotencia,VB,2,2);

 colocar_tas(tas,VOP,TNum,VT,1,2);
 colocar_tas(tas,VOP,TNum,VB,2,2);

//TAS[VB,TcorcheteA]^.elementos[1]:= EPSILON;
//TAS[VB,TcorcheteA]^.cant:= 1;

//TAS[VB,Tpuntoycoma]^.elementos[1]:= EPSILON;
//TAS[VB,Tpuntoycoma]^.cant:= 1;

//TAS[VB,TparC]^.elementos[1]:=EPSILON;
//TAS[VB,TparC]^.cant:=1;

colocar_tas(tas,VB,Tsuma,VK,1,2);
colocar_tas(tas,VB,Tsuma,VB,2,2);

colocar_tas(tas,VB,Tresta,VK,1,2);
colocar_tas(tas,VB,Tresta,VB,2,2);

//TAS[VB,TY]^.elementos[1]:= EPSILON;
//TAS[VB,TY]^.cant:= 1;

//TAS[VB,TerO]^.elementos[1]:= EPSILON;
//TAS[VB,TerO]^.cant:= 1;

//TAS[VB,TComparador]^.elementos[1]:= EPSILON;
//TAS[VB,TComparador]^.cant:= 1;

//TAS[VB,TLlaveC]^.elementos[1]:= EPSILON;
//TAS[VB,TLlaveC]^.cant:= 1;

colocar_tas(tas,VK,Tsuma,Tsuma,1,2);
colocar_tas(tas,VK,Tsuma,VT,2,2);

colocar_tas(tas,VK,Tresta,Tresta,1,2);
colocar_tas(tas,VK,Tresta,VT,2,2);

colocar_tas(tas,VT,Tid,VR,1,2);
colocar_tas(tas,VT,Tid,VZ,2,2);

colocar_tas(tas,VT,TparA,VR,1,2);
colocar_tas(tas,VT,TparA,VZ,2,2);

colocar_tas(tas,VT,Tresta,VR,1,2);
colocar_tas(tas,VT,Tresta,VZ,2,2);

colocar_tas(tas,VT,TRaiz,VR,1,2);
colocar_tas(tas,VT,TRaiz,VZ,2,2);

colocar_tas(tas,VT,TPotencia,VR,1,2);
colocar_tas(tas,VT,TPotencia,VZ,2,2);

colocar_tas(tas,VT,TNum,VR,1,2);
colocar_tas(tas,VT,TNum,VZ,2,2);

//TAS[VZ,TcorchteA]^.elementos[1]:= EPSILON;
//TAS[VZ,TcorcheteA]^.cant:= 1;

//TAS[VZ,Tpuntoycoma]^.elementos[1]:= EPSILON;
//TAS[VZ,Tpuntoycoma]^.cant:= 1;

//TAS[VZ,TparC]^.elementos[1]:= EPSILON;
//TAS[VZ,TparC]^.cant:= 1;

//TAS[VZ,Tsuma]^.elementos[1]:= EPSILON;
//TAS[VZ,Tsuma]^.cant:= 1;

//TAS[VZ,Tresta]^.elementos[1]:= EPSILON;
//TAS[VZ,Tresta]^.cant:= 1;

colocar_tas(tas,VZ,Tproducto,VL,1,2);
colocar_tas(tas,VZ,Tproducto,VZ,2,2);

colocar_tas(tas,VZ,Tdiv,VL,1,2);
colocar_tas(tas,VZ,Tdiv,VZ,2,2);

//TAS[VZ,TY]^.elementos[1]:= EPSILON;
//TAS[VZ,TY]^.cant:= 1;

//TAS[VZ,TerO]^.elementos[1]:= EPSILON;
//TAS[VZ,TerO]^.cant:= 1;

//TAS[VZ,TComparador]^.elementos[1]:= EPSILON;
//TAS[VZ,TComparador]^.cant:= 1;

//TAS[VZ,TllaveC]^.elementos[1]:= EPSILON;
//TAS[VZ,TllaveC]^.cant:= 1;

colocar_tas(tas,VR,Tid,VX,1,1);

colocar_tas(tas,VR,TparC,VX,1,1);

colocar_tas(tas,VR,Tresta,VX,1,1);

colocar_tas(tas,VR,TRaiz,TRaiz,1,6);
colocar_tas(tas,VR,TRaiz,TparA,2,6);
colocar_tas(tas,VR,TRaiz,VOP,3,6);
colocar_tas(tas,VR,TRaiz,Tcoma,4,6);
//colocar_tas(tas,VR,TRaiz,Tentero,5,6);  //ver lo del entero
colocar_tas(tas,VR,TRaiz,TparC,6,6);

colocar_tas(tas,VR,TPotencia,TPotencia,1,6);
colocar_tas(tas,VR,TPotencia,TparA,2,6);
colocar_tas(tas,VR,TPotencia,VOP,3,6);
colocar_tas(tas,VR,TPotencia,Tcoma,4,6);
//colocar_tas(tas,VR,TPotencia,Tentero,5,6);   //ver lo de tentero
colocar_tas(tas,VR,TPotencia,TparC,6,6);

colocar_tas(tas,VR,TNum,VX,1,1);

colocar_tas(tas,VX,Tid,Tid,1,1);

colocar_tas(tas,VX,TparA,TparA,1,3);
colocar_tas(tas,VX,TparA,VOP,2,3);
colocar_tas(tas,VX,TparA,TparC,3,3);

colocar_tas(tas,VX,Tresta,Tresta,1,2);
colocar_tas(tas,VX,Tresta,VX,2,2);

colocar_tas(tas,VX,TNum,TNum,1,1);

colocar_tas(tas,VTalCosa,TNel,VN,1,2);
colocar_tas(tas,VTalCosa,TNel,VC,2,2);

colocar_tas(tas,VC,TNel,VN,1,2);
colocar_tas(tas,VC,TNel,VF,2,2);

//TAS[VF,TcorcheteA]^.elementos[1]:= EPSILON;
//TAS[VF,TcorcheteA]^.cant:= 1;

colocar_tas(tas,VF,TY,TY,1,2);
colocar_tas(tas,VF,TY,VTalcosa,2,2);

//TAS[VF,TcorcheteC]^.elementos[1]:= EPSILON;
//TAS[VF,TcorcheteC]^.cant:= 1;

colocar_tas(tas,VN,TNel,TNel,1,2);
colocar_tas(tas,VN,TNel,VW,2,2);

colocar_tas(tas,VW,Tid,VOP,1,2);
colocar_tas(tas,VW,Tid,VG,2,2);

colocar_tas(tas,VW,TparA,VOP,1,2);
colocar_tas(tas,VW,TparA,VG,2,2);

colocar_tas(tas,VW,Tresta,VOP,1,2);
colocar_tas(tas,VW,Tresta,VG,2,2);

colocar_tas(tas,VW,TRaiz,VOP,1,2);
colocar_tas(tas,VW,TRaiz,VG,2,2);

colocar_tas(tas,VW,TPotencia,VOP,1,2);
colocar_tas(tas,VW,TPotencia,VG,2,2);

colocar_tas(tas,VW,TNum,VOP,1,2);
colocar_tas(tas,VW,TNum,VG,2,2);

colocar_tas(tas,VG,TComparador,TComparador,1,2);
colocar_tas(tas,VG,TComparador,VOP,2,2);

end;
procedure crear_arbol(var raiz : t_arbol);
 begin
   raiz:=nil;
 end;
procedure agregar_arbol(var raiz : t_arbol; N:integer; compolex:t_simGramatical; Lexema:string);
var i: integer;
    cargado:boolean;
 begin

   if (raiz = nil) then
      begin
        new(raiz);
        raiz^.simb:=compolex;
        raiz^.lexema:=lexema;
        for i:= 1 to n do
        raiz^.hijos[i]:=nil;

      end
   else
       repeat
       If raiz^.hijos[i]=nil then   begin
           agregar_arbol(raiz^.hijos[i],N,Compolex,Lexema);
           inc(i);
       end
       else
       begin
       inc(i);
       cargado:=falsE;
       end;
       until(cargado);

 end;

end.

