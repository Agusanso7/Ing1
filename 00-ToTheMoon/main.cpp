#include <iostream>
#include "lunar_rover.hpp"
#include "estrategia_de_excavacion.hpp"

int main(int argc, const char* argv[]) {
  if(argc != 2) {
    std::cerr << "uso: [DURO|INTERMEDIO|BLANDO]" << std::endl;
    return -1;
  }

  std::string tipoDePiso(argv[1]);
  EstrategiaDeExcavacion* estrategia;

  if(tipoDePiso == "DURO") {
    estrategia = new EstrategiaDePisoDuro();
  } else if(tipoDePiso == "BLANDO") {
    estrategia = new EstrategiaDePisoBlando();
  } else if(tipoDePiso == "INTERMEDIO") {
    estrategia = new EstrategiaDePisoIntermedio();
  } else {
    std::cerr << "piso invalido" << std::endl;
    return -1;
  }

  LunarRover rover;
  rover.excavar(estrategia);

  delete(estrategia);
  return 0;
}
