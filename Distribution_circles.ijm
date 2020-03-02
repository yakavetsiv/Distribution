macro "spheroids_penetration_profile" {
	
//getting the position of drawn ellipse
  Roi.getBounds(x0,y0,w0,h0);

//calculating of the ellipse center 
xx=x0+w0/2;
yy=y0+h0/2;

//resolution of profile (the number of nested circles)
n=100;

//initialization of arrays
a=newArray(n);
s=newArray(n);
s1=newArray(n);
a1=newArray(n);
ss=newArray(n);

//calculation of increments
hi=(h0/2)/n;
wi=(w0/2)/n;

//calculation of total fluorescnce signal and pixels area from each nested circle
 for (i=n; i>=1; i-=1){ 
makeOval(xx-wi*i,yy-hi*i,wi*2*i,hi*2*i);
getStatistics(area, mean);
s[i-1]=mean*area;
a[i-1]=area;
 }

//calculation of total intensity and area of the rims (between circles)
for (i=n-1; i>=1; i-=1){ 
s1[i]=s[i]-s[i-1];
a1[i]=a[i]-a[i-1];
}

//caclulation of mean fluorescnce intensity of the rims
s1[0]=s[0];
a1[0]=a[0];
 for (i=n-1; i>=0; i-=1){ 
ss[i]=s1[i]/a1[i]; 
}

//plotting of the result profile
Plot.create("","r","Int",ss);
makeOval(x0,y0,w0,h0);}