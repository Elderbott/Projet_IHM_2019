unit u_feuille_style;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Controls, ExtCtrls, Grids, StdCtrls, Graphics;
type
 Tfeuille_style = CLASS
 procedure fonte_defaut (ctrl : TControl);
 procedure panel_defaut (pnl : TPanel);
 procedure panel_selection (pnl : TPanel);
 procedure panel_travail (pnl : TPanel);
 procedure panel_bouton (pnl : TPanel);
 procedure grille (grid : TStringGrid);
 procedure label_titre (lbl : TLabel);
 procedure label_erreur (lbl : TLabel);
 procedure combo (cbo : TComboBox);
 procedure memo_info (mmo : TMemo);
 END;
var
 style : Tfeuille_style;

implementation

// fonte par défaut
procedure Tfeuille_style.fonte_defaut (ctrl : TControl);
begin
 ctrl.Font.Name := 'Calibri';
 ctrl.Font.Size := 11;
 ctrl.Font.Color := $00000000;
end;
// panel par défaut
procedure Tfeuille_style.panel_defaut (pnl : TPanel);
begin
 pnl.Color := $00EBEBEB;
 pnl.BorderStyle := bsNone;
 pnl.BevelOuter := bvNone;
 pnl.Alignment := taLeftJustify;
 fonte_defaut(pnl);
end;
// panel sélection (fil d'Ariane, titre, ...)
procedure Tfeuille_style.panel_selection (pnl : TPanel);
begin
 panel_defaut(pnl);
 pnl.Color := $00505050;
 pnl.Font.Color := $00FFFFFF;
end;
// panel zone de travail
procedure Tfeuille_style.panel_travail (pnl : TPanel);
begin
 panel_defaut(pnl);
 pnl.Color := $00FFFFFF;
 pnl.Alignment := taCenter;
end;
// panel aspect bouton et comportement bouton
procedure Tfeuille_style.panel_bouton (pnl : TPanel);
begin
 panel_defaut(pnl);
 pnl.BorderStyle := bsSingle;
end;
end.

