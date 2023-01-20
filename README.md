![50bac139-8d46-4d35-b5c6-c44adce6e47c](https://user-images.githubusercontent.com/89896245/213158574-3d1100ea-e519-45a5-ba69-07a7c2c0a925.jpg)
# hi 
# Line tracking robot project with full schematic and simulation source

more :
_________________________________________________________________________________________________
- Project : Line tracking robot
- Version :  1.8.0
- Date    : 16/01/2023
- Author  : 
- Company : 
- Comments: 


- Chip type               : ATmega16A
- Program type            : Application
- AVR Core Clock frequency: 8.000000 MHz
- Memory model            : Small
- External RAM size       : 0
- Data Stack size         : 256
____________________________________________________________________________________________________
- The robot consisting of two motors and the L298 driver and OpAmp for ADC system and AVR micro controller
# Driver Module
   - Ports IN1,IN2,IN3,IN4 respectively to C0,C1,C2,C3 are connected
   - to the Port sensA and sensB connected Potentiometer
   - ENA and ENB connect to the OCR Ports (OC0 && OC2)  


![Untitled1](https://user-images.githubusercontent.com/89896245/212749448-6a79b9ae-f06f-4f61-acb9-70e2f11b0284.png)


# Motors and fitting  


![Untitled1](https://user-images.githubusercontent.com/89896245/212750358-b56a67dd-4282-4dd8-8bce-eb06029e4da8.png)


 # sensors Module
 
 
 ![Untitled1](https://user-images.githubusercontent.com/89896245/212750704-c647044e-7811-461b-992e-f0552fa00473.png)
 
 
 - Sensos : 7 
 - OpAmp IC : lm324
 
 # Power Module
 
![Untitled](https://user-images.githubusercontent.com/89896245/212749060-8a96c931-2624-4051-a899-96c31d28dfd9.png)

- consisting of two parts to generate the required voltage
 
  - 7805 regulator to generate VCC voltage 
  - 7812 regulator to generate Vs voltage
 
# سلام (پروژه ربات تعقیب خط به همراه سورس کامل شماتیک و شبیه سازی) 

# توضیحات بیشتر:
- پردازنده : ATmega16 A 
- کلاک : 8.000000 MHz
- اندازه حافظه فلش : 256
 __________________________________________________________________________________________________________
- ربات تشکیل شده از دو موتور و درایور L298 به پایه های sens1 و sens2 پاتنسیومتری جهت کنترل سرعت موتور ها بسته شده است
    - پایه های ENA , ENB به ترتیب به پایه های OC0 , OC2 متصل شده است

![Untitled1](https://user-images.githubusercontent.com/89896245/212749448-6a79b9ae-f06f-4f61-acb9-70e2f11b0284.png)

- موتور ها و اتصالات

![Untitled1](https://user-images.githubusercontent.com/89896245/212750358-b56a67dd-4282-4dd8-8bce-eb06029e4da8.png)


- تعداد سنسور ها : 7 عدد
    - عمل ADC را با Op-Am و IC lm324 به انجام رسیده است
    - وبا یک سوکت مخابراتی از روی برد جدا شده به برد اصلی متصل میشود

![Untitled1](https://user-images.githubusercontent.com/89896245/212750704-c647044e-7811-461b-992e-f0552fa00473.png)


- دو ماژول منبع تغذیه برای تولید ولتاژ  Vcc , Vs , GND 
    - با دو رگولاتور L7805 , L7812

![Untitled](https://user-images.githubusercontent.com/89896245/212749060-8a96c931-2624-4051-a899-96c31d28dfd9.png)
