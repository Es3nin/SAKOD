const
  max = 320;
  randmax: Longint = 1600;

type
  mas1 = array [0..10] of longint;
  mas = array [0..max] of longint;
  
procedure FillRand(var A: mas );
var
  i: Integer;
  t: LongInt;
begin
  for i := 1 to max do
  begin
    t := Random(3270);
    t := t * 3270;
    t := t + Random(3270);
    A[i] := t mod randmax;
  end;
end;

procedure pr(A: mas);
var
  i: integer;
begin
  for i := 1 to max do 
  begin
    write(A[i], ' ');
    // if i mod 64 = 0 then write('####');
  end;
end;
procedure pr1(A: mas1);
var
  i: integer;
begin
  for i := 1 to High(A) do 
  begin
    write(A[i], ' ');
    // if i mod 64 = 0 then write('####');
  end;
end;

procedure swap(var A: mas; m, n: integer);
var
  temp: integer;
begin
  //writeln(A[m],'--',A[n]);
  temp := A[m];
  A[m] := A[n];
  A[n] := temp;
end;
procedure swap1(var A: mas1; m, n: integer);
var
  temp: integer;
begin
  //writeln(A[m],'--',A[n]);
  temp := A[m];
  A[m] := A[n];
  A[n] := temp;
end;

procedure SelectSort(var A: mas1 );
var
  i, j: Integer;
  x: integer;
begin
  i := high(A);
  while i > 1 do
  begin
    x := 1;
    for j := 1 to i do
    begin
      if A[j] > A[x] then x := j;
    end;
    swap1(A, i, x);
    i -= 1;
  end;
end;

procedure SelectSort2(var A: mas; left, right: integer );
var
  i, j: Integer;
  x: integer;
begin
  i := right;
  while i > 1 + left do
  begin
    x := i;
    for j := 1 + left to i do
    begin
      if A[j] > A[x] then x := j;
    end;
    swap(A, i, x);
    i -= 1;
  end;
end;

procedure quicksort(var a: mas; l, r: integer);
var
  i, j, x, y: integer;
begin
  i := l; 
  j := r;
  x := a[l + random(r - l + 1)];
  repeat
    while a[i] < x do i := i + 1;
    while a[j] > x do j := j - 1;
    if i <= j then
    begin
      swap(a, i, j);
      i := i + 1;j := j - 1;
    end;
  until i >= j;
  if l < j then quicksort(a, l, j);
  if i < r then quicksort(a, i, r);
end;

var
  i, j, t: integer;
  M: mas;
  M1:mas1;

begin
  
  { 
   M1[1]:=9;M1[2]:=2;M1[3]:=6;M1[4]:=7;M1[5]:=10;
   M1[6]:=5;M1[7]:=4;M1[8]:=3;M1[9]:=1;M1[10]:=8;
  pr1(M1);
  SelectSort(M1);
  writeln('|');
  pr1(M1);
  }
  
  {Первое выше, ниже второе}
  
  
  FillRand(M);
  for i := 1 to (max div 64) do
  begin
    SelectSort2(M, (i - 1) * 64, i * 64);
  end;
  quicksort(M, 1, High(M));
  pr(M);writeln();writeln();
  
end.