# Practica 1,  lógica computacional

## Descripción del proyecto

  Un conjunto de reglas del ajedrez(no todas) escritas en el lenguaje Prolog, consigue realizar la lógica computacional de las siguientes reglas:

    *Una pieza se puede mover a una casilla si es que no hay ninguna otra pieza, o si hay una pieza de otro color, y la casilla destino es un movimiento valido segun las reglas de movimiento de la pieza.

    *Una pieza solo se puede mover dentro del rango de columnas que usan las letras "a" - "h", y dentro del rango de filas de la 1 a la 8 inclusivo.

    *Una pieza no se puede mover si es que el rey del mismo color esta en jaque actualmente. (No se considera el bloqueo de jaques con otras piezas, asi que solo se puede mover el rey mientras este en jaque).

    *Los peones se pueden mover una casilla hacia arriba si son blancos, y una casilla hacia abajo si son negros. También, se pueden mover hacia las diagonales izquierda y derecha superior si son blancos e inferior si son negros, pero solo cuando hay una pieza del color opuesto en esas casillas.

    *Las torres se pueden mover cualquier distancia de casillas en el eje vertical u horizontal, pero solo en un eje a la vez, y no puede haber una pieza en el camino hacia el destino.

    *Los alfiles se pueden mover cualquier distancia de casillas hacia cualquier direccion diagonal, y no puede haber una pieza en el camino hacia el destino.

    *Los caballos se pueden mover siguiendo el siguiente patron:
      *Dos casillas hacia arriba o abajo, o dos casillas hacia la izquierda o derecha
      *Una casilla hacia arriba o abajo si es que el movimiento inicial fue horizontal, o una casilla hacia la izquierda o derecha si es que el movimiento inicial fue vertical

    *Las reinas se pueden mover siguiendo las reglas de los alfiles y de las torres.

    *Los reyes se pueden mover hacia cualquier direccion pero solo una casilla.

    *Un rey esta en jaque cuando una pieza del color opuesto tiene un movimiento valido a la casilla donde se encuentra el rey.
















## Información

Las piezas pueden tener los siguientes nombres:
