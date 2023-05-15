/*******************************************************
Project : 
Version :  1.8.0
Date    : 16/01/2023
Author  : 
Company : 
Comments: 


Chip type               : ATmega16A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include <mega16a.h>

void main(void)
{
    // Input/Output Ports initialization
    // Port A initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
    // Port B initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
    PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (1<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
    
    // Port C initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
    DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0 
    PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
    
    // Port D initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
    PORTD=(1<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
    
    while (1)
    {
        if (PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==1||PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 1*/||PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 2*/||PINA.0==1&&PINA.1==0&&PINA.2==0&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 3*/||PINA.0==1&&PINA.1==1&&PINA.2==0&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 4*/||PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 5*/||PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==0&&PINA.6==0/*STATE 6*/||PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==0/*STATE 7*/||PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==1/*STATE 8*/||PINA.0==1&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 9*/||PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==0&&PINA.5==0&&PINA.6==0/*STATE 10*/||PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==0&&PINA.6==0/*STATE 11*/||PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==0/*STATE 12*/||PINA.0==0&&PINA.1==1&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==0/*STATE 13*/||PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==0/*STATE 14*/||PINA.0==1&&PINA.1==0&&PINA.2==1&&PINA.3==0&&PINA.4==1&&PINA.5==0&&PINA.6==1/*STATE 15*/||PINA.0==1&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==0&&PINA.6==1/*STATE 16*/||PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==1&&PINA.4==1&&PINA.5==1&&PINA.6==0/*STATE 17*/)        
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        } 
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==1) // R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==1) // R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=1;
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==0&&PINA.6==0) // R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==1&&PINA.6==0)// R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;   
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==0&&PINA.6==1)// R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;   
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==1&&PINA.6==1)// R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;   
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==1&&PINA.5==1&&PINA.6==0)// R
        {
            PORTB.4=1;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;   
        }
        if (PINA.0==1&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==1&&PINA.1==0&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=1;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==0&&PINA.1==1&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==0&&PINA.1==0&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==1&&PINA.1==0&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==1&&PINA.1==1&&PINA.2==0&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINA.0==0&&PINA.1==1&&PINA.2==1&&PINA.3==0&&PINA.4==0&&PINA.5==0&&PINA.6==0) // Left Station
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=1;
            PORTB.7=0;
        }
        if (PINB.0==1||PINB.1==1)
        {
            PORTB.4=0;
            PORTB.5=0;
            PORTB.6=0;
            PORTB.7=0;
        }
    }
}
