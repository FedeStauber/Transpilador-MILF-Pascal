unit Datos;

interface
  uses TypInfo;
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
t_simGramatical = (TProgram,Tid,Tvar,TCuerpo,TcorcheteA,TcorcheteC,Tpuntoycoma,Tasignacion,TAver,TMira,TparA,TparC,TSipasa,TSinopasa,TSuma,Tresta,Tproducto,Tdiv,TRaiz,Tpun,TPotencia,TY,TerO,Tnel,Tcadena,TComparador,TllaveA,TllaveC,Tdurante,Tentero,Tnum,pesos,error,VQ,VListaId,VListasentencias,VU,VSentencia,VAsignacion,VLectura,VEscritura,VCondicional,VD,VCiclo,VOP,VB,VK,VT,VZ,VL,VR,VX,VTalCosa,VC,VF,VN,VW,VG);
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
t_archivo_arbol= file of char ;


procedure Cerrar_Archivo(var ar:T_Archivo);
procedure Abrir_Archivo(var ar: t_archivo);
function leer_archivo(var ar: T_Archivo; pos :cardinal):char;
Procedure crear_pila(tope:t_pila);
procedure Apilar(nuevoDato: t_elemento_pila; var puntero:t_pila);
function Desapilar(var puntero:t_pila): t_elemento_pila;
procedure crear_TAS(var TAS : t_TAS);
procedure cargar_TAS(var TAS : t_TAS);
procedure crear_arbol(var raiz : t_arbol);
procedure crear_nodo(var raiz : t_arbol; compolex:t_simGramatical; Lexema:string);
procedure agregar_hijos(var raiz,hijo : t_arbol);
procedure guardar_arbol_enarchivo(var ar : text; var arbol:t_arbol; desplazamiento : string);
procedure Abrir_Archivo_Arbol(var ar: text);
procedure cerrar_archivo_Arbol(var ar : text);
implementation
procedure Abrir_Archivo(var ar: t_Archivo);
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
procedure cerrar_archivo_Arbol(var ar : text);
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
procedure colocar_epsilon(var TAS : t_tas;F,C : t_simgramatical);
var nuevoElem: t_puntero_celda;
begin
   IF (TAS[F,C]=Nil)then begin
    new(nuevoElem);
    nuevoElem^.cant:=0;
    TAS[F,C]:=nuevoElem;
    end

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

 colocar_epsilon(tas,VListaId,Tcuerpo);

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

 colocar_epsilon(tas,VU,TCorcheteC);

 colocar_tas(tas,VU,TAver,VListaSentencias,1,1);

 colocar_tas(tas,VU,TMira,VListaSentencias,1,1);

 colocar_tas(tas,VU,TSipasa,VListaSentencias,1,1);

 colocar_tas(tas,VU,TDurante,VListaSentencias,1,1);

 colocar_tas(tas,VSentencia,Tid,VAsignacion,1,1);

 colocar_tas(tas,VSentencia,TAver,VLectura,1,1);

 colocar_tas(tas,VSentencia,TMira,VEscritura,1,1);

 colocar_tas(tas,VSentencia,TSipasa,VCondicional,1,1);

 colocar_tas(tas,VSentencia,TDurante,VCiclo,1,1);

 colocar_tas(tas,VAsignacion,Tid,Tid,1,3);
 colocar_tas(tas,VAsignacion,Tid,TAsignacion,2,3);
 colocar_tas(tas,VAsignacion,Tid,VOP,3,3);

 colocar_tas(tas,VLectura,TAver,TAver,1,6);
 colocar_tas(tas,VLectura,TAver,TparA,2,6);
 colocar_tas(tas,VLectura,TAver,Tcadena,3,6);
 colocar_tas(tas,VLectura,TAver,Tpun,4,6);
 colocar_tas(tas,VLectura,TAver,Tid,5,6);
 colocar_tas(tas,VLectura,TAver,TparC,6,6);

 colocar_tas(tas,VEscritura,TMira,TMira,1,6);
 colocar_tas(tas,VEscritura,TMira,TparA,2,6);
 colocar_tas(tas,VEscritura,TMira,Tcadena,3,6);
 colocar_tas(tas,VEscritura,TMira,Tpun,4,6);
 colocar_tas(tas,VEscritura,TMira,VOP,5,6);
 colocar_tas(tas,VEscritura,TMira,TparC,6,6);

 colocar_tas(tas,VCondicional,TSipasa,TSipasa,1,6);
 colocar_tas(tas,VCondicional,TSipasa,VTalCosa,2,6);
 colocar_tas(tas,VCondicional,TSipasa,TCorcheteA,3,6);
 colocar_tas(tas,VCondicional,TSipasa,VListaSentencias,4,6);
 colocar_tas(tas,VCondicional,TSipasa,TCorcheteC,5,6);
 colocar_tas(tas,VCondicional,TSipasa,VD,6,6);

 colocar_epsilon(tas,VD,Tpuntoycoma);

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

 colocar_tas(tas,VOP,Tentero,VT,1,2);
 colocar_tas(tas,VOP,Tentero,VB,2,2);

 colocar_epsilon(tas,VB,TcorcheteA);

 colocar_epsilon(tas,VB,Tpuntoycoma);

 colocar_epsilon(tas,VB,TparC);

