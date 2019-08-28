#ifndef _LUNAR_ROVER_H_
#define _LUNAR_ROVER_H_

#include "brazo_excavador.hpp"
#include "estrategia_de_excavacion.hpp"

class LunarRover {
  BrazoExcavador brazo;

  public:
  void excavar(EstrategiaDeExcavacion& estrategiaDeExcavacion);
};

#endif
