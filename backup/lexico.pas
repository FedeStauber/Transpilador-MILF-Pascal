unit Lexico;

interface
uses datos,crt,Lista;



procedure obtenersigcomplex(var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string; var l : t_lista);


implementation
Function carasimbID(c:char):SigmaID;
begin
  Case C of
    'a'..'z', 'A'..'Z':carasimbId:=LetraID;
    '0'..'9':carasimbid:=DigitoID;
    '_','@','#','%','!','?',':': carasimbid:=caracterid
  else
   carasimbid:=OtroID;
end;
end;
Function carasimbCadena(c:char):Sigmacadena;
begin
  Case C of
    'a'..'z', 'A'..'Z':carasimbCadena:=LetracAD;
    '0'..'9':carasimbCadena:=DigitoCAD;
    '_','@','#','%','!','?',':': carasimbCadena:=caractercad;
    '"' : carasimbCadena:=Comilla;
  else
   carasimbcadena:=Otrocad;
end;

end;
Function carasimbComparador(c:char):Sigmacomparador;
begin
  Case C of
    '<':carasimbComparador:= Menor;
    '>':carasimbComparador:= Mayor;
    '=':carasimbComparador:= igual;
  else
   carasimbcomparador:=Otrocomp;
end;
end;
Function carasimbNum(c:char):SigmaNum;
begin
  Case C of
    '0'..'9':carasimbNum:=DigitoNum;
    ',':carasimbNum:=Coma;
  else
   carasimbnum:=OtroNum;
end;
end;
Function es_id (var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string):boolean;
Var controloriginal:integer;
    EstadoActual:Q;
    Delta:t_deltaid;
    C:char;
Begin
  controloriginal:=control;
  Delta[0,Letraid]:=1;
  Delta[0,Digitoid]:=3;
  Delta[0,Caracterid]:=3;
  Delta[0,Otroid]:=3;
  Delta[1,Letraid]:=1;
  Delta[1,Digitoid]:=1;
  Delta[1,Caracterid]:=1;
  Delta[1,Otroid]:=2;
  Delta[3,Letraid]:=3;
  Delta[3,Digitoid]:=3;
  Delta[3,Caracterid]:=3;
  Delta[3,Otroid]:=3;
  EstadoActual:=0;
  Lexema:='';
  while ((control<filesize(fuente)) and (not((EstadoActual=2)or(EstadoActual=3)))) do
  begin
    C:=leer_archivo(fuente,control);
    EstadoActual:=Delta[EstadoActual,carasimbid(C)];
    If carasimbid(C)<>Otroid then
    Lexema:=Lexema+C;
    Inc(control);
  end;
  if(EstadoActual in [1,2]) then
     begin
       es_id:=true;
       case upcase(lexema) of
         'AVER': compolex:=TAver;
         'MIRA': compolex:=Tmira;
         'PROGRAM': compolex:=Tprogram;
         'VAR': compolex:=Tvar;
         'CUERPO': compolex:=Tcuerpo;
         'SIPASA': compolex:=TSipasa;
         'SINOPASA': compolex:=Tsinopasa;
         'DURANTE': compolex:=TDurante;
         'RAIZ': compolex:=TRaiz;
         'POTENCIA': compolex:=TPotencia;
         'NEL': compolex:=TNel;
       else
          compolex:=Tid;
         end;
       dec(control);
     end
  else  begin
    es_id:=false;
    control:=controloriginal
    end;
  end;
Function es_cadena (var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string):Boolean;
Var controloriginal:integer;
    EstadoActual:Q;
    Delta:t_deltacad;
    C:char;
