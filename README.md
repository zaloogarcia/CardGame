# **Card game**

---
## Introduction:
OCaml, originally named [Objective Caml][O], is the main implementation of the programming language Caml. A member of the ML language family, OCaml extends the core Caml language with object-oriented programming constructs.

OCaml's toolset includes an interactive top-level interpreter, a bytecode compiler, a reversible debugger, a package manager (OPAM), and an optimizing native code compiler. It has a large standard library, making it useful for many of the same applications as Python or Perl, and has robust modular and object-oriented programming constructs that make it applicable for large-scale software engineering. OCaml is the successor to Caml Light. The acronym CAML originally stood for Categorical Abstract Machine Language, although OCaml omits this abstract machine.

OCaml is a free and open-source software project managed and principally maintained by French Institute for Research in Computer Science and Automation (INRIA). In the early 2000s, many new languages adopted elements from OCaml, most notably F# and Scala.


![Ocaml.jpg](http://wesphelan.com/wp-content/uploads/2014/11/ATBCamel2.jpg)

---
## Informacion:

In this project, A game with spanish cards was implented where 2 to 5 players can play. The rules are explained in the next link. [**link**][G].
The game has 4 data types, **card**, **deck**, **player** and **round**. Where 'card' and 'deck' are written in the file **src/cartas.ml**, and 'player' in **src/jugador.mli** y la ronda en **round.ml**, cada archivo su respectivo **.mli**. Y en **main.ml** se lleva a cabo las llamadas de todas las funciones de los archivos.

---
## cartas.ml

In this file the structure of the cards and the deck where developed using Ocaml **records**. The cards where defined with two arguments, an integer (for the future comparisons between cards) and the other argument with '**suit**' type for the type of card. To sum up, a card should look like this:

`carta = {value = 1; suit = Espada}`   

![cartas-espanolas.jpg](https://alastairsavage.files.wordpress.com/2012/10/spanish-playing-cards.jpg)
  
y luego, basicamente definimos a la baraja como una lista de cartas que se crea concatenando y mapeando los tipos:  
   
`let full_deck =
  let make_value_cards num =
    List.map (fun suit -> {value = num; suit = suit}) normal_suits
  in
  specials @ (List.concat (List.map make_value_cards values))
  `   
     
La forma de entregar cartas aleatorias del mazo a cada jugador que escojimos fue tomar la primera carta de una baraja ya mezclada, ya que teniamos dos formas de implementarlo, esta o tomar una carta aleatoria de la baraja, Ambas formas de implementar eran de una complejidad parecidas, entonces decidimos la primera (Nos parecio mas "natural").  
Ahora las **Cartas especiales**, las definimos como una carta con valor "-1" y su respectivo palo (**MAX**, **MIN**, **PAR**, etc). Porque "-1"?, bueno principalmente necesitabamos un numero que no sea un posible maximal y que no sea par para que no haya problemas con las cartas **MAX** y **PAR**, asique cualquier numero impar negativo nos era util. Las cartas especiales, definidas una por una dentro de una lista, se agregan a la baraja antes de mezclarse.  
  
En este archivo se utilizaron los siguientes modulos de Ocaml:     
 
 * [**Pervasives**][P]: para las excepciones y las impresiones en pantalla.
 * [**List**][L]: para las mayoria de las funciones.
 * [**Random**][R]: para mezclar la baraja. 
 * [**String**][S].
   
---
## jugador.ml  
  
En este archivo implementamos la estructura del jugador (**player**) tambien con los **records** de **Ocaml**. Definimos a jugador como una estructura de 4 campos, un *String* para el nombre , un entero para su puntaje y dos listas tipo **deck** (baraja), una para la baraja que tendria en mano y otra para guardar las cartas que ya haya jugado. Entonces un jugador seria por ejemplo:   
   
`{name = "Pampita"; points = 0; cards = [{value = 1; suit = Espada}]; played = empty_deck}`   
   
Luego se implementaron distintas funciones para entregar una carta a un jugador , Inicializar un jugador, Imprimir sus puntos y cartas jugadas, etc.  
Que fueron desarrollados sin dificultad con la ayuda de los **Records** de Ocaml.  
Tambien en este archivo se desarrollo la funcion de cada *carta especial*, fue trabajoso y la funcion no quedo bien esteticamente (50 lineas aprox de codigo repetitivo) pero en ella se modifica el jugador y la baraja general de acuerdo a que carta especial se invoco, y despues de que se juega una carta especial, el jugador termina su turno y se le otorga una carta. 
  
En este archivo se utilizaron los siguientes modulos de Ocaml e implementados:  

 * [**Pervasives**][P]: para las impresiones en pantalla.
 * [**List**][L].
 * **Cartas**.  
   
---
## ronda.ml   
  
En este archivos desarrollamos la estructura ronda (**round**) con el fin de tener funciones de interfaz modularizadas del archivo **jugador.ml**.  
Definimos la estructura round basicamente como una lista de jugadores, que nos sirve para poder imprimir las cartas jugadas por cada jugador en cada ronda, los puntajes, etc. y muchas funciones auxiliares.   
La funcion principal de este archivo es 'play_round' donde se analizan todos los casos posibles dentro de una ronda jugable.  
![ronda.jpg](https://bitbucket.org/repo/LLGjg7/images/3835112487-ronda.jpg)    
En este archivo se utilizaron los siguientes modulos de Ocaml e implementados:  

 * [**List**][L]: para las implementaciones de funciones, etc.
 * [**Pervasives**][P]: para las impresiones en pantalla, saltos de linea, excepciones, etc.
 * **Cartas**.
 * **Jugador** 
   
---
## main.ml  

En este archivo se llamaron las funciones de **round.ml** para generar el interfaz de usuario y respondar al mismo. Inicializando una ronda   
En este archivo se utilizaron los siguientes modulos de Ocaml e implementados:

 * **Cartas**.
 * **Jugador**.
 * **Ronda**.  

---
###Compilacion:
  
`make`

---
### **Notas:**
 
*No encontramos en las consignas un estilo de codigo, tampoco conseguimos un corrector de estilo de codigo de google para Ocaml.*    
     
*Queremos agradecer a los docentes de la catedra por haber postergado la fecha de entrega 2 veces, sin ello no podriamos haberlo entregado a tiempo. Y tambien por responder las dudas a todo momento.*

*En este laboratorio tuvimos muchos problemas en un principio por que programar funcionalmente no es como "andar en bicicleta", es decir, a diferencia de andar en bici, si se olvida. Pero por suerte pudimos "re-aprender". Personalmente, la materia nos entrega en cada lab un desafio, que un principio hace que "odiemos" el lenguaje del respectivo lab pero a fin de cuentas nos terminamos "amigando" con el pero solo unos segundos porque es justo cuando hay que entregarlo...*
   
---  
### **Bibliografia**:

 * [stackoverflow][W]
 * [Ocaml official web page][O]
 * [rosseta code][T]
 * [Manual ocaml][M]
 * [Expressions ocaml][E]





[E]:<http://caml.inria.fr/pub/docs/manual-ocaml/expr.html>
[M]:<http://caml.inria.fr/pub/docs/manual-ocaml/>
[T]:<http://rosettacode.org/wiki/Rosetta_Code>
[O]:<https://ocaml.org/>
[W]:<http://es.stackoverflow.com/>.
[S]:<http://caml.inria.fr/pub/docs/manual-ocaml/libref/String.html>  
[R]:<http://caml.inria.fr/pub/docs/manual-ocaml/libref/Random.html> 
[L]:<http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html>  
[P]:<http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html>
[G]:<https://github.com/georgealegre/ocamlFunctionalWar/blob/master/doc/consignas.md>









