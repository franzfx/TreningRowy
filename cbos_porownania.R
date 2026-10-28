| Kolumna źródłowa | Znaczenie |
  |:--|:--|
  | `plec` | płeć respondenta |
  | `miejscowosc` | wielkość miejscowości |
  | `kierunek` | czy sytuacja w Polsce zmierza w dobrym czy złym kierunku |
  | `prognoza` | przewidywanie sytuacji w Polsce w kolejnym roku |
  | `wyksztalcenie` | poziom wykształcenia |

### Zadanie 7 — wieś i duże miasta

Wybierz respondentów z kategorii `miejscowosc` równych `"wieś"` i `"miasto 500 000 i więcej"`. Dla każdej z tych dwóch grup policz **procent** odpowiedzi na pytanie `kierunek` (procent w obrębie grupy, nie w całej tabeli). Czy udział odpowiedzi „W złym” był taki sam?
  
  Sprawdź liczbę respondentów w obu grupach. Samo porównanie procentów bez liczebności może być mylące.

```{r cbos-zad-7}
# WASZE ROZWIĄZANIE
# filter(...), count(miejscowosc, kierunek), group_by(miejscowosc)

cbos_zad7 <- cbos%>%
  filter(miejscowosc == "wieś" | miejscowosc == "miasto 500 000 i więcej")
  
sr_kier_zly <- sum(cbos_zad7$kierunek == "W złym", na.rm = T) / length(cbos_zad7$kierunek)*100
sr_kier_zly

```

### Zadanie 8 — ocena teraźniejszości a oczekiwania

Zrób tabelę liczności odpowiedzi na `prognoza`. Następnie ogranicz dane do osób oceniających sytuację w kraju jako `"W złym"` i sprawdź, jak odpowiadały na pytanie o przyszłość. Która odpowiedź była najczęstsza w tej grupie? Czy na podstawie tej tabeli można wyciągać wnioski przyczynowe?
  
  ```{r cbos-zad-8}
# WASZE ROZWIĄZANIE
# filter(kierunek == "W złym"), count(prognoza, sort = TRUE)

licznosc_prognoza <- cbos%>%
  count(prognoza)%>%
  mutate(procent = n/sum(n)*100)

cbos_zad8 <- cbos%>%
  filter(kierunek == "W złym")

licznosc_przyczyna <- cbos%>%
  filter(kierunek == "W złym")%>%
  count(prognoza, .drop = FALSE)%>%
  filter(prognoza != "Odmowa odpowiedzi")%>%
  mutate(procent = n/sum(n)*100)

```