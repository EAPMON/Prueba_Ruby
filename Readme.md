## Reto 1 

Se agrego  un condicional inline en el archvo api.rb dentro de la carpeta hangman

hint:  @game.f >= 3 ? @game.h : '',


## Reto 2
Se creo la clase client en la carpeta hangman llamado client.rb 
tambien se creo play.rb donde se encuentra la instancia de la clase 

para jugar:
$ ruby games/hangman/play.rb

## Reto 3 

Se crearon los archivos api.rb, puzzle.rb, herper.rb, client.rb y play.rb dentro de la carpeta puzzle 

instrucciones:

para iniciar el juego: 
$ ruby games/puzzle/play.rb

pid es el identificador del juego 
size es el tamaño de la matriz cuadrada 

para jugar:
se utilizan las flechas del teclado para todos los movimientos posibles 

para ganar: debe ordenar los numeros del puzzle de forma ascendente 
# ejemplo 

# 1 2 3
# 4 5 6
# 7 8 0

