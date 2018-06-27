uses crt;

type
  list = ^elem;
  elem = record
    key: byte;
    next: list;
  end;

var
  p, q, head1, tail1, head2, tail2, head3, tail3: list;
  x, y, z, zna4: integer;

procedure ListInit(var head, tail: list);
begin
  if (head = nil) then begin
    new(head);
    new(tail);
    head^.next := tail;
    head^.key := 0;
    tail^.next := nil;
    tail^.key := 0;
    writeln('Список создан!');
  end
  else writeln('Список уже создан!');
end;

procedure ListUpload(var head, tail: list; j: integer);
var
  i: integer;
begin
  if (head <> nil) then begin
    for i := 1 to j do 
    begin
      if head^.key = 0 then begin
        head^.key := random(100, 200);
        continue;
      end;
      if tail^.key = 0 then begin
        tail^.key := random(100, 200);
        continue;
      end;
      new(p);
      tail^.next := p;
      p^.key := random(100, 200);
      p^.next := nil;
      tail := p;
    end;
    writeln('Внесено ', j, ' элементов!');
  end
  else begin
    ListInit(head, tail);
    ListUpload(head, tail, j);
    exit;
  end;
end;

procedure printer(head, tail: list);//печать от начала к концу
begin
  if (head <> nil) and (tail <> nil) and (head^.next <> tail) then begin
    p := head;
    while p <> tail^.next do
    begin
      write(p^.key, ' ');
      p := p^.next;
    end;
    writeln();
  end
  else writeln('Список пуст!');
end;

function range(head, tail: list): integer;//определение длины списка
var
  i: integer;
begin
  p := head;
  i := 1;
  if p <> nil then begin
    while p <> tail do 
    begin
      i := i + 1;
      p := p^.next;
    end;
    range := i;
  end else range := 0;
end;

procedure push2(x: integer; j: integer; var head, tail: list);
var
  i, y: integer;
begin
  if head <> nil then begin
    y := range(head, tail);
    if j > y then begin
      writeln('i-тый элемент не существует');exit; end;
    if j <= y then begin
      if j = 1 then begin
        new(p);
        p^.key := x;
        p^.next := head;
        head := p;
        exit;
      end else 
        q := head;
      for i := 1 to j - 2 do q := q^.next;
      new(p);
      p^.next := q^.next;
      q^.next := p;
      p^.key := x;
    end;
  end
  else writeln('Список не существует!');
end;

procedure del2(j: integer; var head, tail: list);
var
  i, y: integer;
begin
  if head <> nil then begin
    y := range(head, tail);
    if j > y then begin
      writeln('i-тый элемент не существует');exit; end;
    if j = y then begin
      p := head;
      while p^.next^.next <> tail do p := p^.next;
      q := p^.next;
      p^.next := q^.next;
      dispose(q);
    end;  
    if j < y then begin
      q := head;
      for i := 1 to j - 3 do q := q^.next;
      p := q^.next;
      q^.next := p^.next;
      dispose(p);
    end;
  end else writeln('Список не существует!');
end;

procedure divide(var head1, tail1, head2, tail2, head3, tail3: list);//разбиение списка
var
  i, x: integer;
begin
  if (head1 <> nil) then begin
    x := range(head1, tail1);
    q := head1;
    if (head1^.next <> tail1) then begin
      head2 := head1;
      for i := 1 to x div 2 do q := q^.next;
      tail2 := q;
      head3 := q^.next;
      tail2^.next := nil; 
      tail3 := tail1;
      head1 := nil;
      tail1 := nil; 
      ListInit(head1, tail1);
    end
    else writeln('Список пуст!');
  end else writeln('Список не существует!');
end;

procedure integrate(var head1, tail1, head2, tail2, head3, tail3: list);//слияние списков
begin
  if (head2 <> nil) or (head3 <> nil) then begin
    head1 := head2;
    tail1 := tail2;
    tail1^.next := head3;
    tail1 := tail3;
  end
  else writeln('Список не существует!');
end;

procedure copy(var head1, tail1, head2, tail2: list);
var
  z: list;
begin
  if (head1 <> nil) and (head1^.next <> tail1) then begin
    q := head1;
    new(head2);
    new(tail2);
    head2^.next := tail2;
    tail2^.key := 0;
    p := head2;
    while q <> tail1^.next do 
    begin
      if tail2^.key = 0 then begin
        tail2^.key := q^.key;
        q := q^.next;
      end
      else begin
        new(z);
        z^.key := q^.key;
        tail2^.next := z;
        tail2 := z;
        q := q^.next;
      end;
    end;  
    head2 := head2^.next;
    tail2^.next := nil;
  end else writeln('Список пуст или не существует!')
end;

procedure check(head1, tail1, head2, tail2: list);//проверка на равенство
begin
  p := head1;
  q := head2;
  if (head1 <> nil) and (head1^.next <> tail1) or (head2 <> nil) and (head2^.next <> tail2) then begin
    while (p <> tail1) or (q <> tail2) do
    begin
      if p^.key = q^.key then
      begin
        p := p^.next;
        q := q^.next;
      end
      else begin
        writeln('Списки не равны!');exit;
      end;
    end;
    writeln('Списки равны!');
  end
  else writeln('Список не существует');
end;

procedure delall(var head, tail: list);//удаление всех элементов списка
begin
  if (head <> nil) and (head^.next <> tail) then begin
    while head^.next <> tail do
    begin
      p := head^.next;
      if p <> nil then
      begin
        head^.next := p^.next;
        dispose(p);
      end;
    end;
    dispose(head);
    dispose(tail);
    tail := nil;
    head := nil;
    writeln('Все элементы списка удалены!');
  end
  else writeln('Список не существует!');
