# **Ocaml**

### Laboratorio 3   
###### Daniel Bauer, Gonzalo Garcia.   
---
## Introduccion:

El lenguaje Objective CAML, también llamado [Ocaml][O] u O'Caml, el nombre proviene de las siglas en inglés Objective Categorical Abstract Machine Language. Es un lenguaje de programación avanzado de la familia de los lenguajes ML, desarrollado y distribuido por el INRIA en Francia. Ocaml admite los paradigmas de programación imperativa, programación funcional y programación orientada a objetos.
Ocaml nace de la evolución del lenguaje CAML, abreviación de Categorical Abstract Machine Language, al integrársele la programación con objetos.1

El código fuente en Ocaml se compila en código para una máquina virtual o en código de máquina para diferentes arquitecturas. Este último compilador produce código comparable en eficiencia al producido por compiladores como el del lenguaje C/C++.

Ocaml dispone de un análisis de tipos estático con inferencia de tipos, con valores funcionales de primera clase, polimorfismo parametrizado, llamada por patrones, manejo de excepciones, recolección de basura y otras características avanzadas.

![Ocaml.jpg](https://bitbucket.org/repo/77n99n/images/554043533-Ocaml.jpg)

---
## Informacion:

En este laboratorio se desarrollo un juego de cartas españolas, de 2 a 5 jugadores. con las reglas especificadas en [**grupo00**][G].
La organizacion del codigo es igual al del proyecto anterior (/src /bin).  
Para llevar a cabo el Juego, se tuvo que implementar 4 tipos de datos, **card**, **deck**, **player** y **round** para las cartas, barajas ,jugadores y la rondas respectivamente. Donde card y deck estan implementados en **cartas.ml**, jugador en **jugador.mli** y la ronda en **round.ml**, cada archivo su respectivo **.mli**. Y en **main.ml** se lleva a cabo las llamadas de todas las funciones de los archivos.

---
## cartas.ml

En este archivo desarrollamos la estructura de las cartas y la baraja (**cards** y **deck**) con los **records** de **Ocaml**. Definimos a cartas como una estructura de dos campos, un entero por su numero (para que la comparacion sea menos "tediosa" de implementar) y un tipo **suit** para el palo. Entonces una carta seria por ejemplo:   
`carta = {value = 1; suit = Espada}`   
     
![cartas-espanolas.jpg](https://bitbucket.org/repo/77n99n/images/2176868946-cartas-espanolas.jpg)
  
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
[G]:<https://bitbucket.org/paradigmas-programacion-famaf/grupo00/src/c54418431018c1cb652e4278d4f829a2f9cfa3d8/Lab3/consignas.md?at=master&fileviewer=file-view-default>









