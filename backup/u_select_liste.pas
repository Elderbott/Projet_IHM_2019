unit u_select_liste;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_select_liste }

  Tf_select_liste = class(TForm)
    btn_rechercher: TButton;
    edt_code: TEdit;
    edt_nometud: TEdit;
    edt_numetud: TEdit;
    lbl_code: TLabel;
    lbl_nometud: TLabel;
    lbl_numetud: TLabel;
    pnl_rechercher: TPanel;
    pnl_filiere_edit: TPanel;
    pnl_filiere_btn: TPanel;
    pnl_filiere: TPanel;
    pnl_etud_edit: TPanel;
    pnl_etud_btn: TPanel;
    pnl_etud: TPanel;
    pnl_tous_edit: TPanel;
    pnl_tous_btn: TPanel;
    pnl_tous: TPanel;
    pnl_choix: TPanel;
    pnl_titre: TPanel;
    procedure btn_rechercherClick(Sender: TObject);
    procedure Init;
    procedure NonSelectionPanel(pnl:TPanel);
    procedure AucuneSelection;
    procedure pnl_choix_btnClick(Sender:TObject);
  private

  public

  end;

var
  f_select_liste: Tf_select_liste;

implementation

{$R *.lfm}

uses u_feuille_style,u_list_liste, u_modele;

var
   pnl_actif:TPanel;

procedure Tf_select_liste.Init;
begin
 style.panel_defaut(pnl_choix);
 style.panel_selection(pnl_titre);
 style.panel_defaut(pnl_rechercher);
 pnl_choix_btnClick(pnl_tous_btn);
end;
procedure Tf_select_liste.pnl_choix_btnClick (Sender : TObject);
var pnl : TPanel;
begin
AucuneSelection; // retirer la sélection en cours
pnl := TPanel(Sender) ;
style.panel_selection (pnl);
pnl := TPanel(pnl.Parent); // récupération du panel parent "pnl_xxx"
style.panel_selection (pnl);
pnl := TPanel(f_select_liste.FindComponent(pnl.name +'_edit'));
style.panel_selection (pnl);
pnl.show;
pnl_actif := pnl; pnl_actif.enabled := true;
btn_rechercher.visible := true;
end;
procedure Tf_select_liste.btn_rechercherClick(Sender: TObject);
begin
btn_rechercher.visible := false;
pnl_actif.enabled := false;
  if pnl_tous_edit.Visible then
  f_list_liste.affi_data(modele.etudiant_liste_tous)
  else if pnl_etud_edit.visible then
  f_list_liste.affi_data(modele.etudiant_liste_etud(edt_numetud.text,edt_nometud.text))
  else if pnl_filiere_edit.visible then
  f_list_liste.affi_data(modele.etudiant_liste_fil(edt_code.text))
end;

procedure Tf_select_liste.NonSelectionPanel (pnl : TPanel);
var pnl_enfant : TPanel;
begin
style.panel_defaut(pnl); // affectation des paramètres Fonte et Couleur du panel pnl_choix
// récupération du panel '_btn'
pnl_enfant := TPanel(f_select_liste.FindComponent(pnl.name +'_btn'));
style.panel_bouton(pnl_enfant);
// récupération du panel '_edit'
pnl_enfant := TPanel(f_select_liste.FindComponent(pnl.name +'_edit'));
pnl_enfant.Hide;
end;
procedure Tf_select_liste.AucuneSelection;
begin
NonSelectionPanel (pnl_tous);
NonSelectionPanel (pnl_filiere);
NonSelectionPanel (pnl_etud);
end;

end.