end;

procedure indiv1(head, tail: list);
var
  index: integer;
  search: byte;
begin
  if (head1 <> nil) and (head1^.next <> nil) then begin
    readln(search);
    p := head;
    index := 1;
    while p <> nil do 
    begin
      if p^.key = search then begin
        writeln('Элемент найден! Индекс: ', index);
        exit;
      end;
      p := p^.next;
      inc(index);
    end;
    writeln('Элемент не найден!');
  end else writeln('Список не существует!');
end;

procedure indiv2(var head, tail: list);
begin
  if (head1 <> nil) and (head1^.next <> nil) then begin
    while (head^.key < 170) and (head^.key > 130) do 
    begin
      p := head;
      head := head^.next;
      dispose(p);
    end;
    p := head;
    while (p <> tail) or (p <> nil) do
    begin
      if (p = nil) or (p^.next = nil) then exit;
      if (p^.next^.key < 170) and (p^.next^.key > 130) then begin
        if p^.next^.next <> nil then begin
          q := p^.next;
          p^.next:= q^.next;
          dispose(q);
         end else begin
          dispose(p^.next);
          p^.next:=nil;
         end;
      end else p := p^.next;
    end;
  end else writeln('Список не существует!');
end;

procedure scrprint();
begin
  writeln('1)Создать список' + chr(10) + '2)Заполнить список' + chr(10) + '3)Распечатать список' + chr(10) +
        '4)Найти длину списока' + chr(10) + '5)Вставить перед i позицией' + chr(10) + '6)Удалить элемент перед i позицией' + chr(10) +
        '7)Разбить список на два' + chr(10) + '8)Соединить два списка' + chr(10) + '9)Создать копию списка' + chr(10) + '10)Проверить первые два списка на равенство' + chr(10) +
        '11)Удалить все элементы списка' + chr(10) + '12)Индивидуальное задание 1' + chr(10) + '13)Индивидуальное задание 2');
end;

begin
  head1 := nil;tail1 := nil;head2 := nil;tail2 := nil;head3 := nil;tail3 := nil;
  x := 100;
  scrprint();
  while x <> 0 do
  begin
    Readln(x);
    if x = 1 then 
    begin
      writeln('Введите номер создаваемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then ListInit(head1, tail1);
      if y = 2 then ListInit(head2, tail2);
      if y = 3 then ListInit(head3, tail3);
    end;
    if x = 2 then 
    begin
      writeln('Введите номер заполняемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then listupload(head1, tail1, 10);
      if y = 2 then listupload(head2, tail2, 10);
      if y = 3 then listupload(head3, tail3, 10);
    end;
    if x = 3 then 
    begin
      writeln('Введите номер печатаемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then printer(head1, tail1);
      if y = 2 then printer(head2, tail2);
      if y = 3 then printer(head3, tail3);
    end;
    if x = 4 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then writeln(range(head1, tail1) + ' элементов в списке');
      if y = 2 then writeln(range(head2, tail2) + ' элементов в списке');
      if y = 3 then writeln(range(head3, tail3) + ' элементов в списке');
    end;
    if x = 5 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      writeln('Введите индекс элемента');
      Readln(z);
      writeln('Введите значение элемента');
      Readln(zna4);
      if y = 1 then push2(zna4, z, head1, tail1);
      if y = 2 then push2(zna4, z, head2, tail2);
      if y = 3 then push2(zna4, z, head3, tail3);
    end;
    if x = 6 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      writeln('Введите индекс элемента');
      Readln(z);
      if y = 1 then del2(z, head1, tail1);
      if y = 2 then del2(z, head2, tail2);
      if y = 3 then del2(z, head3, tail3);
    end; 
    if x = 7 then 
    begin
      writeln('1 чтобы разбить первый список на второй и третий');
      Readln(y);
      if y = 1 then divide(head1, tail1, head2, tail2, head3, tail3);
    end;
    if x = 8 then 
    begin
      writeln('1 чтобы соединить второй и третий список в первый, 2 чтобы соединить первый и второй список в третий');
      Readln(y);
      if y = 1 then integrate(head1, tail1, head2, tail2, head3, tail3);
      if y = 2 then integrate(head3, tail3, head1, tail1, head2, tail2);
    end;
    if x = 9 then 
    begin
      writeln('1 чтобы создать копию первого списка во второй, 2 копия второго списка в первый:');
      Readln(y);
      if y = 1 then copy(head1, tail1, head2, tail2);
      if y = 2 then copy(head2, tail2, head1, tail1);
    end;
    if x = 10 then check(head1, tail1, head2, tail2);
    if x = 11 then 
    begin
      writeln('Введите номер удаляемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then delall(head1, tail1);
      if y = 2 then delall(head2, tail2);
      if y = 3 then delall(head3, tail3);
    end; 
    if x = 12 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      readln(y);
      if y = 1 then indiv1(head1, tail1);
      if y = 2 then indiv1(head2, tail2);
      if y = 3 then indiv1(head3, tail3);
    end;
    if x = 13 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      readln(y);
      if y = 1 then indiv2(head1, tail1);
      if y = 2 then indiv2(head2, tail2);
      if y = 3 then indiv2(head3, tail3);
    end;
    if x = 14 then begin
      ClrScr;
      scrprint();
    end;
  end;
end.