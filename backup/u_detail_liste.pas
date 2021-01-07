unit u_detail_liste;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_detail_liste }

  Tf_detail_liste = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    cbo_genre: TComboBox;
    cbo_filiere: TComboBox;
    edt_tel: TEdit;
    edt_portable: TEdit;
    edt_mel: TEdit;
    edt_rue: TEdit;
    edt_postal: TEdit;
    edt_ville: TEdit;
    edt_num: TEdit;
    edt_nom: TEdit;
    edt_prenom: TEdit;
    lbl_moy: TLabel;
    lbl_num_erreur: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_rue_erreur: TLabel;
    lbl_postal_erreur: TLabel;
    lbl_ville_erreur: TLabel;
    lbl_tel_erreur: TLabel;
    lbl_mel_erreur: TLabel;
    lbl_filiere_erreur: TLabel;
    lbl_note: TLabel;
    lbl_filiere: TLabel;
    lbl_mel: TLabel;
    lbl_portable: TLabel;
    lbl_tel: TLabel;
    lbl_contact: TLabel;
    lbl_adresse: TLabel;
    lbl_prenom: TLabel;
    lbl_nom: TLabel;
    lbl_num: TLabel;
    lbl_ident: TLabel;
    mmo_filiere: TMemo;
    pnl_note_titre: TPanel;
    pnl_note_list: TPanel;
    pnl_note: TPanel;
    pnl_filiere: TPanel;
    pnl_contact: TPanel;
    pnl_adresse: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure btn_validerClick(Sender: TObject);
    procedure cbo_filiereChange(Sender: TObject);
    procedure edt_melExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_portableExit(Sender: TObject);
    procedure edt_postalExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure edt_rueExit(Sender: TObject);
    procedure edt_telExit(Sender: TObject);
    procedure edt_villeExit(Sender: TObject);
    procedure init ( idinf : string; affi : boolean);
    procedure detail ( idinf : string);
    procedure edit ( idinf : string);
    procedure add;
    procedure delete ( idinf : string);
    procedure affi_filiere (num :string);
    function affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
    function affi_erreur_saisie2 (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;
  private
    procedure affi_page;
  public

  end;

var
  f_detail_liste: Tf_detail_liste;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_liste,u_note_list, u_modele, u_loaddataset;

{ Tf_detail_liste }

Var id : string; //variable active dans toute l'unité, contenant l'id étudiant affichée

procedure Tf_detail_liste.btn_retourClick(Sender: TObject);
begin
  close;
end;

procedure Tf_detail_liste.btn_validerClick(Sender: TObject);
var
 flux : TLoadDataSet;
 saisie, erreur, ch : string;
 i : integer;
 valide : boolean;
begin
 valide := true;
 // code filière obligatoire et existe ?
 erreur := '';
 saisie := cbo_filiere.text;
 if saisie = '' then erreur := 'La filière doit être renseignée.';
 valide := affi_erreur_saisie2 (erreur, lbl_filiere_erreur, cbo_filiere) AND valide;

 // mel obligatoire et existe ?
erreur := '';
saisie := edt_mel.text;
if saisie = '' then erreur := 'L''adresse mel doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_mel_erreur, edt_mel) AND valide;

// portable ou telephone obligatoire et existe ?
erreur := '';
saisie := edt_tel.text;
ch := edt_portable.text;
if (saisie = '') AND (ch = '') then erreur := 'Le téléphone ou le portable doit être rempli.';
valide := affi_erreur_saisie (erreur, lbl_tel_erreur, edt_tel) AND valide;
valide := affi_erreur_saisie (erreur, lbl_tel_erreur, edt_portable) AND valide;

// ville obligatoire et existe ?
erreur := '';
saisie := edt_ville.text;
if saisie = '' then erreur := 'La commune doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_ville_erreur, edt_ville) AND valide;

// cp obligatoire et existe ?
erreur := '';
saisie := edt_postal.text;
if saisie = '' then erreur := 'Le code doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_postal_erreur, edt_postal) AND valide;

// adresse obligatoire et existe ?
erreur := '';
saisie := edt_rue.text;
if saisie = '' then erreur := 'L''adresse doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_rue_erreur, edt_rue) AND valide;

// prenom obligatoire et existe ?
erreur := '';
saisie := edt_prenom.text;
if saisie = '' then erreur := 'Le prénom doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_prenom_erreur, edt_prenom) AND valide;

// nom obligatoire et existe ?
erreur := '';
saisie := edt_nom.text;
if saisie = '' then erreur := 'Le nom doit être remplie';
valide := affi_erreur_saisie (erreur, lbl_nom_erreur, edt_nom) AND valide;

// uniquement pour une nouvelle inscription numéro étudiant correct ?
if id = ''
then begin
erreur := '';
saisie := edt_num.text;
if saisie = '' then erreur := 'Le numéro doit être rempli.'
else begin
flux := modele.etudiant_liste_etud(saisie,'');
if NOT flux.endOf
then erreur := 'Le numéro existe déjà';
end;
valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num) AND valide;
end;
if NOT valide
then messagedlg ('Erreur enregistrement inscription '
, 'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.'
, mtWarning, [mbOk], 0)
else begin
// sauvegarde des données
if id =''
then modele.etudiant_insert(edt_num.text,cbo_genre.text,edt_nom.text,edt_prenom.text,edt_rue.text,edt_postal.text,edt_ville.text,edt_tel.text,edt_portable.text,edt_mel.text,cbo_filiere.Text)
else begin
modele.etudiant_update(edt_num.text,cbo_genre.text,edt_nom.text,edt_prenom.text,edt_rue.text,edt_postal.text,edt_ville.text,edt_tel.text,edt_portable.text,edt_mel.text);
end ;
// sauvegarde de la composition de l'inscription
if id='' then f_list_liste.line_add (modele.etudiant_liste_etud(edt_num.text,''))
else f_list_liste.line_edit(modele.etudiant_liste_etud(id,''));
close;
end;
end;

procedure Tf_detail_liste.cbo_filiereChange(Sender: TObject);
begin
  affi_filiere (cbo_filiere.Text);
end;

procedure Tf_detail_liste.edt_melExit(Sender: TObject);
begin
  edt_mel.text := TRIM(edt_mel.text);
end;

procedure Tf_detail_liste.edt_nomExit(Sender: TObject);
begin
  edt_nom.text := TRIM(edt_nom.text);
end;

procedure Tf_detail_liste.edt_numExit(Sender: TObject);
begin
  edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_liste.edt_portableExit(Sender: TObject);
begin
  edt_portable.text := TRIM(edt_portable.text);
end;

procedure Tf_detail_liste.edt_postalExit(Sender: TObject);
begin
  edt_postal.text := TRIM(edt_postal.text);
end;

procedure Tf_detail_liste.edt_prenomExit(Sender: TObject);
begin
  edt_prenom.text := TRIM(edt_prenom.text);
end;

procedure Tf_detail_liste.edt_rueExit(Sender: TObject);
begin
  edt_rue.text := TRIM(edt_rue.text);
end;

procedure Tf_detail_liste.edt_telExit(Sender: TObject);
begin
  edt_tel.text := TRIM(edt_tel.text);
end;

procedure Tf_detail_liste.edt_villeExit(Sender: TObject);
begin
  edt_ville.text := TRIM(edt_ville.text);
end;

procedure Tf_detail_liste.btn_annulerClick(Sender: TObject);
begin
  close;
end;


procedure	Tf_detail_liste.Init   ( idinf : string;	affi : boolean);
//  ajout nouvelle infraction : id est vide
// affichage détail d'une infraction : affi est vrai sinon affi est faux
begin
   style.panel_travail	(pnl_titre);
   style.panel_travail	(pnl_btn);
   style.panel_travail	(pnl_detail);
	style.panel_travail (pnl_ident);
		style.label_titre  (lbl_ident);
		style.label_erreur (lbl_num_erreur);		lbl_num_erreur.caption    :=  ' ' ;
                style.label_erreur (lbl_nom_erreur);		lbl_nom_erreur.caption    :=  ' ' ;
                style.label_erreur (lbl_prenom_erreur);		lbl_prenom_erreur.caption    :=  ' ' ;
	style.panel_travail (pnl_adresse);
		style.label_titre  (lbl_adresse);
		style.label_erreur (lbl_rue_erreur);		lbl_rue_erreur.caption  :=  ' ' ;
                style.label_erreur (lbl_postal_erreur);		lbl_postal_erreur.caption  :=  ' ' ;
                style.label_erreur (lbl_ville_erreur);		lbl_ville_erreur.caption  :=  ' ' ;
	style.panel_travail (pnl_contact);
		style.label_titre  (lbl_contact);
		style.label_erreur (lbl_tel_erreur);		lbl_tel_erreur.caption :=  ' ' ;
                style.label_erreur (lbl_mel_erreur);		lbl_mel_erreur.caption :=  ' ' ;
	style.panel_travail (pnl_filiere);
		style.label_titre  (lbl_filiere);		style.memo_info  (mmo_filiere);
		style.label_erreur (lbl_filiere_erreur);	lbl_filiere_erreur.caption  :=  ' ' ;

   style.panel_travail (pnl_note);
	style.panel_travail (pnl_note_titre);
		style.label_titre  (lbl_note);
                style.label_titre  (lbl_moy);
	style.panel_travail (pnl_note_list);

// initialisation identification
   lbl_num_erreur.caption :='';
   edt_num.clear;
   edt_num.ReadOnly	:=affi;
   lbl_nom_erreur.caption :='';
   edt_nom.clear;
   edt_nom.ReadOnly	:=affi;
   lbl_prenom_erreur.caption :='';
   edt_prenom.clear;
   edt_prenom.ReadOnly	:=affi;
   cbo_genre.ReadOnly :=affi;
   cbo_genre.Enabled :=false;

