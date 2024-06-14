CREATE SCHEMA rozliczenia2;
GO

--3
CREATE TABLE rozliczenia.pracownicy(
id_pracownika INTEGER NOT NULL PRIMARY KEY,
imie NVARCHAR(50) NOT NULL,
nazwisko NVARCHAR(50),
adres VARCHAR(100),
telefon VARCHAR(15)
);
CREATE TABLE rozliczenia.godziny(
id_godziny INTEGER NOT NULL PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin INTEGER NOT NULL,
id_pracownika INTEGER NOT NULL
);
CREATE TABLE rozliczenia.pensje (
id_pensji INTEGER NOT NULL PRIMARY KEY,
stanowisko VARCHAR(50) NOT NULL,
kwota DECIMAL(10,2) NOT NULL,
id_premii INTEGER NOT NULL
);
CREATE TABLE rozliczenia.premie(
id_premii INTEGER NOT NULL PRIMARY KEY,
rodzaj VARCHAR(50),
kwota DECIMAL(10,2) NOT NULL
);

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT FK_pensje_premie FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT FK_pracownicy_godziny FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

--4
INSERT INTO rozliczenia.pracownicy VALUES 
(1, 'Andrzej', 'Dudek', 'Kraków', '1337'),
(2, 'Grzegorz', 'Grzegżółka', 'Szczebrzeszyn', '4200'),
(3, 'Karol', 'Wojdyła', 'Wadowice', '2137'),
(4, 'Anita', 'Lis', 'Krosno', '2547'),
(5, 'Róża', 'Luksemburg', 'Katowice', '1917'),
(6, 'Krystian', 'Kasprzycki', 'Dukla', '7894'),
(7, 'Zbigniew', 'Włodecki', 'Dukla', '5672'),
(8, 'Krzysztof', 'Suchodolski', 'Choroszcz', '6769'),
(9, 'Anastazja', 'Szewczenko', 'Biełgorod', '4374'),
(10, 'Katarzyna', 'Nachman', 'Rymanów', '7845');


INSERT INTO rozliczenia.godziny VALUES 
(1, '2024-04-01', 6, 1337),
(2, '2024-04-01', 8, 4374),
(3, '2024-04-01', 8, 7894),
(4, '2024-04-01', 8, 2547),
(5, '2024-04-01', 10, 4200),
(6, '2024-04-02', 6, 1337),
(7, '2024-04-02', 9, 1917),
(8, '2024-04-02', 8, 5672),
(9, '2024-04-02', 12, 2137),
(10, '2024-04-02', 7, 7845);

INSERT INTO rozliczenia.pensje VALUES 
(1, 'Kierownik działu', 7500.00, 1),
(2, 'Koordynator', 6800.00, 2),
(3, 'Specjalista IT', 6500.00, 3),
(4, 'Księgowy', 3500.00, 4),
(5, 'Recepcja', 2500.00, 5),
(6, 'Sprzątacz', 2500.00, 6),
(7, 'Grafik', 4800.00, 7),
(8, 'PR', 3100.00, 8),
(9, 'Analityk', 4600.00, 9),
(10, 'Pracownik', 4000.00, 10);

INSERT INTO rozliczenia.premie VALUES 
(1, 'Premia motywacyjna', 1500.00),
(2, 'Premia uznaniowa', 2000.00),
(3, 'Premia stażowa', 1000.00),
(4, 'Premia świąteczna', 960.00),
(5, 'Premia za nadgodziny', 2500.00),
(6, 'Premia za wyniki', 2000.00),
(7, 'Premia za punktualność', 800.00),
(8, 'Premia kierownicza', 2800.00),
(9, 'Premia specjalna', 2000.00),
(10, 'Premia za działalność marketingową', 250.00);

--5
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6
SELECT DATEPART(WEEKDAY, data) AS dzien_tygodnia, DATEPART(MONTH, data) AS miesiac FROM rozliczenia.godziny;

--7
ALTER TABLE rozliczenia.pensje
ADD kwota_netto DECIMAL(10,2);

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto - (kwota_brutto * 0.20); 
