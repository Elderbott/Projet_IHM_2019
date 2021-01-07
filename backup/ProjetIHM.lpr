program ProjetIHM;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_gabarit, u_feuille_style, u_select_liste, u_list_liste
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tf_gabarit, f_gabarit);
  Application.CreateForm(Tf_select_liste, f_select_liste);
  Application.CreateForm(Tf_list_liste, f_list_liste);
  Application.Run;
end.

