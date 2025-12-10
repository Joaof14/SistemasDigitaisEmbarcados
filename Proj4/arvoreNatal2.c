#define F_CPU 16000000UL // Defining clock

#include <avr/io.h> // Including library avr
#include <util/delay.h> //Procurar biblioteca

/* árvore de natal em piramide com 6 leds distribuidos em 3 camadas em 3-2-1 */

void setup() {
  DDRB |=  (1<<4) | (1<<3) | (1<<2) | (1<<1) | (1<<0) ;

}


void on_all(){
  PORTB |=  (1<<4) | (1<<3) | (1<<2) | (1<<1) | (1<<0);
}
void off_all(){
  PORTB &= ~ (  (1<<4) | (1<<3) | (1<<2) | (1<<1) | (1<<0) );
}


void layers_unit(){

     //Camada 1
    PORTB |= (1<<0) | (1<<1);
    _delay_ms(500);
    PORTB &= ~( (1<<0) | (1<<1));
    _delay_ms(500);

    //Camada 2
    PORTB |= (1<<3) | (1<<2);
    _delay_ms(500);
    PORTB &= ~( (1<<3) | (1<<2) );
    _delay_ms(500);

    //Camada 3
    PORTB |=  (1<<4);
    _delay_ms(500);
    PORTB &= ~  (1<<4);
    _delay_ms(500);


}

void layers_cummulat(){
    //Camada 1
    PORTB |= (1<<0) | (1<<1) ;
    _delay_ms(500);

    //Camada 2
    PORTB |= (1<<3) | (1<<2) ;
    _delay_ms(500);
    

    //Camada 3
    PORTB |=   (1<<4);
    _delay_ms(500);
    
}


int main( void ){

    //Setup

    DDRB |= (1<<5) | (1<<4) | (1<<3) | (1<<2) | (1<<1) | (1<<0) ;

    while (1) {

        //Ligar e desligar todos de uma vez
        on_all();
        _delay_ms(10000);
        off_all();
        _delay_ms(10000);

        //Ligar e desligar por camadas unitaria
        layers_unit();

        //Ligar por camadas permancendo estado anterior e depois desligar tudo
        layers_cummulat();
        off_all();

        
        

        
        _
        
    }

  return 0;
}

