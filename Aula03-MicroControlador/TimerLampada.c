#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t count = 0;
volatile uint8_t estado = 0;

ISR(TIMER0_COMPA_vect)
{
    count++;

    if (estado == 0 && count >= 2000) {
        PORTB |= (1 << PB5);
        estado = 1;
        count = 0;
    }
    else if (estado == 1 && count >= 3000) {
        PORTB &= ~(1 << PB5);
        estado = 0;
        count = 0;
    }
}

int main(void)
{
    cli();

    DDRB |= (1 << PB5);
    PORTB &= ~(1 << PB5);

    TCCR0A = (1 << WGM01);
    TCCR0B = (1 << CS01) | (1 << CS00); // prescaler 64

    OCR0A = 249;
    TCNT0 = 0;

    TIMSK0 = (1 << OCIE0A);

    sei();

    while (1) {;}
}