# **Card game**

---
## Introduction:
OCaml, originally named [Objective Caml][O], is the main implementation of the programming language Caml. A member of the ML language family, OCaml extends the core Caml language with object-oriented programming constructs.

OCaml's toolset includes an interactive top-level interpreter, a bytecode compiler, a reversible debugger, a package manager (OPAM), and an optimizing native code compiler. It has a large standard library, making it useful for many of the same applications as Python or Perl, and has robust modular and object-oriented programming constructs that make it applicable for large-scale software engineering. OCaml is the successor to Caml Light. The acronym CAML originally stood for Categorical Abstract Machine Language, although OCaml omits this abstract machine.

OCaml is a free and open-source software project managed and principally maintained by French Institute for Research in Computer Science and Automation (INRIA). In the early 2000s, many new languages adopted elements from OCaml, most notably F# and Scala.


![Ocaml.jpg](http://www.liveanimalslist.com/mammals/images/camel-in-the-desert-area.jpg)

---
## Information:

In this project, A game with spanish cards was implented where 2 to 5 players can play. The rules are explained in the next link. [**link**][G].
The code of game has 4 data types, **card**, **deck**, **player** and **round**. Where 'card' and 'deck' are written in the file **cartas.ml**, and 'player' in **jugador.mli** and the round in  **round.ml**, each file with its own **.mli**. and  **main.ml** will call all the functions from the others files.
---
## cartas.ml

In this file the structure of the cards and the deck where developed using Ocaml **records**. The cards where defined with two arguments, an integer (for the future comparisons between cards) and the other argument with '**suit**' type for the type of card. To sum up, a card should look like this:

`carta = {value = 1; suit = Espada}`   
x`
![cartas-espanolas.jpg](http://cdn-3.lanzaroteinformation.com/files/images/Baraja%2040%20cards.preview.jpg)
  
And then basically the deck is defined as a list of cards that are concatenated:

   
`let full_deck =
  let make_value_cards num =
    List.map (fun suit -> {value = num; suit = suit}) normal_suits
  in
  specials @ (List.concat (List.map make_value_cards values))
  `   
 
The way of delivering the cards to the players in a randomly is taking the first cards from the deck that is already randomly sorted (Is the natural way).  
Each **special cards** has their arguments like this, its integer is '-1' and its suit can  be **MAX**, **MIN**, **PAR**, etc. Why"-1"?, because cant be a neither a maximal integer neither a even number, because it could be errors with the cards **MAX** and **PAR**. Special cards are built one per one and then are added to the deck before this is sorted.
 
The following modules of Ocaml were used in this file:  

 * [**Pervasives**][P]: for the exceptions and the print outs.
 * [**List**][L].
 * [**Random**][R]: for ramdomly sort the deck.
 * [**String**][S].
   
---
## jugador.ml  
  
In this file the **player** structure was defined with the Ocaml's **records**. A player will have 4 arguments, the name (*string*), an integer for the score  and 2 **deck** lists (one for the cards that the player didn't played and the other for the cards that the player already played).
Well, a player should look like:
   
`{name = "Pampita"; points = 0; cards = [{value = 1; suit = Espada}]; played = empty_deck}`   
   
And then the functions for delivering a card to a player, initialize a player and print their points and played cards where defined.
It was really easy to defined them due to the concept of the Ocaml **Records**.
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









