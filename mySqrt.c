#include <stdio.h>
#include <stdlib.h>

double mySqrt(double n){
	double x, newX, cond;
	unsigned rep = 1000;

	if(n < 0.0001){
		return 0.0;
	} else {
		x = n;
		while(rep--){
			newX = 0.5*(x + n/x);
			cond = (x - newX);
			if(cond < 0.0001) return newX;
			x = newX;
		}
	}
}

int main(){
	double n;

	scanf("%lf%*c", &n);
	printf("%lf\n", mySqrt(n));

	return 0;
}