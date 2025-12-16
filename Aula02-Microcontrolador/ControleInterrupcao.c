#include <avr/io.h>

void setup() {
  DDRB |= (1<<5);   // PB5 saída (LED)
  DDRB &= ~(1<<4);  // PB4 entrada (botão)
  PORTB |= (1<<4);  // pull-up interno ativado
}

void loop() {
  if ((PINB & (1<<4)) == (1<<4)) {  
    // Botão solto
    PORTB |= (1<<5);    // LED acende
  } else {
    // Botão pressionado
    PORTB &= ~(1<<5);   // LED apaga
  }

  delay(200);
}



