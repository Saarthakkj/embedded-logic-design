#include <stdio.h>
#include <complex.h>
#include <stdlib.h>
#include <math.h>
#include "platform.h"
#include "xil_printf.h"
#include <xtime_l.h>
#include "xparameters.h"
#include "xaxidma.h"
#include "dma_init.h"

#define N 64

// Twiddle factors for FFT_LEN/2
const int rev_64[N] = {0,32,16,48,8,40,24,56,4,36,20,52,12,44,28,60,2,34,18,50,10,42,26,58,6,38,22,54,14,46,30,62,1,33,17,49,9,41,25,57,5,37,21,53,13,45,29,61,3,35,19,51,11,43,27,59,7,39,23,55,15,47,31,63};
const float complex W_64[N/2] = {1.0-0.0*I, 0.9951847266721969-0.0980171403295606*I, 0.9807852804032304-0.19509032201612825*I, 0.9569403357322088-0.29028467725446233*I, 0.9238795325112867-0.3826834323650898*I, 0.881921264348355-0.47139673682599764*I, 0.8314696123025452-0.5555702330196022*I, 0.773010453362737-0.6343932841636455*I, 0.7071067811865476-0.7071067811865475*I, 0.6343932841636455-0.773010453362737*I, 0.5555702330196023-0.8314696123025452*I, 0.4713967368259978-0.8819212643483549*I, 0.38268343236508984-0.9238795325112867*I, 0.29028467725446233-0.9569403357322089*I, 0.19509032201612833-0.9807852804032304*I, 0.09801714032956077-0.9951847266721968*I, 0.0-1.0*I, -0.09801714032956065-0.9951847266721969*I, -0.1950903220161282-0.9807852804032304*I, -0.29028467725446216-0.9569403357322089*I, -0.3826834323650897-0.9238795325112867*I, -0.4713967368259977-0.881921264348355*I, -0.555570233019602-0.8314696123025455*I, -0.6343932841636454-0.7730104533627371*I, -0.7071067811865475-0.7071067811865476*I, -0.773010453362737-0.6343932841636455*I, -0.8314696123025453-0.5555702330196022*I, -0.8819212643483549-0.47139673682599786*I, -0.9238795325112867-0.3826834323650899*I, -0.9569403357322088-0.2902846772544624*I, -0.9807852804032304-0.1950903220161286*I, -0.9951847266721968-0.09801714032956083*I};

void bitreverse(float complex dataIn[N], float complex dataOut[N]){
		for (int i=0; i<N; i++){
			dataOut[i]=dataIn[rev_64[i]];
		}
}


void FFT_stages(float complex FFT_input[N], float complex FFT_output[N]){
    float complex temp1[N], temp2[N], temp3[N], temp4[N], temp5[N];

    int i = 0;
    while (i < N) {
        temp1[i] = FFT_input[i] + FFT_input[i + 1];
        temp1[i + 1] = FFT_input[i] - FFT_input[i + 1];
        i += 2;
    }

    i = 0;
    while (i < N) {
        int j = 0;
        while (j < 2) {
            temp2[i + j] = temp1[i + j] + W_64[16 * j] * temp1[i + j + 2];
            temp2[i + j + 2] = temp1[i + j] - W_64[16 * j] * temp1[i + j + 2];
            j++;
        }
        i += 4;
    }

    i = 0;
    while (i < N) {
        int j = 0;
        while (j < 4) {
            temp3[i + j] = temp2[i + j] + W_64[8 * j] * temp2[i + j + 4];
            temp3[i + j + 4] = temp2[i + j] - W_64[8 * j] * temp2[i + j + 4];
            j++;
        }
        i += 8;
    }

    i = 0;
    while (i < N) {
        int j = 0;
        while (j < 8) {
            temp4[i + j] = temp3[i + j] + W_64[4 * j] * temp3[i + j + 8];
            temp4[i + j + 8] = temp3[i + j] - W_64[4 * j] * temp3[i + j + 8];
            j++;
        }
        i += 16;
    }

    i = 0;
    while (i < N) {
        int j = 0;
        while (j < 16) {
            temp5[i + j] = temp4[i + j] + W_64[2 * j] * temp4[i + j + 16];
            temp5[i + j + 16] = temp4[i + j] - W_64[2 * j] * temp4[i + j + 16];
            j++;
        }
        i += 32;
    }

    i = 0;
    while (i < N / 2) {
        FFT_output[i] = temp5[i] + W_64[i] * temp5[i + 32];
        FFT_output[i + 32] = temp5[i] - W_64[i] * temp5[i + 32];
        i++;
    }


    i = 0;
    while (i < N) {
        FFT_output[i] = (1.0 / crealf(FFT_output[i])) + ((1.0 / cimagf(FFT_output[i])) * I);
        i++;
    }

}


