#include <avr/io.h> // Including library avr
#include <util/delay.h> //Procurar biblioteca

int main( void ){

    //Setup

    DDRB |= (1<<5); //Output
    DDRB &= ~(1<<4); //Input
    PORTB |= (1<<4); //PULL UP Enbale para o PORTB4
    while (1) {

      if (  ( (PINB) & (1<<4) ) == (1<<4) ) { //Entrada PD2 em nível lógico alto
        PORTB |= (1<<5); 
      }
      else {
        PORTB &= ~(1<<5); 
      }

      _delay_ms(750);
    }

  return 0;
}

