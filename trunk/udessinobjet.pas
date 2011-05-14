unit UDessinObjet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, UForme, FPImage, intfGraphics, LCLType;

type

  { TForm2 }

  TForm2 = class(TForm)
    ButRecommencer: TButton;
    ButValider: TButton;
    ButAnnuler: TButton;
    Img: TImage;
    PanelButtons: TPanel;
    procedure ButAnnulerClick(Sender: TObject);
    procedure ButRecommencerClick(Sender: TObject);
    procedure ButValiderClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    procedure RemplissageParLigne(aXSeed,aYSeed,aOldColor,aNewColor: integer);
  end;

var
  Form2: TForm2;
  DessinEnCours, RemplissageEnCours : boolean;
  Solide: CForme;
  X0, Y0: integer;
  FormeBMP: TBitmap;

implementation

{ TForm2 }

procedure TForm2.ButAnnulerClick(Sender: TObject);
begin
    Form2.Close();
end;

procedure TForm2.ButRecommencerClick(Sender: TObject);
var i,j: integer;
begin
    Img.Canvas.Clear();
end;

procedure TForm2.ButValiderClick(Sender: TObject);
var i,j: integer;
begin
    //// Creation de la forme
    //Solide := CForme.Create(Img.Width, Img.Height);
    //// Remplissage de la forme
    //for i:=0 to Solide.getWidth()-1 do
    //    for j:=0 to Solide.getHeight()-1 do
    //        if ((Img.Canvas.Pixels[i,j] = clBlack) or (Img.Canvas.Pixels[i,j] = clGray))
    //        then Solide.setBoolean(i,j,true)
    //        else Solide.setBoolean(i,j,false);

    // Copie du Bitmap
    FormeBMP := Img.Picture.Bitmap;
    Form2.Close();
end;

procedure TForm2.FormShow(Sender: TObject);
begin
    // Initialisation des variables booleenes
    RemplissageEnCours := false;
    DessinEnCours := false;
    // Initialisation du canevas
    Img.Canvas.Clear();
    Img.Canvas.Clear();   // Ce n'est pas une erreur, une seule instruction n'est pas suffisante
end;

procedure TForm2.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var oldColor: integer;
begin
    if RemplissageEnCours = false
    then begin
        DessinEnCours := true;
        Img.Canvas.Pen.Color:=clBlack;
        Img.Canvas.Pen.Width:=2;
        if ((X<Img.Width) and (Y<Img.Height) and (X>0) and (Y>0))
            then begin
                X0 := X;
                Y0 := Y;
                Img.Canvas.MoveTo(X,Y);
                Img.Canvas.Pixels[X,Y] := clBlack;
            end;
        end
    else begin
        if ((X<Img.Width) and (Y<Img.Height) and (X>0) and (Y>0))
        then begin
            oldColor := Img.Canvas.Pixels[X,Y];
            RemplissageParLigne(X,Y,oldColor,clGray);
            RemplissageEnCours := false;
        end;
    end;

end;

procedure TForm2.RemplissageParLigne(aXSeed,aYSeed,aOldColor,aNewColor: integer);
// Cette procedure permet de transformer un ensemble connexe de couleur aOldColor
// en un nouvel ensemble connexe de couleur aNewColor
// Adaptee d'une procedure en C sur le Scanline Flood Fill:
// http://www.academictutorials.com/graphics/graphics-flood-fill.asp
var Y: integer;
begin
    // On verifie que l'on appelle pas la procedure pour rien
    if (aOldColor = aNewColor) then Exit;
    // On verifie que le pixel graine est de la couleur qui doit changer
    if (Img.Canvas.Pixels[aXSeed,aYSeed] <> aOldColor) then Exit;

    // Dessin du segment vertical au dessus du pixel graine (inclus)
    Y := aYSeed;
    while ((Y<Img.Height) and (Img.Canvas.Pixels[aXSeed,Y] = aOldColor)) do
        begin
        Img.Canvas.Pixels[aXSeed,Y] := aNewColor;
        Y := Y+1;
        end;

    // Dessin du segment vertical en dessous du pixel graine (non inclus)
    Y := aYSeed-1;
    while ((Y>=0) and (Img.Canvas.Pixels[aXSeed,Y] = aOldColor)) do
        begin
        Img.Canvas.Pixels[aXSeed,Y] := aNewColor;
        Y := Y-1;
        end;

    // Recherche de potentiels segments a gauche et recursivite
    Y := aYSeed;
    while ((Y<Img.Height) and (Img.Canvas.Pixels[aXSeed,Y] = aNewColor)) do
        begin
        if ((aXSeed>0) and (Img.Canvas.Pixels[aXSeed-1,Y] = aOldColor))
            then RemplissageParLigne(aXSeed-1, Y, aOldColor, aNewColor);
        Y := Y+1;
        end;
    Y := aYSeed-1;
    while ((Y>=0) and (Img.Canvas.Pixels[aXSeed,Y] = aNewColor)) do
        begin
        if ((aXSeed>0) and (Img.Canvas.Pixels[aXSeed-1,Y] = aOldColor))
            then RemplissageParLigne(aXSeed-1, Y, aOldColor, aNewColor);
        Y := Y-1;
        end;

    // Recherche de potentiels segments a droite et recursivite
    Y := aYSeed;
    while ((Y<Img.Height) and (Img.Canvas.Pixels[aXSeed,Y] = aNewColor)) do
        begin
        if ((aXSeed<Img.Width-1) and (Img.Canvas.Pixels[aXSeed+1,Y] = aOldColor))
            then RemplissageParLigne(aXSeed+1, Y, aOldColor, aNewColor);
        Y := Y+1;
        end;
    Y := aYSeed-1;
    while ((Y>=0) and (Img.Canvas.Pixels[aXSeed,Y] = aNewColor)) do
        begin
        if ((aXSeed<Img.Width-1) and (Img.Canvas.Pixels[aXSeed+1,Y] = aOldColor))
            then RemplissageParLigne(aXSeed+1, Y, aOldColor, aNewColor);
        Y := Y-1;
        end;
end;

procedure TForm2.ImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    if ((DessinEnCours= true) and (X<Img.Width) and (Y<Img.Height) and (X>0) and (Y>0)) then
    begin
        Img.Canvas.Pen.Color:=clBlack;
        Img.Canvas.Pen.Width:=2;
        Img.Canvas.LineTo(x,y);
    end;

end;

procedure TForm2.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if (DessinEnCours = true)
    then begin
        Img.Canvas.Pen.Color := clBlack;
        Img.Canvas.Pen.Width := 2;
        Img.Canvas.LineTo(X0,Y0);
        DessinEnCours := false;
        RemplissageEnCours := true;
    end;
end;

initialization
  {$I udessinobjet.lrs}

end.

