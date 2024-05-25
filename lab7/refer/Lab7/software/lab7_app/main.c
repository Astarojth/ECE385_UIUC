// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int pressed = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x40; //make a pointer to access the PIO block
	volatile unsigned int *KEY2 = (unsigned int*)0x60; //reset
	volatile unsigned int *KEY3 = (unsigned int*)0x80; //accumulate
	volatile unsigned int *Switch = (unsigned int*)0x70;
	*LED_PIO = 0; //clear all LEDs
	volatile unsigned int sum = 0;

	while ( (1+1) != 3) //infinite loop
	{
		//for (i = 0; i < 100000; i++); //software delay
		//*LED_PIO |= 0x1; //set LSB
		//for (i = 0; i < 100000; i++); //software delay
		//*LED_PIO &= ~0x1; //clear LSB
		if(*KEY2 == 0){
			sum = 0;
		}
		if(*KEY3 == 0 && pressed == 0){
			sum += *Switch;
			if (sum > 255)  //Check for overflow
				sum -= 256;
			pressed = 1;
		}
		if(*KEY3 == 1){
			pressed = 0;
		}
		*LED_PIO = sum;
	}
	return 1; //never gets here
}
