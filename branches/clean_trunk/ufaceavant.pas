unit UFaceAvant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, UDessinObjet, UDessinDecor, UParamPhys;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButDessinObjet: TButton;
    ButDessinDecor: TButton;
    ButParamPhys: TButton;
    ButLancerSim: TButton;
    ButQuitter: TButton;
    Image1: TImage;
    Timer1: TTimer;
    procedure ButDessinDecorClick(Sender: TObject);
    procedure ButDessinObjetClick(Sender: TObject);
    procedure ButLancerSimClick(Sender: TObject);
    procedure ButParamPhysClick(Sender: TObject);
    procedure ButQuitterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  SimulationEnCours : boolean;

implementation

{ TForm1 }

procedure TForm1.ButDessinObjetClick(Sender: TObject);
begin
    Form2.Show;
end;

procedure TForm1.ButLancerSimClick(Sender: TObject);
begin
     SimulationEnCours := true;
end;

procedure TForm1.ButParamPhysClick(Sender: TObject);
begin
    Form4.Show;
end;

procedure TForm1.ButQuitterClick(Sender: TObject);
begin
     FormeLII.Free;
     FormeBMP.Free;
     Close();
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  SimulationEnCours := false;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (SimulationEnCours) then
  begin
    FormeBMP.Transparent := True;
    FormeBMP.TransparentColor := clWhite;
    Image1.canvas.Draw(0,0,DecorBMP);
    Image1.canvas.Draw(100,100,FormeBMP);
  end;
end;

procedure TForm1.ButDessinDecorClick(Sender: TObject);
begin
    Form3.Show;
end;

initialization
  {$I ufaceavant.lrs}

end.
