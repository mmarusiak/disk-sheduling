# disk-sheduling

rozbudowany generator  
arrival time  
krańce dysku, określona część dysku  
pojawiają się zgłoszenia za głowicą  
odczyt nie pobiera jednostki czasu, tylko ruch głowicy  
liczymy liczbę przesunięć głowicy  
średni czas oczekiwania  
zagłodzenie  
pozycja startowa głowicy z palca  


4 algorytmy
* FCFS
* SSTF - shortest seek time first, najbliżej głowicy pierwsze - żadania po drugien stronie dysku? - zagłodzenia - brak zmiany trasy, przesuwam się i obsłużę
* SCAN - podróżujemy w strony dysku, przeszukujemy dysk, pesymistyczny przypadek czekania - tuż za głowicą pojawi się żądanie - 2n - 1
* C-SCAN - zamiast odbicia w scanie i zawrócenia, pojawiam się od razu na starcie (głowica) - ile razy głowica musiała wrócić na początek dysku?

---

2 strategie obsługi rządań czasu reczywistego  

druga symulacja  

dwie strategie do porównania, nakładane na poprzednie algorytmy  
dodatkowy element - deadline, mówi nam jak długo to żądanie jest ważne  
* EDF - earliest deadline first - najmniejszy deadline najważniejszy - brak zapewnienia czasu wykonnia - widzi najmniejszy deadline leci tam - jak nie zdązymy dotrzeć to zagłodzone, pomijamy wszystko co mijamy po drodze
* FD-Scan - wybieramy żądanie z możliwym czasem do spełnienia
