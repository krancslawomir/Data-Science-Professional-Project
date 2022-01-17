# CDV - Data Science Professional Project
Data Science Professional Project - Projekt zaliczeniowy
# Analiza Brand Equity
Autor Sławomir Kranc

### Spis treści
* [Opis](#opis)
* [Dane i Dokumentacja](#dane-i-dokumentacja)
* [Struktura danych](#struktura-danych)
* [Wymagania](#wymagania)
* [Analiza Brand Equity](#Analiza-Brand-Equity)
* [Pliki](#Pliki)

## Opis
Brand Equity (pol. wartość marki, kapitał marki) to wspólne dla grupy docelowej klientów zachowania i skojarzenia z marką, odczuwalna przez klienta wartość dodatkowa (w porównaniu z innymi produktami). Wartość ta może być podstawą trwałej przewagi konkurencyjnej marki i wzrostu zysków przedsiębiorstwa.
Badanie Brand Equity to badanie kompleksowo oceniające własności konkurencyjne marki. Realizuje je się na grupie konkurencyjnych marek stopniowo porównując wybrane ich wskaźniki na różnych polach. 

## Dane i dokumentacja
Dokumentacja została przekazana w postaci kwestionariusza pytańm natomiast dostarczone dane źródłowe w postaci pliki .csv.

## Struktura danych
Plik zawiera 167 kolumn oraz 201 wierszy.
Dane zostały dostarczone w postaci plku .csv, a wartości są ze sobą odzielone średnikami (;)
Kluczowe informacje dotyczące pliku ze zbiorem danych:
- dane reprezentują odpowiedzi 200 respondentów
- dane miejscami zawierają brakujące informacje (NA)
- dane posiadają wartości skończone niemniejednak występują w nich wartości odstające tzn. outliers


## Wymagania
#### ***WAŻNE! Plik z kodem w języku R (BrandEquity.R) oraz plik z danymi (Data.csv) należy umieścić w tym samym folderze!***

Programy i aplikacje:
* [R](https://www.r-project.org/) min. wersja 4.1.1
* [RStudio](https://www.rstudio.com/)
* Microsoft Excel

Wspierane platformy:
- Microsoft Windows
- Linux

Wspierane architektury:

- x86 32 bit
- x86 64 bit


## Analiza Brand Equity
Na podstawie wykonanej analizy oraz przedstawionych danych można stwierdzić następujące fakty:
- najwyższa świadomość oraz znajomość występuje dla Gołąbka, Czubajki, Borowika oraz Maślaka i kształtuje się na poziomie powyżej 14%.
- najwyższy wskaźnik użycia występuje u Borowika (19,13%), a tuż za nim jest Czubajka (18,95%) oraz Gąska (18,47%).
- najwyższy indeks preferencji i satysfakcji według badanych występuje w przypadku Borowika (23,59%), a także Maślaka (22,13%) oraz Czubajki (22,12%).

Biorąc pod uwagę wszystkie powyższe wskaźniki składające się na całość analizy Brand Equity można powiedzieć, że najwyższą wartość wśród badanej grupy docelowej posiada
Borowik (57,27%).


##  Pliki
- ***BrandEquity.R*** - główna analiza wykonawcza (kod w języku R).
- ***AddLabelsScript.R*** - kod pomocniczy służący do nadawania etykiet.
- ***Data.csv*** - oryginalny plik źródłowy z danymi.
- ***Brand.Health.Index.xlsx*** - pomocniczy plik służący do pogrupowania pytań do poszczególnej analizy.
- ***Brand_Equity_Results.csv*** - plik wygenerowany z obliczeń w programie RStudio.
- ***Brand_Equity_Analysis.xlsx*** - plik zawierający głębszą analizę, tabele przestawne oraz wykresy.
- ***Kwestionariusz.Grupa.1.docx*** - dokumentacja oraz kwestionariusz pytań.
- ***Wykres radarodwy.png*** - wykres radarowy dotyczący analizy grzybów.
- ***Wykres słupkowy.png*** - wykres słupkowy dotyczący analizy grzybów.
