program ProjetIHM;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, u_gabarit, u_feuille_style, u_select_liste, u_list_liste,
  u_detail_liste, u_note_list, u_modele, u_accueil
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tf_gabarit, f_gabarit);
  Application.CreateForm(Tf_select_liste, f_select_liste);
  Application.CreateForm(Tf_list_liste, f_list_liste);
  Application.CreateForm(Tf_detail_liste, f_detail_liste);
  Application.CreateForm(Tf_note_list, f_note_list);
  Application.CreateForm(Tf_accueil, f_accueil);
  Application.Run;
end.

