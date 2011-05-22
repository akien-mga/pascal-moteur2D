unit USolideMouvement;

//***********************************************//
//       Unite gerant le mouvement du solide     //
//                                               //
//    TODO : implementation CalculPosition       //
//***********************************************//
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UResultante, UPositionSolide, UPosition, UVitesse, UForme;

Type CSolideMouvement = Class

     Protected
            fResultante : CResultante;
            fPositionSolide : CPositionSolide ;
            fVitesse : CVitesse ;
            fForme : CForme ;
     Public
     		Constructor Create(aResultante : CResultante;
     		                   aPosition   : CPositionSolide;
     				   aVitesse    : Cvitesse;
     				   aForme      : CForme);

     		Destructor Destroy;override;

     		//Accessors
     		Function GetResultante()     : CResultante;
     		Function GetPositionSolide() : CPositionSolide;
     		Function GetVitesse()	     : CVitesse;
     		Function GetForme()	     : CForme;

     		Procedure SetResultante(aResultante : CResultante);
     		Procedure SetPosition(  aPosition   : CPositionSolide);
     		Procedure SetVitesse(	aVitesse    : CVitesse);
     		Procedure SetForme(	aForme	    : CForme);

     		//Others Functions
     		Procedure CalculPosition();
     end;

implementation

Constructor CSolideMouvement.Create(aResultante : CResultante;
				    aPosition	: CpositionSolide;
				    aVitesse	: CVitesse;
				    aForme	: CForme );
	Begin
		SetResultante(aResultante);
		SetPosition(aPosition);
		SetVitesse(aVitesse);
		SetForme(aForme);
	End;

Destructor CSolideMouvement.Destroy;
	Begin
		fResultante.Destroy;
		fPositionSolide.Destroy;
		fVitesse.Destroy;
		fForme.Destroy;
	End;

Function CSolideMouvement.GetResultante() : CResultante;
	Begin
		GetResultante := fResultante;
	End;

Function CSolideMouvement.GetPositionSolide() : CPositionSolide;
	Begin
		GetPositionSolide := fPositionSolide;
	End;

Function CSolideMouvement.GetVitesse() : CVitesse;
	Begin
		GetVitesse := fVitesse;
	End;

Function CSolideMouvement.GetForme():CForme;
	Begin
		GetForme := fForme;
	End;

Procedure CSolideMouvement.SetResultante(aResultante : CResultante);
	Begin
		fResultante := aResultante;
	End;

Procedure CSolideMouvement.SetPosition(aPosition : CPositionSolide);
	Begin
		fPositionSolide := aPosition;
	End;

Procedure CSolideMouvement.SetVitesse(aVitesse : CVitesse);
	Begin
		fVitesse := aVitesse;
	End;

Procedure CSolideMouvement.SetForme(aForme : CForme);
	Begin
		fForme := aForme;
	End;



Procedure CSolideMouvement.CalculPosition();
        Var dt: real;
	Begin
            dt := 0.01;  // dt est l'intervalle de temps du timer, ici 10ms
            fVitesse.SetX(fVitesse.GetX() + fPositionSolide.metreToPixel(fResultante.GetFx()*dt/fForme.GetMasse()));
            fVitesse.SetY(fVitesse.GetY() + fPositionSolide.metreToPixel(fResultante.GetFy()*dt/fForme.GetMasse()));
            fVitesse.SetOmega(fVitesse.GetOmega() + fResultante.GetMz()*dt/fForme.GetMasse());
            fPositionSolide.SetXMetre(fPositionSolide.GetXMetre() + fPositionSolide.pixelToMetre(round(fVitesse.GetX()*dt)));
            fPositionSolide.SetYMetre(fPositionSolide.GetYMetre() + fPositionSolide.pixelToMetre(round(fVitesse.GetY()*dt)));
            fPositionSolide.SetAngle(fPositionSolide.GetAngle() + fVitesse.GetOmega()*dt);
            if (fPositionSolide.GetAngle()>360) then fPositionSolide.SetAngle(fPositionSolide.GetAngle()-360);

	End;


End.
