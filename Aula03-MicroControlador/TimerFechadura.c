#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

#define FECHADURA PB5

volatile uint16_t count = 0;
volatile uint8_t estado = 0;  
// 0 = desacionada
// 1 = acionada

ISR(TIMER0_COMPA_vect)
{
    count++;

    //fechadura desligada por 2s
    if (estado == 0 && count >= 2000) {
        PORTB |= (1 << FECHADURA);  // aciona fechadura
        estado = 1;
        count = 0;
    }
    //fechadura acionada por 300ms
    else if (estado == 1 && count >= 300) {
        PORTB &= ~(1 << FECHADURA); // desaciona
        estado = 0;
        count = 0;
    }
}

int main(void)
{
    cli();

    //saída da fechadura
    DDRB |= (1 << FECHADURA);
    PORTB &= ~(1 << FECHADURA);  // começa desligada

    //TIMER0 - CTC
    TCCR0A = (1 << WGM01);
    TCCR0B = (1 << CS01) | (1 << CS00); // prescaler = 64

    OCR0A = 249;  // 1 ms
    TCNT0 = 0;

    //interrupção por comparação
    TIMSK0 = (1 << OCIE0A);

    sei();

    while (1) {
    }
}