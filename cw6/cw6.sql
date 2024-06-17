USE frima;
GO

--a
ALTER TABLE ksiegowosc.pracownicy
ADD nowy_telefon VARCHAR(20);
UPDATE ksiegowosc.pracownicy
SET nowy_telefon = CONCAT('(+48) ', telefon);

SELECT * FROM ksiegowosc.pracownicy; -- Sprawdzenie poprawności aktualizacji

ALTER TABLE ksiegowosc.pracownicy
DROP COLUMN telefon;

EXEC sp_rename 'ksiegowosc.pracownicy.nowy_telefon', 'telefon', 'COLUMN';

SELECT * FROM ksiegowosc.pracownicy;

--b
ALTER TABLE ksiegowosc.pracownicy
ADD telefon3 VARCHAR(20);

UPDATE ksiegowosc.pracownicy
SET telefon3 = CONCAT(
    SUBSTRING(telefon, 7, 3), '-',
    SUBSTRING(telefon, 10, 3), '-', 
    SUBSTRING(telefon, 13, 3))
SELECT * FROM ksiegowosc.pracownicy

--c
SELECT UPPER(nazwisko) AS nazwisko
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

--d
SELECT p.imie, p.nazwisko, HASHBYTES('MD5', CONVERT(VARCHAR, pn.kwota)) AS pensja_md5
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji;

--e xD

--f
SELECT p.imie, p.nazwisko, pn.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii;

--g
SELECT 
CONCAT('Pracownik ',p.imie,' ',p.nazwisko,', w dniu ', 
CONVERT(VARCHAR, g.dataa, 104), ' otrzymał pensję całkowitą na kwotę ', 
(pn.kwota+pr.kwota),' zł, gdzie wynagrodzenie zasadnicze wynosiło: ',pn.kwota, ' zł, premia: ',
pr.kwota, ' zł, nadgodziny: ',(g.liczba_godzin - 8), 'godz.')
AS raport
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.godziny g ON g.id_godziny=w.id_godziny
JOIN ksiegowosc.pensja pn ON pn.id_pensji=w.id_pensji
JOIN ksiegowosc.premia pr ON pr.id_premii=w.id_premii