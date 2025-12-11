#define F_CPU 16000000UL // Defining clock

#include <avr/io.h> // Including library avr
#include <util/delay.h> //Procurar biblioteca

void on_all(){
  PORTB |= (1<<5) | PORTB | (1<<4) | PORTB | (1<<3) | (1<<2) | (1<<1) | (1<<0);
}
void off_all(){
  PORTB &= ~ ((1<<5) | PORTB | (1<<4) | PORTB | (1<<3) | (1<<2) | (1<<1) | (1<<0));
}

void off_step_unit(){

}

void off_step_unit(){

}

void on_step(){

}

void off_step(){

}

void 

int main( void ){

    //Setup

    DDRB |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1) | (1<<0) ;

    while (1) {
        PORTB |= (1<<5); //Porta PB5 
        _delay_ms(10000);
        PORTB &= ~(1<<5); //Porta PB5 
        _delay_ms(10000);

        PORTB |= (1<<4); //Porta PB4
        _delay_ms(10000);
        PORTB &= ~(1<<4); //Porta PB4
        _delay_ms(10000);

        PORTB |= (1<<3); //Porta PB3
        _delay_ms(10000);
        PORTB &= ~(1<<3); //Porta PB3
        _delay_ms(10000);

        PORTB |= (1<<2); //Porta PB2
        _delay_ms(10000);
        PORTB &= ~(1<<2); //Porta PB2
        _delay_ms(10000);

        PORTB |= (1<<1); //Porta PB1 
        _delay_ms(10000);
        PORTB &= ~(1<<1); //Porta PB1
        _delay_ms(10000);

        PORTB |= (1<<0); //Porta PB0
        _delay_ms(10000);
        PORTB &= ~(1<<0); //Porta PB0
        _delay_ms(10000);
    }

  return 0;
}

