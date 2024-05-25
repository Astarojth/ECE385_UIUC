// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x50; //make a pointer to access the PIO block
	volatile unsigned int *SW_PIO = (unsigned int*)0x20; //TODO
	volatile unsigned int *KEY2_PIO = (unsigned int*)0x40;
	volatile unsigned int *KEY3_PIO = (unsigned int*)0x30;
	// volatile unsigned int *INC_PIO = (unsigned int*)0x60;//TODO for accumulation
    // volatile unsigned int *RESET_PIO = (unsigned int*)0x60; // 11 at start //TODO for reset

	*LED_PIO = 0x00; //clear all LEDs
	unsigned halt = 0; // a halt flag
	unsigned value = 0;
	//volatile unsigned int INC_PIO, RESET_PIO;

	while ( (1+1) != 3) //infinite loop
	{
//		INC_PIO = *KEY_PIO & 0x04;
//		RESET_PIO = *KEY_PIO & 0x02;
//		if (RESET_PIO == 0)
//			*LED_PIO = 0; //clear all LEDs
//		if ((!halt) && INC_PIO == 0){ //TODO (value)
//			*LED_PIO += *SW_PIO;
//			halt = 1;
//		}
//		if (halt && INC_PIO > 0) //TODO (value)
//			halt = 0;
		if(*KEY2_PIO == 0){
			*LED_PIO = 0x00;
			value = 0;
			halt = 0;
		}
		if(*KEY3_PIO == 0 && halt == 0){
			value = value + *SW_PIO;
			*LED_PIO = value;
			halt = 1;
		}
		if(*KEY3_PIO == 1 && halt == 1){
			halt = 0;
		}
	}
	return 1; //never gets here
}
