unit u_gabarit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus;

type

  { Tf_gabarit }

  Tf_gabarit = class(TForm)
    item_accueil: TMenuItem;
    item_inscrit: TMenuItem;
    item_liste1: TMenuItem;
    item_archive: TMenuItem;
    item_archive1: TMenuItem;
    item_archive2: TMenuItem;
    item_filiere: TMenuItem;
    item_liste2: TMenuItem;
    item_statistique: TMenuItem;
    item_quitter: TMenuItem;
    mnu_main: TMainMenu;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    pnl_ariane: TPanel;
    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure choix_item_liste;
    procedure choix_item_accueil;
  private

  public

  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }

USES u_feuille_style, u_select_liste, u_list_liste, u_detail_liste,u_modele, u_accueil;

procedure Tf_gabarit.FormShow(Sender: TObject);
begin
 style.panel_selection (pnl_ariane);
 style.panel_defaut (pnl_selection);
 style.panel_travail (pnl_travail);
 style.panel_defaut (pnl_info);
 f_gabarit.width := 1200;
 f_gabarit.height := 800;
 pnl_ariane.Caption := ' >Accueil';
 choix_item_accueil;
 modele.open;
end;

procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
  modele.close;
  close;
end;

procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
   item := TmenuItem(Sender);
   if item=item_liste1 then choix_item_liste;
   if item = item_accueil then choix_item_accueil
end;
procedure Tf_gabarit.choix_item_liste;
begin
 f_list_liste.borderstyle := bsNone;
 f_list_liste.parent := pnl_travail;
 f_list_liste.align := alClient;
 f_list_liste.init;
 f_list_liste.show ;

 f_select_liste.borderstyle := bsNone;
 f_select_liste.parent := pnl_selection;
 f_select_liste.align := alClient;
 f_select_liste.init;
 f_select_liste.show;

 f_detail_liste.borderstyle := bsNone;
 f_detail_liste.parent := pnl_travail;
 f_detail_liste.align := alClient;
end;
procedure Tf_gabarit.choix_item_accueil;
begin
 f_select_liste.Close;
 f_list_liste.Close;

 f_accueil.borderstyle := bsNone;
 f_accueil.parent := pnl_travail;
 f_accueil.align := alClient;
 f_accueil.init;
 f_accueil.show ;
end;
end.

