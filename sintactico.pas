unit Sintactico;


interface

uses crt, Datos,Lexico;

procedure obtener_arbol_derivacion(var fuente : t_archivo; var pila:t_pila; var TAS: t_tas;var arbol:t_arbol);

implementation

procedure obtener_arbol_derivacion(var fuente : t_archivo; var pila:t_pila; var TAS: t_tas; var arbol:t_arbol);
var compolex:t_simGramatical;
    Controlador,Lexema:String;
    ElementoPila,elementopila2,elementopila3:t_elemento_pila;
    i,Control:integer;
    hijo:t_arbol;
begin
  crear_tas(tas);
  cargar_tAS(TAS);
  control:=0;
  Controlador:='';
  crear_pila(pila);
  Elementopila.simb:=pesos;
  ElementoPila.p_arbol:=arbol;
  apilar(ElementoPila,pila);
  Elementopila.simb:=VQ;
  ElementoPila.p_arbol:=arbol;
  apilar(elementopila,pila);
  while not((Controlador='Error') or (Controlador='Exito')) do
  begin
       elementopila:=desapilar(pila);
       obtenersigcomplex(Fuente,Control,Compolex,Lexema);
       If elementopila.simb<pesos then    BEGIN
          IF not(compolex=elementopila.simb) then
             controlador:='Error';
          end
       else
           If elementopila.simb>error then
            if tas[elementopila.simb,compolex]=nil then
               controlador:='Error'

               else  begin
               for i:=tas[elementopila.simb,compolex]^.cant downto 1 do  begin
                   elementopila2.simb:=tas[elementopila.simb,compolex]^.elementos[i];
                   elementopila2.p_arbol:=arbol;
                   apilar(elementopila2,pila);
              end;
              //FALTA SOLAMENTE ESTO
               for i:=1 to tas[elementopila.simb,compolex]^.cant do   begin
                   agregar_arbol(hijo,tas[elementopila.simb,compolex]^.cant,compolex,lexema);
                   agregar_hijos(arbol,hijo);
               end;
            //agregar hijos al arbol
          end;

           IF ((elementopila.simb=pesos) and (pesos=compolex)) then
              controlador:='Exito';
           
      writeln(elementopila.simb);
  writeln(compolex);
  writeln(controlador);
  end;


end;



end.