colocar_tas(tas,VB,Tsuma,VK,1,2);
colocar_tas(tas,VB,Tsuma,VB,2,2);

colocar_tas(tas,VB,Tresta,VK,1,2);
colocar_tas(tas,VB,Tresta,VB,2,2);

colocar_epsilon(tas,VB,TY);

colocar_epsilon(tas,VB,TerO);

colocar_epsilon(tas,VB,TComparador);

colocar_epsilon(tas,VB,TLlaveC);

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

colocar_tas(tas,VT,Tentero,VR,1,2);
colocar_tas(tas,VT,Tentero,VZ,2,2);

colocar_epsilon(tas,VZ,TcorcheteA);

colocar_epsilon(tas,VZ,Tpuntoycoma);

colocar_epsilon(tas,VZ,TparC);

colocar_epsilon(tas,VZ,Tsuma);

colocar_epsilon(tas,VZ,Tresta);

colocar_tas(tas,VZ,Tproducto,VL,1,2);
colocar_tas(tas,VZ,Tproducto,VZ,2,2);

colocar_tas(tas,VZ,Tdiv,VL,1,2);
colocar_tas(tas,VZ,Tdiv,VZ,2,2);

colocar_epsilon(tas,VZ,TY);

colocar_epsilon(tas,VZ,TerO);

colocar_epsilon(tas,VZ,TComparador);

colocar_epsilon(tas,VZ,TllaveC);

colocar_tas(tas,VR,Tid,VX,1,1);

colocar_tas(tas,VR,TparA,VX,1,1);

colocar_tas(tas,VR,Tresta,VX,1,1);

colocar_tas(tas,VR,TRaiz,TRaiz,1,6);
colocar_tas(tas,VR,TRaiz,TparA,2,6);
colocar_tas(tas,VR,TRaiz,VOP,3,6);
colocar_tas(tas,VR,TRaiz,Tpun,4,6);
colocar_tas(tas,VR,TRaiz,Tentero,5,6);
colocar_tas(tas,VR,TRaiz,TparC,6,6);

colocar_tas(tas,VR,TPotencia,TPotencia,1,6);
colocar_tas(tas,VR,TPotencia,TparA,2,6);
colocar_tas(tas,VR,TPotencia,VOP,3,6);
colocar_tas(tas,VR,TPotencia,Tpun,4,6);
colocar_tas(tas,VR,TPotencia,Tentero,5,6);
colocar_tas(tas,VR,TPotencia,TparC,6,6);

