
int N=5000, M=500, P=500;

//number of complex basis functions.
int N_b=5000;
//complex number.
class complex{
  float k= 0.0, A=10.0;
  int n=10;
  float []x;
  float []y;
  
  complex(int n,float k, float A){
    this.n=n;
    this.k=k;
    this.A=A;
    x= new float[n];
    y= new float[n];
    
    for(int i=0;i<n;i++){
      this.x[i] = cos(k*(float(i)/n-1.0/2.0)); 
      this.y[i] = sin(k*(float(i)/n-1.0/2.0)); 
    }
  }
  
  void timeEvolve(float t){
   float w=0.5*k;
   for(int i=0;i<n;i++){
      this.x[i] = cos(k*(float(i)/n-0.0/2.0)-w*t); 
      this.y[i] = sin(k*(float(i)/n-0.0/2.0)-w*t); 
    }
  }
  
  void showRe(){
    stroke(0,0,180);
    strokeWeight(4);
    for(int i=0;i<n-1;i++){
      line(i,height/2+A*x[i],i+1, height/2+A*x[i+1]);
      
    }
    noStroke();
    strokeWeight(0);
  }
  void showIm(){
    stroke(180,0,0);
    strokeWeight(4);
    for(int i=0;i<n-1;i++){
      line(i, height/2+A*y[i],i+1,height/2+ A*y[i+1]);
    }
    noStroke();
    strokeWeight(0);
  }
  
}
//complex basis.
complex [] basis = new complex[N];

complex sum;

int n=1000;

//x-axis.
float [] x     = new float[N];
//k-axis, and w
float [] k     = new float[N];
float [] w     = new float[N];
//position wavefuntion.
float [] psi   = new float[N];
//momentum wavefunction.
float [] phi   = new float[N];
//amplitudes.(not used yet).
float [] A     = new float[N];
//time.
float t        = 0.0;
//group velocity.
float v_g      = 0.0; 

int idx=0;

void setup(){
  
  size(1000,800,P2D);
  smooth(20);
  
  //generate x-axis.
  for(int i=0;i<N;i++){
    x[i]=float(i)/N-1.0/2.0;
  }
  //generate k-axis, phi and basis sinesoidal.
  for(int i=0;i<N;i++){
    k[i]=2*PI*float(i)/N-2*PI*1.0/2.0+2*PI*v_g/2.0;
    w[i]=0.5*k[i]*k[i]; 
    psi[i]=0.0;
    phi[i]=1.0*exp(-pow(20.0*k[i],2)/50000);//*cos(k[i]*20.0);
    basis[i]= new complex(n,20.0*k[i], 200.0); 
  }
  
  sum  = new complex(n, 20.0, -100.0);
  complex_basis(n);

}


void draw(){
  background(0);
  t=t+0.001;
  
  idx=idx+5;
 // momentum();
  //waveform();
  
  //basis[idx].showRe();
  //basis[idx].showIm();
  //evolve(t);


  
  
  sum.showRe();
 
  
  //render_phi(200.0);
  //render_psi();
  //println(cos(t));


}

void evolve(float t){
  for(int i=0;i<N;i++){
     basis[i].timeEvolve(t);
  }
}


void waveform(){
  float psi_accum=0.0;
  for(int i=0;i<N;i++){
    for(int j=0;j<N;j++){
       psi_accum+= phi[j]*cos(20.0*k[j]*x[i]-w[i]*t);
    }
    psi[i] = 5.0/sqrt(N)*psi_accum;//}
    psi_accum=0.0;
  }
  
}


void render_psi(float A){
   strokeWeight(5);
   stroke(31, 199, 224);
  for(int i=0;i<N-1;i++){ 
      line(i,300 -A*psi[i], i+1, 300-A*psi[i+1]);
    
  }
  noStroke();
  strokeWeight(0);
}

void render_phi(float A){
  strokeWeight(5);
   stroke(31, 199, 224);
   
  for(int i=0;i<n-1;i=i+1){ 
     //centering the data frame.
      line(i, 700-A*phi[i+N/2-N/10], i+1, 700-A*phi[i+N/2-N/10+1]);
  }
  noStroke();
  strokeWeight(0);
}



//creates a large number of exp(i(kx-wt)) basis functions.
void complex_basis(int n){
  float x_accum=0.0, y_accum=0.0, norm=0.0;
   for(int i=0;i<n;i++){
     for(int j=0;j<N;j++){
       x_accum+= phi[j]*basis[j].x[i];
       y_accum+= phi[j]*basis[j].y[i];
     }
     
     sum.x[i]=1.0/float(n)*x_accum;
     x_accum=0.0;
   }
    
}  
