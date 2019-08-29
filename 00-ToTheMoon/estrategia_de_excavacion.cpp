#include <iostream>
#include "estrategia_de_excavacion.hpp"

void EstrategiaDePisoDuro::excavar(BrazoExcavador& brazo) {
  brazo.girar(HORARIO, 150, 10);
  brazo.cerrarPinza();
  brazo.girar(ANTI_HORARIO, 150, 10);
}

void EstrategiaDePisoBlando::excavar(BrazoExcavador& brazo) {
  brazo.girar(ANTI_HORARIO, 100, 5);
  brazo.cerrarPinza();
  brazo.girar(HORARIO, 100, 10);
}
