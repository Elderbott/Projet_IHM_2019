unit u_accueil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_accueil }

  Tf_accueil = class(TForm)
    lbl_lbl1: TLabel;
    lbl_lbl2: TLabel;
    lbl_lbl3: TLabel;
    pnl_accueil: TPanel;
    procedure Init;
  private

  public

  end;

var
  f_accueil: Tf_accueil;

implementation
uses u_feuille_style;
{$R *.lfm}
procedure Tf_accueil.Init;
begin
  style.panel_travail(pnl_accueil);
end;
end.

