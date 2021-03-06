﻿program Project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };


type
    ukazat = ^item; //  указатель
    item = record //  указатель типа запись
        punkt:string;   //  Пункт назначения
        nom_reys: integer;   //  номер рейса
        fio: string; //ФИО
        date: record
            h: byte;
            m: byte;
            end;
        next: ukazat;   //  указатель на следующий элемент
        pred: ukazat;   //  указатель на предыдущий элемент
        end;

{ Меню }
procedure menu(var deystvie: integer);
begin
    writeln();
    writeln('Что вы хотите сделать:');
    writeln('1. Заполнить список');
    writeln('2. Показать список');
    writeln('3. Добавить заявку');
    writeln('4. Удаление заявки');
    writeln('5. Вывод заявок по заданному номеру рейса и времени выезда;');
    writeln('6. Длина списка ');
    writeln('7. Проверка списка на пустоту ');
    writeln('8. Переворот списка');
    writeln('9. Деление на 2 списка');
    writeln('10. Удаление всех элементов списка');
    writeln('0. Завершить программу ');
    writeln;
    write('Ваш выбор: ');
    readln(deystvie);    //  ввод нашего выбора
end;

{  заполнение списка (рандомно заполняет 10 элементов)  }
procedure zapolnenie(var perv, konec: ukazat);
var     q: ukazat;
        simv: array[1..3] of integer;
        punkt_naznach: string;
         h, m, n,  i: integer;
        avtor,name: string;
begin
    n:=10;
    while n > 0 do    //  пока n больше 0, заполняем списки
    begin

        //заполняем автора
         avtor  := '';
         simv[1] :=random(90 - 65 + 1) + 65 ;    //первая заглавная буква
         avtor  := avtor  + chr(simv[1]);
         for i := 1 to (random(10) + 3) do   //кол-во символов (до точки) в имени файла
         begin
             simv[2] := random(122 - 97 + 1) + 97;    //нижний регистр
             avtor := avtor  + chr(simv[2]);     //добавляем рандомный символ
             end;
         simv[1] :=random(90 - 65 + 1) + 65 ;
         simv[2] :=random(90 - 65 + 1) + 65 ;
         avtor  := avtor  +' '+chr(simv[1])+ '.'+chr(simv[2])+'.';


         punkt_naznach  := '';
         punkt_naznach := punkt_naznach + chr(random(90 - 65 + 1) + 65);
         for i := 1 to (random(10) + 3) do   //кол-во символов (до точки) в имени файла
               punkt_naznach := punkt_naznach  + chr(random(122 - 97 + 1) + 97);     //добавляем рандомный символ

        h := random(23);
        m := random(59);



         //  создаём указатель
        New(q);
        q^.next := nil;
        q^.pred := nil;
        q^.fio :=avtor;
        q^.nom_reys := random(5)+100;    //  рандомный рейс
        q^.date.h := h;
        q^.date.m := m;
        q^.punkt:=punkt_naznach;    //  рандомный пункт назначения
       
       if perv = nil then begin    //  если список пуст
            perv := q;
            konec := q;
            end
        else begin   //  если имеются элементы в списке
            konec^.next := q;
            konec^.next^.pred := konec;
            konec := q;
            end;
        n := n - 1;
    end;
end;

{ Вывод на экран списка }
procedure Print(perv: ukazat);
var
    R: ukazat;
    i: integer;
begin
    if perv <> nil then begin    //  если список не пустой
        i := 1;
        R := perv;
        while R <> nil do
        begin
            Writeln(i:2, '.    ',
            R^.punkt:18,'   '  ,
            R^.nom_reys:4,'    ',

            R^.fio:20,'    ',
            R^.date.h:2, ':',
            R^.date.m:2);
            R := R^.next;
            Inc(i);
        end;
    end
    else
        writeln('Список пуст');
end;

{ Получение даты(времени) }
procedure get_date(var hrs1, min1: integer);
var
    data: string;
    i, j, ost: integer;
begin
    readln(data);
        val(Copy(data,1,2),hrs1);
        val(Copy(data,4,2),min1);
end;

{ Добавление рейса }
procedure AddReys(var perv,konec:ukazat);
var
    k,hrs1,min1:integer;
begin

if perv=nil then  begin
      new(perv);
      perv^.next:=nil;
      perv^.pred:=nil;
      konec:=perv;
      write('Введите пункт назначения: '); readln(konec^.punkt);
      write('Введите номер рейса: '); readln(konec^.nom_reys);
      write('Введите FIO: ');  readln(konec^.fio);
      write('Введите время желаемого выезда: ');
      get_date(hrs1,min1);
      konec^.date.h:=hrs1;
      konec^.date.m:=min1;
      end
