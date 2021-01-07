unit u_note_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, StdCtrls, u_liste;

type

  { Tf_note_list }

  Tf_note_list = class(TF_liste)
    lbl_note_total: TLabel;
  procedure Init;
  private

  public

  end;

var
  f_note_list: Tf_note_list;

implementation

{$R *.lfm}

uses u_feuille_style;
procedure Tf_note_list.Init;
begin
 style.panel_travail(pnl_titre);
 style.panel_travail(pnl_affi);
 style.grille (sg_liste);
 sg_liste.Columns[2].Alignment:=taRightJustify;
 pnl_btn.Hide;
 pnl_titre.hide;
end;
end.
