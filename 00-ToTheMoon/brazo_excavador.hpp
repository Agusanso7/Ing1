#ifndef _BRAZO_EXCAVADOR_H_
#define _BRAZO_EXCAVADOR_H_

enum Sentido { HORARIO, ANTI_HORARIO };

class BrazoExcavador {
  public:
  void girar(Sentido sentido, float velocidadRPM , float minutos);
  void cerrarPinza();
};

#endif