else begin
      new(konec^.next);
      konec^.next^.pred:=konec;
      konec:=konec^.next;
      konec^.next:=nil;
      write('Введите пункт назначения: '); readln(konec^.punkt);
      write('Введите номер рейса: '); readln(konec^.nom_reys);
      write('Введите FIO: ');  readln(konec^.fio);
      write('Введите время желаемого выезда: ');
      get_date(hrs1,min1);
      konec^.date.h:=hrs1;
      konec^.date.m:=min1;

      end;
end;

{ Удаление записи }
Procedure DelElem(var spis1,spis2:ukazat;tmp:ukazat);
var
  tmpi:ukazat;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then begin
        spis1:=tmp^.next;
        if spis1<>nil then {если список оказался не из одного элемента, то}
             spis1^.pred:=nil {"зануляем" указатель}
        else {в случае, если элемент был один, то}
             spis2:=nil; {"зануляем" указатель конца списка, а указатель начала уже "занулён"}
        dispose(tmp);
  end
  else
    if tmp=spis2 then begin{если удаляемый элемент оказался последним элементом списка}
          spis2:=spis2^.pred; {указатель конца списка переставляем на предыдущий элемент}
          if spis2<>nil then {если предыдущий элемент существует,то}
               spis2^.next:=nil {"зануляем" указатель}
          else {в случае, если элемент был один в списке, то}
              spis1:=nil; {"зануляем" указатель на начало списка}
          dispose(tmp);
    end
    else begin{если же удаляется список не из начали и не из конца, то}
          tmpi:=spis1;
          while tmpi^.next<>tmp do {ставим указатель tmpi на элемент перед удаляемым}
               tmpi:=tmpi^.next;
          tmpi^.next:=tmp^.next; {меняем связи}
          if tmp^.next<>nil then
              tmp^.next^.pred:=tmpi; {у элемента до удаляемого и после него}
          dispose(tmp);
    end;
end;

Procedure DelElemPos(var spis1,spis2:ukazat; posi:integer);
var i:integer;
       tmp:ukazat;
begin
  if posi<1 then
     exit;
  if spis1=nil then begin
        Write('Список пуст');
        exit
        end;
  i:=1;
  tmp:=spis1;
  while (tmp<>nil) and (i<>posi) do begin
        tmp:=tmp^.next;
        inc(i)
        end;
  if tmp=nil then begin
        Writeln('Записи с порядковым номером ' ,posi, ' нет в списке.');
        writeln('В списке всего ' ,i-1, ' элементов.');
        exit
        end;
  DelElem(spis1,spis2,tmp);
  Writeln('Элемент удалён.');
end;


{ вывод заявок по заданному номеру рейса и дате вылета; }
procedure poisk_zayavok(var perv,konec: ukazat);
var
    R: ukazat;
    hrs1,min1, prints, j,reys: integer;
    s: string;
    date,date_fly,h,m: string;
begin
    prints:=0;
    s := '';
    j := 1;
    R := perv;
    if R <> nil then begin
       write('Введите номер рейса: ');readln(reys);
       write('Введите время выезда: ');
       get_date(hrs1,min1);

       while R <> nil do  begin


            if (hrs1 = R^.date.h) and
               (min1 = R^.date.m) then begin
                   s:=s+'1';
                   Writeln(j:2, '.    ',
                   R^.punkt:18,'   '  ,
                   R^.nom_reys:4,'    ',

                   R^.fio:20,'    ',
                   R^.date.h:2, ':',
                   R^.date.m:2);

                   j := j + 1;
                   R := R^.next;
                   end
            else begin
                    R := R^.next;
                    j := j + 1;
                    end;
            end;

       if s='' then    writeln('нет соответствующих заявок');
       end
    else
        writeln('Список пуст');
end;

{ Длина списка }
procedure dlina_sp(perv: ukazat; var dlina_spiska: integer);
var k: integer;
    R: ukazat;
begin
    R := perv;
    k := 0;
    while R <> nil do begin
        R := R^.next;
        k := k + 1;
        end;
    dlina_spiska := k;
end;

{ Проверка списка на пустоту }
procedure proverka_spiska_na_pustotu(perv: ukazat);
begin
    if perv = nil then
        writeln('список пуст')
    else
        writeln('список не пуст');
end;

{ Переворот списка }
procedure perevorot_spiska(var perv,konec:ukazat);
var  q,zn,w:ukazat;
begin
   if perv<>nil then begin
          q:=perv;
          w:=konec;
          while q<>nil do begin
                  zn:=q^.next;
                  q^.next:=q^.pred;
                  q^.pred:=zn;
                  q:=zn;
        	      end;
          konec:=perv;
          perv:=w;
          end
   else
          writeln('список пуст');
