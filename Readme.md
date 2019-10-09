## Reto 1 

Se agrego  un condicional inline en el archvo api.rb dentro de la carpeta hangman

hint:  @game.f >= 3 ? @game.h : '',


## Reto 2

Se creo el cliente en la carpeta hangman llamado client.rb 
$ ruby hangman/client.rb

## Reto 3 

Se crearon los archivos api.rb y puzzle.rb dentro de la carpeta puzzle 

instrucciones:

'/puzzle/:pid/:size' 

recibe el pid del juego y el tamaño de la matriz 

'/puzzle/:pid/try/:jugada'

recibe el pid del juego y la accion de juego  ['izq', 'arr', 'der', 'aba']