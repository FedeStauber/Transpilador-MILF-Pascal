unit Presentadores;



interface
uses Datos, Lexico,crt, Sintactico, Evaluador, Lista;

Procedure Establecer_ruta(var ruta : string; opcion : integer);
procedure ejecutar_archivo(var ruta:string);

implementation

Procedure Establecer_ruta(var ruta : string; opcion : integer);
begin
     case opcion of
     1:ruta:='D:\ARCHIVOS\MILF\FIBONACCI.txt';
     2:ruta:='D:\ARCHIVOS\MILF\M_C_M.txt';
     3:ruta:='D:\ARCHIVOS\MILF\PROMEDIO.txt';
     4:begin
             Writeln('Escriba la ruta del archivo a evaluar');
             Readln(ruta);
       end;
     end;
end;
procedure ejecutar_archivo(var ruta:string);
var ar: t_archivo;
    pila : t_pila;
    Tas : t_tas;
    arbol : t_arbol;
    lista: t_lista;
    control : string;

begin
   abrir_archivo(ar,ruta);
   crear_tas(TAS);
   cargar_tas(TAS);
   crear_arbol(arbol);
   obtener_arbol_derivacion(ar,pila,tas,arbol,lista,control);
   Case control of
   'Exito' : begin
                  Writeln('El archivo es correcto pulse una tecla proceder con la ejecucion');
                  readkey;
                  clrscr;
                  evaluarQ(arbol,lista);
                  readkey;
             end;
   'Error' : begin
                  Writeln('El archivo tiene un problema de indole sintactico debe corregirlo para continuar');
                  readkeY;
             end;
   'Error Lexico' : begin
                         Writeln('El archivo tiene un problema de indole lexico debe corregirlo para continuar');
                         readkey;
                    end;
   end;
   cerrar_Archivo(ar);
end;


end.

