UNIT project;
INTERFACE
  type
    T3Point= record
               x,y,z:extended;
             end;
    T2Point= record
               x,y:longint;
             end;
    TAxis  = (axisX,axisY,axisZ);
  var U,D,V,H, _D,_V:T3Point;
      C:T2Point;
      lenD,lenD2:extended;
  procedure ap(var p:T3Point;x,y,z:extended);                                 {Assign Point}
  function lp(p3:T3Point):extended;                                           {Length Point}
  function pp(p3:T3Point;var p2:T2Point):boolean;                             {Project Point}
  function rp(p3:T3Point; axis:TAxis; angle:extended; var p:T3Point):boolean; {Rotate Point}
  function cp(p3:T3Point; nl:extended; var p:T3Point):boolean;                {Change Point length}
  procedure setUser(Ux,Uy,Uz:extended);
  procedure setDist(Dx,Dy,Dz,l:extended);
  procedure setVert(Vx,Vy,Vz:extended);
  procedure setView(Ux,Uy,Uz , Dx,Dy,Dz,l , Vx,Vy,Vz:extended);
IMPLEMENTATION
  procedure ap(var p:T3Point;x,y,z:extended);
  begin p.x:=x; p.y:=y; p.z:=z end;
  function lp(p3:T3Point):extended;
  begin result:=sqrt(sqr(p3.x)+sqr(p3.y)+sqr(p3.z)) end;

  function pp(p3:T3Point;var p2:T2Point):boolean;
  var UP,KP:T3Point;
      prUPud:extended;
  begin
   ap(UP,p3.x-U.x,p3.y-U.y,p3.z-U.z);
   prUPud:=(UP.x*D.x+UP.y*D.y+UP.z*D.z)/lenD2;
   {result:=((prUPuo_*lenD/sqrt(UP.x*UP.x+UP.y*UP.y+UP.z*UP.z)) > cos(pi/2));}
   ap(KP,p3.x-(U.x+D.x*prUPud),p3.y-(U.y+D.y*prUPud),p3.z-(U.z+D.z*prUPud));
   p2.x:=C.x+round((KP.x*H.x+KP.y*H.y+KP.z*H.z)/lp(H)/prUPud);
   p2.y:=C.y-round((KP.x*V.x+KP.y*V.y+KP.z*V.z)/lp(V)/prUPud);
   result:=true;
  end;

  function rp(p3:T3Point; axis:TAxis; angle:extended; var p:T3Point):boolean;
  var sa,ca:extended;
  begin
   result:=true; sa:=sin(angle*pi/180); ca:=cos(angle*pi/180);
   case(axis)of
    axisX:begin
           p.x:=p3.x;
           p.y:=p3.y*ca-p3.z*sa;
           p.z:=p3.y*sa+p3.z*ca;
          end;
    axisY:begin
           p.x:=p3.x*ca-p3.z*sa;
           p.y:=p3.y;
           p.z:=p3.x*sa+p3.z*ca;
          end;
    axisZ:begin
           p.x:=p3.x*ca-p3.y*sa;
           p.y:=p3.x*sa+p3.y*ca;
           p.z:=p3.z;
          end;
   end;
  end;

  function cp(p3:T3Point; nl:extended; var p:T3Point):boolean;
  var l:extended;
  begin
   result:=true;
   l:=lp(p3);
   ap(p,p3.x*nl/l,p3.y*nl/l,p3.z*nl/l);
  end;


  procedure setUser(Ux,Uy,Uz:extended);
  begin setView(Ux,Uy,Uz , _D.x,_D.y,_D.z,lenD , _V.x,_V.y,_V.z) end;
  procedure setDist(Dx,Dy,Dz,l:extended);
  begin setView(U.x,U.y,U.z , Dx,Dy,Dz,l , _V.x,_V.y,_V.z) end;
  procedure setVert(Vx,Vy,Vz:extended);
  begin setView(U.x,U.y,U.z , _D.x,_D.y,_D.z,lenD , Vx,Vy,Vz) end;

  procedure setView(Ux,Uy,Uz , Dx,Dy,Dz,l , Vx,Vy,Vz:extended);
  var koef:extended;
  begin
   ap(_D,Dx,Dy,Dz); ap(_V,Vx,Vy,Vz);
   ap(U,   Ux,   Uy,   Uz);
   ap(D,Dx-Ux,Dy-Uy,Dz-Uz);
   ap(V,Vx-Ux,Vy-Uy,Vz-Uz);

   lenD2:=D.x*D.x+D.y*D.y+D.z*D.z; {setting length}
   lenD:=sqrt(lenD2);
   cp(D,l,D);
   lenD:=l;
   lenD2:=lenD*lenD;

   koef:=(V.x*D.x+V.y*D.y+V.z*D.z)/lenD2; {ortaganalizing}
   ap(V,V.x-koef*D.x,V.y-koef*D.y,V.z-koef*D.z);
   cp(V,l,V);

   ap(H,D.y*V.z-D.z*V.y , D.z*V.x-D.x*V.z , D.x*V.y-D.y*V.x);
   cp(H,l,H);
  end;
INITIALIZATION
  setView(650,650,650 , 0,0,0,100 , 0,0,1000);
END.