Begin
  controloriginal:=control;
 Delta[0,Comilla]:=1;
 Delta[0,DigitoCad]:=3;
 Delta[0,LetraCad]:=3;
 Delta[0,OtroCad]:=3;
 Delta[0,CaracterCad]:=3;
 Delta[1,Comilla]:=2;
 Delta[1,DigitoCad]:=1;
 Delta[1,LetraCad]:=1;
 Delta[1,OtroCad]:=1;
 Delta[1,CaracterCad]:=1;
 Delta[2,Comilla]:=3;
 Delta[2,DigitoCad]:=3;
 Delta[2,LetraCad]:=3;
 Delta[2,OtroCad]:=4;
 Delta[2,CaracterCad]:=3;
 Delta[3,Comilla]:=3;
 Delta[3,DigitoCad]:=3;
 Delta[3,LetraCad]:=3;
 Delta[3,OtroCad]:=3;
 Delta[3,CaracterCad]:=3;
  EstadoActual:=0;
  Lexema:='';
  while ((control<filesize(fuente)) and (not((EstadoActual=4)or(EstadoActual=3)))) do
  begin
    C:=leer_archivo(fuente,control);
    EstadoActual:=Delta[EstadoActual,carasimbcadena(C)];
    If carasimbcadena(C)<>Otrocad then
    Lexema:=Lexema+C;
    Inc(control);
  end;
  if(EstadoActual in [2,4]) then
     begin
       es_cadena:=true;
       compolex:=TCadena;
       dec(control);
     end
  else     begin
    es_cadena:=false;
    control:=controloriginal
    end;
  end;
Function es_comparador (var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string):Boolean;
Var controloriginal:integer;
    EstadoActual:Q;
    Delta:t_deltacomparador;
    C:char;
Begin
  controloriginal:=control;
  Delta[0,Mayor]:=1;
  Delta[0,Menor]:=4;
  Delta[0,Igual]:=5;
  Delta[0,OtroComp]:=8;
  Delta[1,Mayor]:=8;
  Delta[1,Menor]:=8;
  Delta[1,Igual]:=8;
  Delta[1,OtroComp]:=9;
  Delta[3,Mayor]:=8;
  Delta[3,Menor]:=8;
  Delta[3,Igual]:=8;
  Delta[3,OtroComp]:=9;
  Delta[4,Mayor]:=6;
  Delta[4,Menor]:=8;
  Delta[4,Igual]:=7;
  Delta[4,OtroComp]:=9;
  Delta[5,Mayor]:=3;
  Delta[5,Menor]:=8;
  Delta[5,Igual]:=8;
  Delta[5,OtroComp]:=9;
  Delta[6,Mayor]:=8;
  Delta[6,Menor]:=8;
  Delta[6,Igual]:=8;
  Delta[6,OtroComp]:=9;
  Delta[7,Mayor]:=8;
  Delta[7,Menor]:=8;
  Delta[7,Igual]:=8;
  Delta[7,OtroComp]:=9;
  Delta[8,Mayor]:=8;
  Delta[8,Menor]:=8;
  Delta[8,Igual]:=8;
  Delta[8,OtroComp]:=8;
  EstadoActual:=0;
  Lexema:='';
  while ((control<filesize(fuente)) and (not((EstadoActual=9)or(EstadoActual=8)))) do
  begin
    C:=leer_archivo(fuente,control);
    EstadoActual:=Delta[EstadoActual,carasimbcomparador(C)];
    If carasimbcomparador(C)<>Otrocomp then
    Lexema:=Lexema+C;
    Inc(control);
  end;
  if(EstadoActual in [1,3,4,5,6,7,9]) then
     begin
       es_comparador:=true;
       compolex:=TComparador;
       dec(control);
     end
  else  begin
    es_comparador:=false;
    control:=controloriginal
    end;
  end;
Function es_Num (var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string):Boolean;
Var controloriginal:integer;
    EstadoActual:Q;
    Delta:t_deltaNum;
    C:char;
