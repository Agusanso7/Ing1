#ifndef _ESTRATEGIA_DE_EXCAVACION_H_
#define _ESTRATEGIA_DE_EXCAVACION_H_

#include "brazo_excavador.hpp"

class EstrategiaDeExcavacion {
  public: 
  virtual void excavar(BrazoExcavador& brazo) = 0;
  virtual ~EstrategiaDeExcavacion() {};
};

class EstrategiaDePisoDuro : public EstrategiaDeExcavacion {
  public: 
  void excavar(BrazoExcavador& brazo);
};

class EstrategiaDePisoBlando : public EstrategiaDeExcavacion {
  public: 
  void excavar(BrazoExcavador& brazo);
};

class EstrategiaDePisoIntermedio : public EstrategiaDeExcavacion {
  public: 
  void excavar(BrazoExcavador& brazo);
};

#endif
