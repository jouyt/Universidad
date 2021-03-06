/*

%SP_STZCR Short-time zero crossings.
%       [Y,TSCALE] = SP_STZCR(X,FRAME,OVERLAP,FS) computes the
%       short-time zero-crossing rate of X using a frame size
%       of LENGTH and a percentage OVERLAP between successive
%       frames using a rectangular data window.  The sampling
%       frequency is given by FS. The short-time zero-crossing
%       curve is returned in Y and a time scale corresponding
%       to the end of the data frame is returned in TSCALE.
%       The curve may be displayed with the command
%       'plot(y,tscale)'.
%
%       See also: SP_STMAG, SP_STZCR, AVSMOOTH, MDSMOOTH
%
%       SP_STZCR is implemented as a mex function on some
%       installations.

%       LT Dennis W. Brown 7-11-93, DWB 11-11-94
%       Naval Postgraduate School, Monterey, CA
%       May be freely distributed.
%       Not for use in commercial products.

%       Ref: Rabiner & Schafer, Digital Processing of Speech
%       Signals, 1978, ss 4.3, pp 127-130.

*/
#include <math.h>
#include <stdio.h>

#ifdef __TURBOC__
#include "e:\matlab\extern\include\mex.h"
#else
#include "mex.h"
#endif

/* Input Arguments */
#define	X_IN        prhs[0]
#define FRAME_IN    prhs[1]
#define OVERLAP_IN  prhs[2]
#define FS_IN       prhs[3]
#define WINDOW_IN   prhs[4]

/* Output Arguments */
#define	Y_OUT	plhs[0]
#define T_OUT   plhs[1]

#define pi 3.14159265
#define ISSCALAR(x) 	    (max(mxGetM(x),mxGetN(x)) == 1)
#define ISVECTOR(x)         (min(mxGetM(x),mxGetN(x)) == 1)
#define VECT_LENGTH(x)      (max(mxGetM((x)),mxGetN((x))))

#ifdef __UNIX__
#define	max(A, B)	((A) > (B) ? (A) : (B))
#define	min(A, B)	((A) < (B) ? (A) : (B))
#endif

#define sgn(A)      ((A) > 0.0 ? 1 : -1)

#ifdef __STDC__
void stzcr(double y_out[], double t_out[], double x[],
    int N, int L, int Ndiff, int fs)
#else
void stzcr(y_out,t_out,x,N,L,Ndiff,fs)
double  *y_out, *t_out,*x;
int N, L, Ndiff, fs;
#endif
{
    int     i,k,s,last,curr;

    double  toffset = (double)(Ndiff)/fs/2;

    /* windows with overlap */
    for (k = 0; k < L; k++)
    {
        s = k * Ndiff;                              /* start of window */
        if (t_out) t_out[k] = (double)(k * (double)(Ndiff)/fs + toffset);

        last = sgn(x[s]);

        for (i = s+1; i < s+N-1; i++)
        {
            if (last != (curr = sgn(x[i]))) ++y_out[k];
            last = curr;
         }
    }
}

#ifdef __STDC__
void mexFunction(
	int		nlhs,
	Matrix	*plhs[],
	int		nrhs,
	Matrix	*prhs[]
	)
#else
mexFunction(nlhs, plhs, nrhs, prhs)
int nlhs, nrhs;
Matrix *plhs[], *prhs[];
#endif
{
    int             overlap,fs,Ns,N,L,Ndiff;
	double	        *t_out,*y_out,*x,*window,frame;
	unsigned int	m,n;

	/* Check for proper number of arguments */
	if ((nrhs < 4) || (nrhs > 5))
		mexErrMsgTxt("sp_stzcr: Invalid number of input arguments.");

	/* Check the dimensions of X_IN. */
	if (!mxIsNumeric(X_IN) || mxIsComplex(X_IN) ||
		!mxIsFull(X_IN)  || !mxIsDouble(X_IN) ||
		!ISVECTOR(X_IN)) {
		mexErrMsgTxt("sp_stzcr: Input argument \"x\" must be a vector.");
	}

    /* check input args */
    x       = mxGetPr(X_IN);
	Ns      = max(mxGetM(X_IN),mxGetN(X_IN));
    frame   = mxGetScalar(FRAME_IN);
    overlap = (int)mxGetScalar(OVERLAP_IN);
    fs      = (int)mxGetScalar(FS_IN);

    N = (int)(fs * frame);                      /* samples-per-frame */
    Ndiff = (int)(N * (1.0 - (double)(overlap)/100.0));     /* samples between windows */
    L = (Ns-N)/Ndiff;                           /* number of windows */

	/* Create a matrix for the return arguments */
	Y_OUT = mxCreateFull(L, 1, REAL);
    if (nlhs == 2)
        T_OUT = mxCreateFull(L, 1, REAL);

	/* Assign pointers to the output arguments */
	y_out = mxGetPr(Y_OUT);
    if (nlhs == 2)
        t_out = mxGetPr(T_OUT);
    else
        t_out = NULL;

	/* Do the actual computations in a subroutine */
	stzcr(y_out,t_out,x,N,L,Ndiff,fs);
}

