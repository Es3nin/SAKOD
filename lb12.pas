uses crt;

type
  stack = string;{тип данных, который будет храниться в элементе стека}
  List1 = ^TList1;{Указатель на элемент типа TList}
  TList1 = record {А это наименование нашего типа "запись" обычно динамические структуры описываются через запись}
    str: string;  {данные, хранимые в элементе}
    next: List1;   {указатель на следующий элемент}
  end;
  
procedure enqueue(var stek1,stek2: List1; name: string);//добавляем стоку
var
  p: List1;
begin
  if stek1 = nil then 
  begin
    new(p);
    p^.next := nil;  
    p^.str:= name;
    stek1 := p;
    stek2:=p;
  end else begin
    new(p); 
    p^.next := nil;  
    p^.str:= name;   
    stek2^.next := p; 
    stek2:=p;
end;
end;

procedure dequeue(var stek1:List1);
var temp:list1;
begin
temp:=stek1;
stek1:=stek1^.next;
temp^.next:=nil;
dispose(temp);
end;

procedure print(stek: list1);
begin
  while stek <> nil do 
  begin
    write(stek^.str, ' | ');stek := stek^.next;
  end;
  writeln();
end;

function sum(stek:list1):integer;
begin
while stek <> nil do begin  sum+=Length(stek^.str);stek:=stek^.next;end;
end;

var
  x: integer;
  head,tail: List1;
  
begin
enqueue(head,tail,'one');
enqueue(head,tail,'two');
enqueue(head,tail,'three');
enqueue(head,tail,'four');
print(head);
dequeue(head);
enqueue(head,tail,'five');
print(head);
writeln();
writeln('Сумма длин= ',sum(head));
end.