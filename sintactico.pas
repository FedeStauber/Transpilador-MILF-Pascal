unit Sintactico;


interface

uses crt, Datos,Lexico,Lista;

procedure obtener_arbol_derivacion(var fuente : t_archivo; var pila:t_pila; var TAS: t_tas;var arbol:t_arbol; var Lista : t_lista);

implementation

procedure obtener_arbol_derivacion(var fuente : t_archivo; var pila:t_pila; var TAS: t_tas; var arbol:t_arbol; var Lista : t_lista);
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
  obtenersigcomplex(Fuente,Control,Compolex,Lexema,Lista);
while not((Controlador='Error') or (Controlador='Exito')) do
  begin
       elementopila:=desapilar(pila);
       arbol:=elementopila.p_arbol;
       If elementopila.simb<error then    BEGIN // si el componente desapilado es un terminal
          IF (compolex=elementopila.simb) then  begin  // si el componente desapilado es igual a el componente de la cadena avanza el control
             IF (compolex=pesos) then
                controlador:='Exito'
             else begin
             arbol^.lexema:=lexema;
             obtenersigcomplex(Fuente,Control,Compolex,Lexema,Lista);
             end;
          end
             else
             controlador:='Error';
       end
       else
       begin
           If elementopila.simb>pesos then // si el componente desapilado es una variable
            if tas[elementopila.simb,compolex]=nil then
               controlador:='Error'
               else
               begin
                    for i:=1 to tas[elementopila.simb,compolex]^.cant do  begin
                     crear_nodo(hijo,tas[elementopila.simb,compolex]^.elementos[i],lexema);
                     agregar_hijos(arbol,hijo);
                    end;

                    for i:=tas[elementopila.simb,compolex]^.cant downto 1 do  begin
                     elementopila2.simb:=tas[elementopila.simb,compolex]^.elementos[i];
                     elementopila2.p_arbol:=arbol^.hijos[i];
                     apilar(elementopila2,pila);
                    end;
               end;
       end;
    //writeln('compolex   ', elementopila.simb , '   Lexema  ',lexema );
  end;

  writeln(controlador);

end;



end.

