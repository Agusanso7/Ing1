#include <iostream>
#include "brazo_excavador.hpp"

std::string sentidoAString(Sentido s) {
  return s == HORARIO ? "HORARIO" : "ANTI HORARIO";
}

void BrazoExcavador::girar(Sentido sentido, float velocidadRPM , float minutos) {
  std::cout << "girando brazo en sentido " << sentidoAString(sentido)
    << " a velocidad " << velocidadRPM
    << " RPM durante " << minutos << " minutos"
    << std::endl;
}

void BrazoExcavador::cerrarPinza() {
  std::cout << "cerrando pinza" << std::endl;
}
