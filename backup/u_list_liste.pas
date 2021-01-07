unit u_list_liste;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, Spin, StdCtrls, u_liste;

type

  { Tf_list_liste }

  Tf_list_liste = class(TF_liste)
    lbl_ligne: TLabel;
    se_ligne: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_line_addClick(Sender: TObject);
    procedure btn_line_deleteClick(Sender: TObject);
    procedure btn_line_detailClick(Sender: TObject);
    procedure btn_line_editClick(Sender: TObject);
    procedure Init;
  private

  public

  end;

var
  f_list_liste: Tf_list_liste;

implementation

{$R *.lfm}

uses u_feuille_style, u_detail_liste;

procedure Tf_list_liste.FormShow(Sender: TObject);
begin
   se_ligne.Value := 20;
end;

procedure Tf_list_liste.btn_line_addClick(Sender: TObject);
begin
  f_detail_liste.add;
end;

procedure Tf_list_liste.btn_line_deleteClick(Sender: TObject);
begin
  f_detail_liste.delete (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_liste.btn_line_detailClick(Sender: TObject);
begin
  f_detail_liste.detail(sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_liste.btn_line_editClick(Sender: TObject);
begin
  f_detail_liste.edit (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_liste.Init;
begin
 style.panel_travail(pnl_titre);
 style.panel_travail(pnl_btn);
 style.panel_travail(pnl_affi);
 style.grille (sg_liste);
end;

end.

