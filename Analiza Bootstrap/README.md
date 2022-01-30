# Analiza Bootstrap
# Autor: Mikołaj Klawitter

## Opis
Bootstrap polega na szacowaniu (estymacji) wyników poprzez wielokrotne losowanie ze zwracaniem z próby. Polega na utworzeniu nowego rozkładu wyników, na podstawie posiadanych danych, poprzez ich wielokrotne losowanie wartości z posiadanej próby. Metoda ta jest przydatna szczególnie wtedy, gdy nie jest znana postać rozkładu zmiennej w populacji. Ponieważ boostrap w podstawowej wersji nie czyni założeń co do rozkładu populacji. może być liczony do metod nieparametrycznych.

## Analiza
Na podstawie wykonanej analizy oraz przedstawionych danych można stwierdzić następujące fakty:
- każdy z wykresów przedstawia rozkład normalny (dla normal distribuation | mean for current year | mean for next year)
- rozkład stanu standardowego przedstawia linię równomiernego rozkładu (zaznaczone wartości są ułożone prawie idealnie na linii)
- przewidywana wartość uprawniania kukurydzy w 2022 roku zmniejszy się w porównaniu z rokiem 2021 wsród badanych
- korelacja dla 2021 oraz 2022 wynosi 0,99025

## Wykresy:
Normal distribuation

<img width="744" alt="obraz" src="https://user-images.githubusercontent.com/81513502/151712767-0fd6f9bf-e2a7-4e49-936d-040440e900b9.png">

Current year

<img width="751" alt="obraz" src="https://user-images.githubusercontent.com/81513502/151712795-dcbc08d6-92f6-4236-9ede-abe4fa383336.png">

Next year

<img width="755" alt="obraz" src="https://user-images.githubusercontent.com/81513502/151712815-dfe8be7b-7133-4426-90f7-5461de1a796b.png">


## Pliki
Data.csv - oryginalny plik źródłowy z danymi.

Kwestionariusz.Grupa.1.docx - dokumentacja oraz kwestionariusz pytań.

bootstrap.R – analiza Bootstrap
