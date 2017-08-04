OCC = ocamlc
OCO = ocamlopt 

all: cons main.ml clean

.PHONY : src/%.mli
	  $(OCC) -c $<

main.ml :
	cd src; $(OCC) -c cartas.mli jugador.mli ronda.mli; $(OCO) -o juego cartas.ml jugador.ml ronda.ml main.ml; mv juego ../bin/

.PHONY : clean
clean :
	rm -f *~ *# *.byte .#*; rm -f src/*.cmx src/*.cmi src/*.o; rm -rf bin

.PHONY : cons
cons :
	mkdir bin
