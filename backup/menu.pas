unit Menu;



interface

uses
  Datos, Lexico, crt, Sintactico, TypInfo, Evaluador, Lista, presentadores;
const
  COLOR_FONDO = black;
  COLOR_MENU =  cyan;

  Procedure Pantalla_Inicio();
  Procedure BorrarPantalla();
  Procedure SetOpcionColor(opcion,selected:byte);
  procedure Menu_inicio ();


implementation
Procedure Pantalla_Inicio();
Begin


     gotoxy(15,10);
     Writeln('                                      ) ) )                                                ');
     gotoxy(15,11);
     Writeln('                                     ( ( (                                                 ');
     gotoxy(15,12);
     Writeln('                  ____              . ___ .           """""""            \|||/             ');
     gotoxy(15,13);
     Writeln('                _(____)_             (> <)            ^-O-O-^            (o o)             ');
     gotoxy(15,15);
     Writeln('         ___ooO_(_o__o_)_Ooo______ooO_(_)_Ooo______ooO__(-)__Ooo______ooO_(-)_Ooo___       ');
     textcolor(GREEN);
     gotoxy(15,18);
     Writeln('                    M          .       I        .        L         .       F               ');
     readkey;
     textcolor(WHITE);

end;
procedure BorrarPantalla();
 begin
     TextBackground(COLOR_FONDO);
     clrscr;
 end;

procedure SetOpcionColor(opcion,selected:byte);
  begin
      if(opcion=selected) then Textbackground(COLOR_MENU) else TextBackground(COLOR_FONDO);
  end;

procedure Menu_inicio();
var
    exit:boolean;
    selected:byte;
    tecla:char;
    ruta:string;
begin
      exit:=false;
      selected:=1;
      BorrarPantalla();
      pantalla_inicio();
      while not exit do
      begin
        BorrarPantalla();
        gotoxy(22,11);
        Writeln('                       <<-------(  MENU  )------->> ');
        SetOpcionColor(1,selected);
        gotoxy(55,13);
        Writeln('FIBONACCI');
        SetOpcionColor(2,selected);
        gotoxy(49,14);
        Writeln('MINIMO COMUN MULTIPLO');
        SetOpcionColor(3,selected);
        gotoxy(46,15);
        Writeln('CONDICIONES PARA PROMOCIONAR');
        SetOpcionColor(4,selected);
        gotoxy(46,16);
        Writeln('NUEVO PROGRAMA PERSONALIZADO');
        SetOpcionColor(5,selected);
        gotoxy(57,17);
        Writeln('SALIR');
        Textbackground(black);
        gotoxy(22,19);
        Writeln('                       <<------------------------>> ');

        tecla:=readkey;

          if tecla = #00 then    //#00#72 es flechita para arriba y #00#80 flechita para abajo
             tecla:=readkey;
             case tecla of
                  #72:begin
                      if selected>1 then
                         selected:=selected -1
                      else
                       if selected = 1 then
                         selected:=5;
                      end;

                  #80: begin
                      if selected<5 then
                         selected:=selected+1
                      else
                       if selected = 5 then
                           selected:= 1;


                      end;
                  #13: exit:=true;
                  #27: begin
                       exit:=true;
                       selected:=0;
                       end;
                  end;

      end;

      clrscr;
      IF NOT SELECTED=5 THEN
      begin
           establecer_ruta(ruta,selected);
           ejecutar_archivo(ruta);
      end;

   end;



end.
