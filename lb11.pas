uses crt;

type
  stack = string;{тип данных, который будет храниться в элементе стека}
  List1 = ^TList1;{Указатель на элемент типа TList}
  TList1 = record {А это наименование нашего типа "запись" обычно динамические структуры описываются через запись}
    name: string;  {данные, хранимые в элементе}
    height: integer;  {данные, хранимые в элементе}
    next: List1;   {указатель на следующий элемент}
  end;

procedure Push(var stek: List1; name: string; height: integer);//zapolnyaem stek
var
  p: List1;
begin
  if stek = nil then 
  begin
    new(p);
    p^.next := nil;  
    p^.name := name;   
    p^.height := height; 
    stek := p;
  end else begin
    new(p); 
    p^.next := stek;  
    p^.name := name;   
    p^.height := height; 
    stek := p; 
  end;
end;

procedure print(stek: list1);
begin
  while stek <> nil do 
  begin
    write(stek^.name, ' ', stek^.height, ' |');stek := stek^.next;
  end;
  writeln();
end;

procedure midvalue(stek: list1);
var
  val: integer;count: integer;
begin
  while stek <> nil do
  begin
    val += stek^.height;count += 1;stek := stek^.next;
  end;
  writeln('Средняя высота= ', val / count)
end;

var
  x: integer;
  S: List1;
  str: string;
  int: integer;

begin
  while x <> 4 do
  begin
    writeln('1-добавить гору 2-вывод 3-средняя высота 4-выход');
    readln(x);
    if x = 1 then 
    begin
      writeln('Имя: ');readln(str);
      writeln('Высота: ');readln(int);
      Push(S, str, int);
    end
    else if x = 2 then print(S)
    else if x = 3 then midvalue(S)
    else exit;
    
  end;
end.