// initialisation adresse
   lbl_rue_erreur.caption :='';
   edt_rue.clear;
   edt_rue.ReadOnly	:=affi;
   lbl_ville_erreur.caption :='';
   edt_ville.clear;
   edt_ville.ReadOnly	:=affi;
   lbl_postal_erreur.caption :='';
   edt_postal.clear;
   edt_postal.ReadOnly	:=affi;

// initialisation contact
   lbl_tel_erreur.caption :='';
   edt_tel.clear;
   edt_tel.ReadOnly	:=affi;
   edt_portable.clear;
   edt_portable.ReadOnly	:=affi;
   lbl_mel_erreur.caption :='';
   edt_mel.clear;
   edt_mel.ReadOnly	:=affi;

// initialisation filiere
   lbl_filiere_erreur.caption	:='';
   cbo_filiere.ReadOnly := affi;
   cbo_filiere.Enabled := false;
   mmo_filiere.clear;
   mmo_filiere.ReadOnly	:=true;
   btn_retour.visible	:=affi;  // visible quand affichage détail
   btn_valider.visible	:=NOT  affi;    // visible quand ajout/modification infraction
   btn_annuler.visible	:=NOT  affi;    // visible quand ajout/modification infraction

// initialisation note

   f_note_list.borderstyle := bsNone;
   f_note_list.parent := pnl_note_list;
   f_note_list.align := alClient;
   f_note_list.init(affi);
   f_note_list.show;

   show;

   id  := idinf;
   IF  NOT  ( id = '')   // affichage/modification infraction
   THEN  affi_page;

end;
procedure Tf_detail_liste.affi_filiere (num : string);
var
   ch : string;
begin
     mmo_filiere.clear;
     if num = ''
     then mmo_filiere.lines.add('filiere non identifié.')
else begin
      ch := modele.etudiant_filiere(num);
      if ch ='' then mmo_filiere.lines.add('filiere inconnu.')
      else mmo_filiere.lines.text := ch;
end;
end;
procedure	Tf_detail_liste.affi_page;
var
   flux : TLoadDataSet;
begin
     flux := modele.etudiant_num(id);
     flux.read;
     edt_num.text := flux.Get('id');
     edt_nom.text := flux.Get('nom');
     edt_prenom.text := flux.Get('prenom');
     cbo_genre.text := flux.Get('civ');
     edt_rue.text := flux.Get('adresse');
     edt_postal.text := flux.Get('cp');
     edt_ville.text := flux.Get('ville');
     edt_tel.text := flux.Get('telephone');
     edt_portable.text := flux.Get('portable');
     edt_mel.text := flux.Get('mel');
     cbo_filiere.text := flux.Get('code_filiere');


     affi_filiere (cbo_filiere.Text);
     f_note_list.affi_data(modele.etudiant_comprend_tous(edt_num.text));
     lbl_moy.Caption := (' - Moyenne étudiant : ' +modele.etudiant_moy_inscrit(edt_num.text)+
                      ' - Moyenne filière : ' +modele.etudiant_moy_filiere(flux.Get('id_fil')));
     flux.destroy;
end;

procedure	Tf_detail_liste.detail (idinf : string);
begin
   init (idinf, true);    // mode affichage
   pnl_titre.caption	:= 'Détail d''une inscription';
   btn_retour.setFocus;
   lbl_moy.Show;
   pnl_note_list.Show;
end;

procedure	Tf_detail_liste.edit (idinf : string);
begin
   init (idinf, false);
   pnl_titre.caption	:= 'Modification d''une inscription';
   edt_num.ReadOnly	 := true;
   cbo_filiere.ReadOnly := true;
   lbl_moy.Show;
   pnl_note_list.Show;
   cbo_filiere.Enabled := false;
   cbo_genre.Enabled :=true;

end;
procedure Tf_detail_liste.add;
begin
     init ('',false); // pas de numéro d'inscription
     pnl_titre.caption := 'Nouvelle inscription';
     edt_num.setFocus;
     pnl_note_list.Hide;
     lbl_moy.Hide;
     cbo_filiere.Enabled := true;
     cbo_genre.Enabled :=true;
end;
procedure Tf_detail_liste.delete (idinf : string);
begin
     IF messagedlg ('Demande de confirmation','Confirmez-vous la suppression de l''inscription n°' +idinf
,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
THEN BEGIN
// suppression dans la base, complété par la suite
      modele.etudiant_delete (idinf);
      f_list_liste.line_delete;
END;
end;
function Tf_detail_liste.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
     lbl.caption := erreur;
     if NOT (erreur = '')
     then begin
          edt.setFocus;
          result := false;
     end
     else result := true;
end;
function Tf_detail_liste.affi_erreur_saisie2 (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;
begin
     lbl.caption := erreur;
     if NOT (erreur = '')
     then begin
          cbo.setFocus;
          result := false;
     end
     else result := true;
end;
end.