int main(){

	XTime PS_start_time;
	XTime PS_end_time;
	XTime PL_start_time;
	XTime PL_end_time;
	float time;
    int status;

	const float complex FFT_input[N] = {
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
		     1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I,
			 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I, 1.0 + 1.0*I};
	float complex FFT_input2[N] ;
	int l = 0;
	    while (l < N) {
	        FFT_input2[l] = (1.0 / crealf(FFT_input[l])) + ((1.0 / cimagf(FFT_input[l])) * I);
	        l++;
	    }

	float complex FFT_output_sw[N], FFT_output_hw[N];
	float complex FFT_rev[N];

    XTime_SetTime(0);
    XTime_GetTime(&PS_start_time);
    bitreverse(FFT_input2, FFT_rev);
    FFT_stages(FFT_rev, FFT_output_sw);
    XTime_GetTime(&PS_end_time);
    XAxiDma AxiDMA;
    status = DMA_Init(&AxiDMA, XPAR_AXI_DMA_0_DEVICE_ID);
    if (status){
    	return 1;}
    XTime_SetTime(0);
	XTime_GetTime(&PL_start_time);
	status= XAxiDma_SimpleTransfer(&AxiDMA,(UINTPTR)FFT_output_hw,(sizeof(float complex)*N),XAXIDMA_DEVICE_TO_DMA);
	status= XAxiDma_SimpleTransfer(&AxiDMA,(UINTPTR)FFT_input,(sizeof(float complex)*N),XAXIDMA_DMA_TO_DEVICE);
	while(XAxiDma_Busy(&AxiDMA,XAXIDMA_DMA_TO_DEVICE)){
		//printf("\n\rDMA-To-Device Transfer Done!");
	}
	while(XAxiDma_Busy(&AxiDMA,XAXIDMA_DEVICE_TO_DMA)){
		//printf("\n\rDevice-To-DMA Transfer Done!");
	}
	XTime_GetTime(&PL_end_time);

	for(int i=0;i<N;i++){
		printf("\n\r PS Output: %f+%fI, PL Output: %f+%fI", crealf(FFT_output_sw[i]), cimagf(FFT_output_sw[i]), crealf(FFT_output_hw[i]), cimagf(FFT_output_hw[i]));
		float diff1=abs(crealf(FFT_output_sw[i]) - crealf(FFT_output_hw[i]));
		float diff2=abs(cimagf(FFT_output_sw[i]) - cimagf(FFT_output_hw[i]));
		if (diff1>=0.001 && diff2>=0.001){
			printf("\n\r    Data Mismatch found at index %d !",i);
			break;
		}
		else{
			printf("\r    DMA Transfer Successful!");
		}
	}

	printf("\n\r--------------------Execution Time Comparison--------------------");
	time= 0;
	time= (float)1.0 * (PS_end_time-PS_start_time)/(COUNTS_PER_SECOND/1000000);
	printf("\n\rExecution time for PS in Micro-seconds: %f",time);
	time= 0;
	time= (float)1.0 * (PL_end_time-PL_start_time)/(COUNTS_PER_SECOND/1000000);
	printf("\n\rExecution time for PL in Micro-seconds: %f",time);

	return 0;
}
