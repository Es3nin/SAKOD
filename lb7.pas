type
  list = ^elem;
  elem = record
    id: longint;
    room: integer;
    floor: integer;
    square: integer;
    address: string;
  end;
  arr = array[1..20] of list;
  
procedure create(var A:arr);
var i,j:integer;temp:list;
begin
 for i:=1 to High(A) do
   begin
     new(temp);
     for j:=1 to 15 do temp^.address:='address';
     temp^.room:=1+random(30);
     temp^.floor:=random(17);
     temp^.id:=1231245+i;
     temp^.square:=8+random(200);
     A[i]:=temp;
   end;
end;

procedure linsearch(A:arr;key:longint);
var i:integer;
begin
for i:=1 to High(A) do
 begin
  if A[i]^.id=key then 
   begin 
     writeln('Найдено: ',A[i]^.id,' ',A[i]^.room,' ',A[i]^.floor,' ',A[i]^.square,' ',A[i]^.address); 
     exit;
   end;
 end;
 writeln('Ничего не найдено')
end;

var M:arr;
key:longint;
x:integer;
n:longint;

begin
create(M);
for x:=1 to high(M) do writeln(M[x]^.id,' ',M[x]^.room,' ',M[x]^.floor,' ',M[x]^.square,' ',M[x]^.address); 
Writeln('Введите id для поиска: ');
readln(n);
linsearch(M,n);

end.