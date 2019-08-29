#include <iostream>
#include "lunar_rover.hpp"
#include "estrategia_de_excavacion.hpp"

LunarRover::LunarRover() : brazo(BrazoExcavador()) { };

void LunarRover::excavar(EstrategiaDeExcavacion* estrategiaDeExcavacion) {
  std::cout << "~bip bop bip~ lunar rover activando estrategia de excavacion" << std::endl;
  estrategiaDeExcavacion->excavar(this->brazo);
}