colocar_tas(tas,VR,TNum,VX,1,1);

colocar_tas(tas,VR,Tentero,VX,1,1);

colocar_tas(tas,VX,Tid,Tid,1,1);

colocar_tas(tas,VX,TparA,TparA,1,3);
colocar_tas(tas,VX,TparA,VOP,2,3);
colocar_tas(tas,VX,TparA,TparC,3,3);

colocar_tas(tas,VX,Tresta,Tresta,1,2);
colocar_tas(tas,VX,Tresta,VX,2,2);

colocar_tas(tas,VX,TNum,TNum,1,1);

colocar_tas(tas,VTalCosa,TNel,VN,1,2);
colocar_tas(tas,VTalCosa,TNel,VC,2,2);

colocar_tas(tas,VF,TY,TY,1,2);
colocar_tas(tas,VF,TY,VTalcosa,2,2);

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

colocar_tas(tas,VW,Tentero,VOP,1,2);
colocar_tas(tas,VW,Tentero,VG,2,2);

colocar_tas(tas,VG,TComparador,TComparador,1,2);
colocar_tas(tas,VG,TComparador,VOP,2,2);

colocar_epsilon(tas,VB,Tpun);

colocar_tas(tas,VL,Tproducto,Tproducto,1,2);
colocar_tas(tas,VL,Tproducto,VR,2,2);

colocar_tas(tas,VL,Tdiv,Tdiv,1,2);
colocar_tas(tas,VL,Tdiv,VR,2,2);

colocar_tas(tas,VX,Tentero,Tentero,1,1);

colocar_tas(tas,VC,TY,VF,1,1);

colocar_tas(tas,VC,Tero,TerO,1,2);
colocar_tas(tas,VC,Tero,VTalcosa,2,2);

colocar_tas(tas,VW,TllaveA,TLlaveA,1,3);
colocar_tas(tas,VW,TllaveA,Vtalcosa,2,3);
colocar_tas(tas,VW,TllaveA,TllaveC,3,3);

colocar_tas(tas,VC,Tnel,VF,3,3);

colocar_tas(tas,VF,Tnel,VN,3,3);

colocar_epsilon(tas,VB,Tnel);

colocar_epsilon(tas,VD,Tnel);

colocar_epsilon(tas,Vz,Tpun);


end;
procedure crear_arbol(var raiz : t_arbol);
 begin
   new(raiz);
    raiz^.simb:=VQ;
    raiz^.cant_hijos:=0;
    raiz^.Lexema:='';
 end;
procedure crear_nodo(var raiz : t_arbol; compolex:t_simGramatical; Lexema:string);
var i: integer;

 begin
        new(raiz);
        raiz^.simb:=compolex;
        raiz^.lexema:=lexema;
        raiz^.cant_hijos:=0;
        for i:= 1 to emax do
        raiz^.hijos[i]:=nil;

 end;
procedure agregar_hijos(var raiz,hijo: t_arbol);
begin
     if raiz^.cant_hijos < emax then
	begin
       inc(raiz^.cant_hijos);
       raiz^.hijos[raiz^.cant_hijos] := hijo;
end;

end;
procedure Abrir_Archivo_Arbol(var ar: textfile);
begin
  assign(ar,'D:\archivos\archivo_Arbol.txt');
  {$I-}
  rewrite(ar);
  {$I+}
  if IOResult  <> 0 then
  rewrite(ar);
end;
procedure guardar_arbol_enarchivo (var ar :textfile; var arbol:t_arbol; desplazamiento :string);
var i : integer;
begin
     desplazamiento:=desplazamiento+'  ' ;
     writeln(ar,desplazamiento+getenumname(typeinfo(t_simgramatical),ord(arbol^.simb)));
        for i:=1 to arbol^.cant_hijos do  begin
            guardar_arbol_enarchivo(ar,arbol^.hijos[i],Desplazamiento);

        end;

end;






end.

