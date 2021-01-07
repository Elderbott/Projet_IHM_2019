unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_loaddataset;

type
Tmodele = class(TMySQL)
private
{ private declarations }
public
{ public declarations }
procedure open;
procedure etudiant_delete (id : string);
procedure etudiant_insert (id,genre,nom,prenom,rue,cp,ville,tel,portable,mel, code_filiere : string);
procedure etudiant_update (id,genre,nom,prenom,rue,cp,ville,tel,portable,mel : string);
function etudiant_liste_tous : TLoadDataSet;
function etudiant_liste_etud (numero,nom : string) : TLoadDataSet;
function etudiant_liste_fil (code: string) : TLoadDataSet;
function etudiant_num (num:string) : TLoadDataSet;
function etudiant_filiere (num : string) : string;
function etudiant_comprend_tous(num : string) : TLoadDataSet;
function etudiant_moy_inscrit(num : string) : String;
function etudiant_moy_filiere(num : string) : String;
procedure close;
end;

var
modele: Tmodele;

implementation

procedure Tmodele.open;
begin
Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0, 'wurtz35u_ProjetIHM', 'wurtz35u_appli',
'31904442', 'mysqld-5', 'libmysql.dll');
end;
procedure Tmodele.close;
begin
Bd_close;
end;
// toutes les etudiants
function Tmodele.etudiant_liste_tous : TLoadDataSet;
begin
result := load('sp_etudiant_liste_tous',[]);
end;

function Tmodele.etudiant_liste_etud (numero,nom : string) : TLoadDataSet;
begin
result := load('sp_etudiant_liste_etud',[numero,nom]);
end;


function Tmodele.etudiant_liste_fil (code : string) : TLoadDataSet;
begin
result := load('sp_etudiant_liste_fil',[code]);
end;

function Tmodele.etudiant_num (num : string) : TLoadDataSet;
begin
 result := load('sp_etudiant_num',[num]);
end;
function Tmodele.etudiant_filiere (num : string) : string;
begin
 load('sp_etudiant_filiere',[num], result);
end;
function Tmodele.etudiant_comprend_tous ( num : string) : TLoadDataSet;
begin
result := load('sp_etudiant_note',[num]);
end;
function Tmodele.etudiant_moy_inscrit (num : string) : String;
begin
 load('sp_moy_inscrit',[num], result);
end;
function Tmodele.etudiant_moy_filiere (num : string) : String;
begin
 load('sp_moy_filiere',[num], result);
end;

procedure Tmodele.etudiant_delete (id : string);
begin
 exec('sp_etudiant_delete',[id]);
end;
procedure Tmodele.etudiant_insert (id,genre,nom,prenom,rue,cp,ville,tel,portable,mel : string ;code_filiere : integer);
begin
 exec('sp_etudiant_insert',[id,genre,nom,prenom,rue,cp,ville,tel,portable,mel,code_filiere]);
end;
procedure Tmodele.etudiant_update (id,genre,nom,prenom,rue,cp,ville,tel,portable,mel : string);
begin
 exec('sp_etudiant_update',[id],[genre,nom,prenom,rue,cp,ville,tel,portable,mel]);
end;
begin
modele := TModele.Create;
end.
end.

