unit UForme;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, UPosition;

Type CForme = Class
     Protected
              fBMP : TBitmap;
              fCentreInertie : CPosition;
              fMasse : real;

     Public
           Constructor Create(aWidth, aHeight : integer);
           Destructor Destroy; override;
           Procedure calculCentreInertie();
           Function getCentreInertie() : CPosition;
           Procedure setBMP(aBMP: TBitmap);
           Function getBMP() : TBitmap;
           Procedure setMasse(aMasse: Real);
           Function getMasse() : real;


     end;

implementation

Constructor CForme.Create(aWidth, aHeight : integer);
// Cree la classe et son Bitmap avec hauteur et largeur.
Begin
     fBMP := TBitmap.Create;
     fBMP.Width := aWidth;
     fBMP.Height := aHeight;
     fBMP.Canvas.Clear();
     fCentreInertie := CPosition.Create(0, 0);
End;

Destructor CForme.Destroy;
Begin
    fBMP.Free;
    fCentreInertie.Free;
    Inherited;
end;

Procedure CForme.CalculCentreInertie();
Var i,j,nbPixels,sumX,sumY: integer;
Begin
    nbPixels := 0;
    sumX := 0;
    sumY := 0;
    // Calcul typique de barycentre, X = somme des Xi / nbPixels
    for i:=0 to fBMP.Width-1 do
        for j:=0 to fBMP.Height-1 do
            if ((fBMP.Canvas.Pixels[i,j] = clBlack) or (fBMP.Canvas.Pixels[i,j] = clGray))
            then begin
                sumX := sumX + i;
                sumY := sumY + j;
                nbPixels := nbPixels + 1;
            end;
    if nbPixels <> 0
    then begin
        fCentreInertie.setXPixel(round(sumX/nbPixels));
        fCentreInertie.setYPixel(round(sumY/nbPixels));
    end;
End;

Function CForme.getCentreInertie() : CPosition;
Begin
    result := fCentreInertie;
end;

Function CForme.getMasse() : real;
Begin
     result := fMasse;
end;

Procedure CForme.setMasse(aMasse: real);
Begin
     fMasse := aMasse;
end;

Function CForme.getBMP() : TBitmap;
begin
    result := fBMP;
end;

Procedure CForme.setBMP(aBMP: TBitmap);
begin
    fBMP := aBMP;
end;

end.

