-- z1.:
create database firma;

-- z2.:
create schema ksiegowosc;

-- z4.:
DROP TABLE ksiegowosc.pracownicy;
DROP TABLE ksiegowosc.godziny;
DROP TABLE ksiegowosc.pensje;
DROP TABLE ksiegowosc.premie;
drop table ksiegowosc.wynagrodzenie;

create table ksiegowosc.pracownicy(
id_pracownika int primary key not null,
imie varchar(30) not null,
nazwisko varchar(40) not null,
adres varchar(120),
telefon int);

create table ksiegowosc.godziny(
id_godziny int primary key, 
data date, 
liczba_godzin int, 
id_pracownika int);

create table ksiegowosc.pensja(
id_pensji int primary key not null, 
stanowisko varchar(40) not null, 
kwota DOUBLE PRECISION  not null);

create table ksiegowosc.premia(
id_premii int primary key not null, 
rodzaj varchar(25) not null, 
kwota DOUBLE PRECISION  not null);

create table ksiegowosc.wynagrodzenie( 
id_wynagrodzenia int primary key not null, 
data date, 
id_pracownika int, 
id_godziny int, 
id_pensji int, 
id_premii int);

alter table ksiegowosc.godziny add foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika);
alter table ksiegowosc.wynagrodzenie add foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika);
alter table ksiegowosc.wynagrodzenie add foreign key (id_pensji) references ksiegowosc.pensja(id_pensji);
alter table ksiegowosc.wynagrodzenie add foreign key (id_premii) references ksiegowosc.premia(id_premii);

-- z5.:

insert into ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) values 
(11, 'Piotr', 'Nowak', 'Słoneczna 45 Gdańsk', 673865345),
(12, 'Tomasz', 'Kamiński', 'Jesienna 23 Kraków', 567890123),
(01, 'Elżbieta', 'Kowal', 'Leśna 5a Lublin', 536718291), 
(13, 'Rafał', 'Kowalski', 'Ogrodowa 12 Katowice', 832994167),
(02, 'Barbara', 'Wiśniewska', 'Lipowa 32 Rzeszów', 647322653),
(03, 'Karolina', 'Zielińska', 'Morska 8 Wrocław', 537289352),
(14, 'Marek', 'Wójcik', 'Zielona 45 Białystok', 873928733), 
(05, 'Anna', 'Kowalczyk', 'Brzozowa 18 Olsztyn', 673829263),
(04, 'Paweł', 'Kaczmarek', 'Dębowa 56 Szczecin', 543526371), 
(06, 'Natalia', 'Mazur', 'Wiosenna 89 Poznań', 678901748);


insert into ksiegowosc.godziny(id_godziny, data, liczba_godzin, id_pracownika) values 
(460,'2024-01-23',2,02),(067,'2024-01-22',8,03),
(765,'2024-01-21',8,02),(072,'2024-03-31',12,03),
(546,'2024-01-13',10,01),(873,'2024-02-03',8,05),
(023,'2024-01-18',8,02),(568,'2024-01-23',10,01),
(987, '2024-01-27',4,04),(453,'2024-01-15',12,01);

insert into ksiegowosc.pensja(id_pensji, stanowisko, kwota) values 
(04, 'Operator pow. płaskich', 2137.00),
(05, 'Kierowca', 4456.99),
(33,'Operator pow. płaskich', 2345.00),
(41, 'Kier. działu rozrywki', 12879.00),
(84, 'Z-c kier. działu rozrywki', 11769.00),
(53,'Operator pow.', 2345.67),
(45, 'Sekretarz', 3586.35),
(03, 'Asystent sprzedaży', 6754.89),
(11, 'Asystent sprzedaży', 6754.89),
(02, 'Sekretarz', 3586.35);

insert into ksiegowosc.premia(id_premii, rodzaj, kwota) values 
(01, 'Specjalna 1', 123.00),
(02, 'Specjalna 2', 256.00),
(04, 'Specjalna 4', 479.00),
(09, 'Specjalna 9', 1289.00),
(11, 'Specjalna 11', 2457.89),
(14, 'Specjalna 14', 3476.99),
(21, 'Lekarska 1', 12.00),
(23, 'Lekarska 3', 35.00),
(34, 'Lekarska 4', 89.00),
(12, 'Uznaniowa', 100.00);

insert into ksiegowosc.wynagrodzenie(id_wynagrodzenia,data,id_pracownika,id_godziny,id_pensji,id_premii) values
(23,'2024-01-23',01,546, 02, NULL),
(29,'2024-01-18',02,460, 03, 34),
(25,'2024-02-19',03,067, 04, NULL),
(26,'2024-01-23',04,765, 05, NULL),
(27,'2024-01-24',05,072, 11, 09),
(28,'2024-02-25',06,453, 33, NULL),
(32,'2024-01-13',11,873, 41, NULL),
(45,'2024-02-14',12,162, 84, 12),
(11,'2024-01-21',13,568, 53, NULL),
(67,'2024-02-22',14,987, 45, NULL);

-- z6 a.:

select id_pracownika, nazwisko
from ksiegowosc.pracownicy;

-- b.:

SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja s ON p.id_pracownika = p.id_pracownika
WHERE s.kwota > 1000;

-- c.:

select p.id_pracownika
from ksiegowosc.pracownicy p 
join ksiegowosc.wynagrodzenie w on w.id_pracownika =p.id_pracownika 
join ksiegowosc.pensja pn on w.id_pensji =pn.id_pensji 
join ksiegowosc.premia pr on w.id_premii =pr.id_premii 
where pr.kwota=0 and pn.kwota > 2000;

-- d.:

SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

-- e.:

SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f.:

SELECT p.imie, p.nazwisko, 
       SUM(gp.liczba_godzin - 160) AS nadgodziny
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny gp ON p.id_pracownika = gp.id_pracownika
GROUP BY p.imie, p.nazwisko
HAVING SUM(gp.liczba_godzin) > 160;

-- g.:

SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja s ON p.id_pracownika = p.id_pracownika
WHERE s.kwota BETWEEN 1500 AND 3000;

-- h.:

SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny gp ON p.id_pracownika = gp.id_pracownika
LEFT JOIN ksiegowosc.wynagrodzenie pr ON p.id_pracownika = pr.id_pracownika
WHERE pr.id_premii IS NULL
GROUP BY p.imie, p.nazwisko
HAVING SUM(gp.liczba_godzin) > 160;

-- i.:

SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
ORDER BY pensja.kwota;

-- j.:

select p.imie, p.nazwisko, pn.kwota as pensja, pr.kwota as premia
from ksiegowosc.pracownicy p 
join ksiegowosc.pensja pn on p.id_pracownika =pn.id_pensji 
join ksiegowosc.premia pr on p.id_pracownika =pr.id_premii 
order by pn.kwota, pr.kwota;
