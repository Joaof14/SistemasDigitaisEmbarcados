#define F_CPU 16000000UL // Defining clock

#include <avr/io.h> // Including library avr
#include <util/delay.h> //Procurar biblioteca
#include <avr/interrupt.h>


ISR (INT0_vect) {
  PORTB ^= (1<<5);
  
}



int main( void ){

    //Setup

    cli(); // Desabilitar todas as interrupções

    DDRB |= (1<<5); //Output
    DDRD &= ~(1<<2); //Input
    PORTD |= (1<<2); //PULL UP Enbale para o PORTD2

    EICRA |= (1 << ISC00); // Habilitando interrupção em qualquer mudança de nível lógico
    EIMSK |= (1 << INT0);

    sei();
    
    while (1) {
      
    }



    //

  return 0;
}



