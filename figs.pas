UNIT figs;
INTERFACE
  uses project,windows,extctrls,graphics;
  const
    MaxCells     = 3;
    CubeSize     = 500;
    DefaultCells = 3;
    Colors:array[1..6]of TColor=(clRed,clGreen,clBlue,clMaroon,clLime,clAqua);

    RotAngle     = 10;
    MoveStep     = 25;
  type
    TRubic = class
               private
                 fCells:integer;
                 procedure setCells(c:integer);
               public
                 planes:array[1..6,1..MaxCells,1..MaxCells]of integer;
                 coords:array[1..6,0..MaxCells,0..MaxCells]of T3Point;
                 points:array[1..6,0..MaxCells,0..MaxCells]of T2Point;

                 constructor create;
                 destructor destroy;override;
                 procedure draw(pb:TPaintBox);
                 procedure project;

                 property cells:integer read fCells write setCells;
             end;
IMPLEMENTATION
  constructor TRubic.create;
  var p,x,y:integer;
  begin
   inherited create;
   for p:=1 to 6 do
    for x:=1 to MaxCells do
     for y:=1 to MaxCells do
      planes[p,x,y]:=p;
   fCells:=0;
   cells:=DefaultCells;
  end;

  destructor TRubic.destroy;
  begin
   inherited destroy;
  end;


  procedure TRubic.setCells(c:integer);
  var matr:array[0..MaxCells,0..MaxCells,0..MaxCells]of T3Point;
      a,x,y,z,cs:integer;
  begin
   if(c=cells)then exit; fCells:=c;
   cs:=2*CubeSize div cells;
   ap(matr[0,0,0],-CubeSize,-CubeSize,-CubeSize);
   {base lines}
   for a:=1 to cells do
    begin
     ap(matr[a,0,0],matr[a-1,0,0].x+cs,matr[a-1,0,0].y   ,matr[a-1,0,0].z   );
     ap(matr[0,a,0],matr[0,a-1,0].x   ,matr[0,a-1,0].y+cs,matr[0,a-1,0].z   );
     ap(matr[0,0,a],matr[0,0,a-1].x   ,matr[0,0,a-1].y   ,matr[0,0,a-1].z+cs);
    end;
   {base planes}
   for x:=1 to cells do
    for y:=1 to cells do
     begin
      ap(matr[0,x,y],matr[0,x-1,y-1].x   ,matr[0,x-1,y-1].y+cs,matr[0,x-1,y-1].z+cs);
      ap(matr[x,0,y],matr[x-1,0,y-1].x+cs,matr[x-1,0,y-1].y   ,matr[x-1,0,y-1].z+cs);
      ap(matr[x,y,0],matr[x-1,y-1,0].x+cs,matr[x-1,y-1,0].y+cs,matr[x-1,y-1,0].z   );
     end;
   {other points}
   for x:=1 to cells do
    for y:=1 to cells do
     for z:=1 to cells do
      ap(matr[x,y,z],matr[x-1,y-1,z-1].x+cs,matr[x-1,y-1,z-1].y+cs,matr[x-1,y-1,z-1].z+cs);
   {and the target planes}
   for x:=0 to cells do
    for y:=0 to cells do
     begin
      coords[1,x,y]:=matr[cells,x,y];
      coords[2,x,y]:=matr[x,cells,y];
      coords[3,x,y]:=matr[x,y,cells];
      coords[4,x,y]:=matr[0,x,y];
      coords[5,x,y]:=matr[x,0,y];
      coords[6,x,y]:=matr[x,y,0];
     end;
  end;

  procedure TRubic.draw(pb:TPaintBox);
  var vis:array[1..6]of boolean;
      p,x,y:integer;
      r:array[1..4]of TPoint;
  begin
   C.x:=pb.width div 2; C.y:=pb.height div 2;
   project;
   vis[1]:=U.x>CubeSize; vis[1+3]:=U.x<-CubeSize;
   vis[2]:=U.y>CubeSize; vis[2+3]:=U.y<-CubeSize;
   vis[3]:=U.z>CubeSize; vis[3+3]:=U.z<-CubeSize;
   for p:=1 to 6 do
    if(vis[p])then
     for x:=1 to cells do
      for y:=1 to cells do
       begin
        pb.canvas.brush.color:=Colors[planes[p,x,y]];
        r[1].x:=points[p,x-1,y-1].x; r[1].y:=points[p,x-1,y-1].y;
        r[2].x:=points[p,x  ,y-1].x; r[2].y:=points[p,x  ,y-1].y;
        r[3].x:=points[p,x  ,y  ].x; r[3].y:=points[p,x  ,y  ].y;
        r[4].x:=points[p,x-1,y  ].x; r[4].y:=points[p,x-1,y  ].y;
        pb.canvas.polygon(r);
       end;
  end;

  procedure TRubic.project;
  var p,x,y:integer;
  begin
   for p:=1 to 6 do
    for x:=0 to cells do
     for y:=0 to cells do
      pp(coords[p,x,y],points[p,x,y]);
  end;
END.
