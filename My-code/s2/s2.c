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

#include <mega16.h>
#include <delay.h>

void Front_M (void);
void Left_M (void);
//void Fast_Left_M (void);
//void Right_M (void);
//void Fast_Right_M (void);

void main(void)
{
      // Declare your local variables here

      // Input/Output Ports initialization
      // Port A initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
      DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
      
      
      
      // Port B initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=In Bit1=In Bit0=In 
      DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (1<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=T Bit1=T Bit0=T 
      PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

      // Port C initialization
      // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
      DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
      // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0 
      PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

      // Port D initialization
      // Function: Bit7=Out Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
      DDRD=(1<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
      // State: Bit7=0 Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
      PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

      // Timer/Counter 0 initialization
      // Clock source: System Clock
      // Clock value: 8000.000 kHz
      // Mode: Fast PWM top=0xFF
      // OC0 output: Non-Inverted PWM
      // Timer Period: 0.032 ms
      // Output Pulse(s):
      // OC0 Period: 0.032 ms Width: 0 us
      TCCR0=(1<<WGM00) | (1<<COM01) | (0<<COM00) | (1<<WGM01) | (0<<CS02) | (0<<CS01) | (1<<CS00);
      TCNT0=0x00;
      OCR0=0x00;

      // Timer/Counter 2 initialization
      // Clock source: System Clock
      // Clock value: 8000.000 kHz
      // Mode: Fast PWM top=0xFF
      // OC2 output: Non-Inverted PWM
      // Timer Period: 0.032 ms
      // Output Pulse(s):
      // OC2 Period: 0.032 ms Width: 0 us
      ASSR=0<<AS2;
      TCCR2=(1<<PWM2) | (1<<COM21) | (0<<COM20) | (1<<CTC2) | (0<<CS22) | (0<<CS21) | (1<<CS20);
      TCNT2=0x00;
      OCR2=0x00;

      // Timer(s)/Counter(s) Interrupt(s) initialization
      TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

      // Analog Comparator initialization
      // Analog Comparator: Off
      // The Analog Comparator's positive input is
      // connected to the AIN0 pin
      // The Analog Comparator's negative input is
      // connected to the AIN1 pin
      ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
      SFIOR=(0<<ACME);

      while (1)
      {
            Front_M();
            delay_ms(100);
            Left_M();
      }
}

void Front_M (void)
{
      PORTC=(0<<PORTC3) | (1<<PORTC2) | (0<<PORTC1) | (1<<PORTC0); 
      OCR0=255;
      OCR2=255;    
}

void Left_M (void)
{
      PORTC=(0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (1<<PORTC0); 
      OCR0=255;
      OCR2=0;         
}