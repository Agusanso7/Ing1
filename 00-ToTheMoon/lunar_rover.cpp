#include <iostream>
#include "lunar_rover.hpp"
#include "estrategia_de_excavacion.hpp"

LunarRover::LunarRover() : brazo(BrazoExcavador()) { };

void LunarRover::excavar(EstrategiaDeExcavacion& estrategiaDeExcavacion) {
  estrategiaDeExcavacion.excavar(this->brazo);
}
