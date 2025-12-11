#define F_CPU 16000000UL // Defining clock

#include <avr/io.h> // Including library avr
#include <util/delay.h> //Procurar biblioteca

int main( void ){

    //Setup

    DDRB |= (1<<5);

    while (1) {
        PORTB |= (1<<5); //Porta PB5 
        _delay_ms(500);
        PORTB &= ~(1<<5); //Porta PB5 
        _delay_ms(500);
    }

  return 0;
}