Begin
 controloriginal:=control;
 Delta[0,Coma]:=2;
 Delta[0,DigitoNum]:=1;
 Delta[0,OtroNum]:=2;
 Delta[1,Coma]:=4;
 Delta[1,DigitoNum]:=1;
 Delta[1,OtroNum]:=6;
 Delta[2,Coma]:=2;
 Delta[2,DigitoNum]:=2;
 Delta[2,OtroNum]:=2;
 Delta[3,Coma]:=2;
 Delta[3,DigitoNum]:=3;
 Delta[3,OtroNum]:=5;
 Delta[4,Coma]:=2;
 Delta[4,DigitoNum]:=3;
 Delta[4,OtroNum]:=2;
 EstadoActual:=0;
 Lexema:='';
 while ((control<filesize(fuente)) and (not(EstadoActual in [2,5,6]))) do    //((EstadoActual=5)or(EstadoActual=6)or(EstadoActual=2)))) do
  begin
    C:=leer_archivo(fuente,control);
    EstadoActual:=Delta[EstadoActual,carasimbnum(C)];
    If carasimbnum(C)<>OtroNum then
    Lexema:=Lexema+C;
    Inc(control);
  end;
  if(EstadoActual in [3,5]) then
     begin
       es_num:=true;
       compolex:=TNum;
       dec(control);
     end
  else
  if(EstadoActual in [1,6]) then
     begin
       es_num:=true;
       compolex:=Tentero;
       dec(control);
     end
  else begin
    es_num:=false;
    control:=controloriginal;
    end;
  end;
Function car_es (var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string):boolean;
var c:char;
Begin
 if (Control<filesize(fuente)) then
 c:=leer_archivo(fuente,control);
       case c of
        '[': begin
             compolex:=TcorcheteA;
             lexema:='[';
             car_es:=true;
             end;
        ']': begin
             compolex:=TcorcheteC;
             lexema:=']';
             car_es:=true;
             end;
        ';': begin
             compolex:=Tpuntoycoma;
             lexema:=';';
             car_es:=true;
             end;
        '(': begin
             if not(control=filesize(fuente))  then
             c:=leer_Archivo(fuente,control+1);
             if c='=' then  begin
             compolex:=Tasignacion;
             lexema:='(=';
             inc(control);
             end else  begin
             compolex:=TparA;
             lexema:='(';
             end;
             car_es:=true;
             end;
        ')': begin
             compolex:= TparC;
             lexema:= ')';
             car_es:=true;
             end;
        '+': begin
             compolex:= Tsuma;
             lexema:= '+';
             car_es:=true;
             end;
        '-': begin
             compolex:= Tresta;
             lexema:= '-';
             car_es:=true;
             end;
        '*': begin
             compolex:=Tproducto;
             lexema:= '*';
             car_es:=true;
             end;
        '/': begin
             compolex:=Tdiv;
             lexema:= '/';
             car_es:=true;
             end;
        '.': begin
             compolex:=Tpun;
             lexema:= '.';
             car_es:=true;
             end;
        '{': begin
             compolex:=TllaveA;
             lexema:= '{';
             car_es:=true;
             end;
        '}': begin
             compolex:=TllaveC;
             lexema:= '}';
             car_es:=true;
             end;
        '^': begin
             compolex:=TY;
             lexema:='^';
             car_es:=true;
             end;
        '|': begin
             compolex:=TerO;
             lexema:='|';
             car_es:=true;
             end;
        '$': begin
             compolex:=pesos;
             lexema:='$';
             car_es:=true;
             end;

end;
end;


procedure obtenersigcomplex(var fuente:t_archivo; var control:integer; var compolex:t_simGramatical; var lexema:string; var l : t_lista); //var l:t_tabla);
var
C:char;
begin
lexema:='';
compolex:=ERROR;
c:=leer_archivo(fuente,control);
while ((c in[#0..#32])  and (control<Filesize(fuente))) do       //SALTEA ESPACIOS EN BLANCO Y CARACTERES NO SIGNIFICATIVOS
Begin
     inc (control);
     c:=leer_archivo(fuente,control);
end;
    if es_id(fuente,control,compolex,lexema) then
    begin
         If  not (esta_en_lista(L,Lexema)) then
             agregar_lista(l,Lexema) ;
    end
    else
        If es_num (fuente,control,compolex,lexema) then
        else
            If es_cadena(fuente,control,compolex,lexema) then
            else
                If es_comparador(fuente,control,compolex,lexema)then
                else
                    if(car_es(fuente,control,compolex,lexema)) then
                      inc(control);

end;





end.