end;

{ Удаление всех элементов }
procedure delete_vseh_el(var perv,konec:ukazat);
var q,R:ukazat;
begin
    while perv<>nil do  begin
     q:=perv;
     perv:=perv^.next;
     if perv<>nil then
           dispose(q)
     else begin
           konec:=nil;
           dispose(q);
           end;
     end;
     writeln('Список очищен!' );
end;

 { Деление на 2 списка }
procedure delenie_na_2_spiska(var perv,konec,perv1,konec1:ukazat);
var
    q,i,dlina_spiska:integer;
    R:ukazat;
begin
    R:=perv;
    dlina_sp(R,dlina_spiska);
    if perv<>nil then
        begin
               q:=dlina_spiska div 2;    //  целочисленно делим основной список на 2
                i:=1;
                while i<>q do
                       begin
                           R:=R^.next;
                           i:=i+1;
                       end;
                konec1:=R;
                R:=R^.next;
                perv1:=R;
                konec1^.next:=nil;
                perv1^.pred:=nil;
         end
    else
          writeln('Список пуст, надо заполнить!!!');
end;

{ Меню при 2ух списках }
procedure menu1(var deystvie1:integer);
begin
    writeln();
    writeln('Что вы хотите сделать?:');
    writeln('1. Показать 2 списка');
    writeln('2. Проверка 2ух списков на равенство');
    writeln('3. Соединение 2ух списков в один (основные действия только с одним списком)');
    writeln();
    write('Ваш выбор: ');
    readln(deystvie1);
end;

{ Соединение 2ух списков в один }
procedure connect(konec1,perv1:ukazat);
begin
    konec1^.next:=perv1;    //  конец 1ого на начало 2ого
    perv1^.pred:=konec1;   //  конец 2ого на начало 1ого
end;



{ Проверка 2ух списков на равенство}
procedure proverka(perv,perv1:ukazat);
var p:integer;
        R,R1:ukazat;
        namefile:string;
begin
    R:=perv;
    R1:=perv1;
    p:=1;    //  счётчик
    while (R^.next<>nil) and (p=1) do
          begin
               if (R^.nom_reys<>R1^.nom_reys)  then    //  сравниваем рейсы по очереди
                  begin
                       p:=0;    //  если элементыне не одинаковые, зануляется на 0
                  end
               else
                     begin
                       R:=R^.next;
                       R1:=R1^.next;
                     end;
          end;
     if p=1 then writeln('Списки одинаковы')
     else  writeln('Списки различны');
end;

var
    deystvie, dlina_spiska, deystvie1,i: integer;
    perv, konec, perv1, konec1: ukazat;
begin
    menu(deystvie);
    writeln();
    while deystvie <> 0 do
    begin
        case deystvie of

            1: begin
                    zapolnenie(perv, konec);
                    Print(perv);
                end;
            2: Print(perv);
            3:  begin
                 AddReys(perv,konec);
                 Print(perv);
                 end;
            4:begin
                 Write('Введите порядковый номер удаляемой записи: ');
                 readln(i);
                 DelElemPos(perv,konec,i);
                 Print(perv);
               end;


            5: poisk_zayavok(perv,konec);
                    
            6: begin
                 dlina_sp(perv,dlina_spiska);
                 writeln('Длина списка: ',dlina_spiska);
               end;
            7: proverka_spiska_na_pustotu(perv);
            8: begin
                  perevorot_spiska(perv,konec);
                  print(perv);
               end;
            9: begin
                 dlina_sp(perv,dlina_spiska);
                 if dlina_spiska>=2 then begin
                     delenie_na_2_spiska(perv,konec,perv1,konec1);
                     writeln('1ый список');
                     Print(perv);
                     writeln('2ой список');
                     Print(perv1);
                     menu1(deystvie1);
                     writeln();
                     while deystvie1<>3 do begin
                            case deystvie1 of
                                    1: begin
                                       writeln('1ый список');
                                        Print(perv);
                                        writeln();
                                        writeln('2ой список');
                                        Print(perv1);
                                       end;
                                    2: proverka(perv,perv1);
                                    end;
                            menu1(deystvie1);
                            end;
                    connect(konec1,perv1);
                    end
                 else
                       writeln('Невозможно сделать это действие');
                 end;
          10: delete_vseh_el(perv,konec);
          end;
      menu(deystvie);
    end; 
delete_vseh_el(perv,konec);
end. 
