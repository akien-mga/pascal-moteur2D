// Simulateur de mouvement : projet Lazarus d'etudiants de l'INSA de Lyon
// Copyright (C) 2011  V. Cleren, T. Garcia-Guitton, T. Pourcelot, R. Verschelde
// Contact : remi.verschelde@insa-lyon.fr
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

program moteur2d;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UFaceAvant, LResources, UDessinObjet, UForme, UDessinDecor, 
UPosition, UPositionSolide, UResultante, USolideMouvement, UTorseur, UVitesse, 
UArchimede, UFrottement, UPoids;

{$IFDEF WINDOWS}{$R moteur2d.rc}{$ENDIF}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.

