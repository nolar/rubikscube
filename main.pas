unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, project, figs;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    r:TRubic;
    lmb,mmb,rmb:boolean;
    lxm,lym:integer;
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 r:=TRubic.create;
 lmb:=false; mmb:=false; rmb:=false;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
 r.draw(PaintBox1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 r.free;
end;




procedure TForm1.SpeedButton3Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisX,+RotAngle,U2);
 rp(V,axisX,+RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisX,-RotAngle,U2);
 rp(V,axisX,-RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisY,+RotAngle,U2);
 rp(V,axisY,+RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisY,-RotAngle,U2);
 rp(V,axisY,-RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisZ,+RotAngle,U2);
 rp(V,axisZ,+RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
var U2,V2:T3Point;
begin
 rp(U,axisZ,-RotAngle,U2);
 rp(V,axisZ,-RotAngle,V2);
 setUser(U2.x,U2.y,U2.z);
 setVert(V2.x,V2.y,V2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var U2:T3Point;
begin
 cp(U,lp(U)-MoveStep,U2);
 setUser(U2.x,U2.y,U2.z);
 paintbox1.invalidate;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var U2:T3Point;
begin
 cp(U,lp(U)+MoveStep,U2);
 setUser(U2.x,U2.y,U2.z);
 paintbox1.invalidate;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 case button of
  mbLeft:lmb:=true;
  mbRight:rmb:=true;
  mbMiddle:mmb:=true;
 end;
 lxm:=x; lym:=y;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 case button of
  mbLeft:lmb:=false;
  mbRight:rmb:=false;
  mbMiddle:mmb:=false;
 end;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var pb:TPaintBox;
    dx,dy,l:extended;
begin
 pb:=TPaintBox(sender);
 dx:=(x-lxm)/pb.width*50; dy:=(y-lym)/pb.height*50;
 if(lmb)then
  begin
   l:=lp(U);
   ap(U,U.x+V.x*dy-H.x*dx,U.y+V.y*dy-H.y*dx,U.z+V.z*dy-H.z*dx);
   cp(U,l,U);
   setUser(U.x,U.y,U.z);
   pb.invalidate;
  end;
 if(rmb)then
  begin
   cp(U,lp(U)+MoveStep*dy,U);
   setUser(U.x,U.y,U.z);
   pb.invalidate;
  end;
 lxm:=x; lym:=y;
end;

end.
