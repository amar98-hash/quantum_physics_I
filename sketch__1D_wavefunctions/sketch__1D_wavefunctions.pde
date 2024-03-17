
int N=500, M=500, P=500;

//number of complex basis functions.
int N_b=5000;
//complex number.
class complex{
  float []x= new float[N_b];
  float []y= new float[N_b];
  float k= 0.0, A=10.0;
  
  complex(float k, float A){
    this.k=k;
    this.A=A;
    for(int i=0;i<N_b;i++){
      this.x[i] = cos(k*(float(i)/N-1.0/2.0)); 
      this.y[i] = sin(k*(float(i)/N-1.0/2.0)); 
    }
  }
  
  void showRe(){
    stroke(0,0,180);
    strokeWeight(4);
    for(int i=0;i<N_b-1;i++){
      line(i,200+ A*x[i],i+1, 200+A*x[i+1]);
      
    }
    noStroke();
    strokeWeight(0);
  }
  void showIm(){
    stroke(180,0,0);
    strokeWeight(4);
    for(int i=0;i<N_b-1;i++){
      line(i, 200+A*y[i],i+1,200+ A*y[i+1]);
    }
    noStroke();
    strokeWeight(0);
  }
  
}
//complex basis.
complex [] basis = new complex[N];

//x-axis.
float [] x     = new float[N];
//k-axis, and w
float [] k     = new float[N];
float [] w     = new float[N];
//position wavefuntion.
float [] psi   = new float[N];
//momentum wavefunction.
float [] phi   = new float[P];
//amplitudes.(not used yet).
float [] A     = new float[P];
//time.
float t        = 0.0;
//group velocity.
float v_g      = 1.0; 

void setup(){
  
  size(500,500,P2D);
  smooth(20);
  
  //generate x-axis.
  for(int i=0;i<N;i++){
    x[i]=float(i)/N-1.0/2.0;
  }
  //generate k-axis.
  for(int i=0;i<N;i++){
    k[i]=2*PI*float(i)/N-2*PI*1.0/2.0+2*PI*v_g/2.0;
    w[i]=0.5*k[i]*k[i];
    
    basis[i]= new complex(k[i], 100.0);
    
    
  }
 
  for(int i=0;i<2;i++){
    
  }

  for(int i=0;i<N;i++){
    psi[i]=0.0;
    phi[i]=1.0*exp(-pow(k[i],2)/300.0);//*sin(k[i]*20.0);
  } 
}


void draw(){
  background(0);
  t=t+0.01;
 // momentum();
  waveform();
  
  basis[1].showRe();
  basis[1].showIm();
  
  basis[0].showRe();
  basis[0].showIm();
  
  //render_phi();
  //render_psi();
  //println(cos(t));



}


void waveform(){
  float psi_accum=0.0;
  for(int i=0;i<N;i++){
    for(int j=0;j<N;j++){
       psi_accum+= phi[j]*cos(20.0*k[j]*x[i]-w[i]*t);
    }
    
    //if(0.1*psi_accum<10.0){
    //  psi[i]=0.0;
    //}
    //else{
    psi[i] = 5.0/sqrt(N)*psi_accum;//}
    psi_accum=0.0;
  }
  
}


void render_psi(){
   strokeWeight(5);
   stroke(31, 199, 224);
  for(int i=0;i<N-1;i++){ 
      line(i,300 -psi[i], i+1, 300-psi[i+1]);
    
  }
  noStroke();
  strokeWeight(0);
}

void render_phi(){
  strokeWeight(5);
   stroke(31, 199, 224);
   
  for(int i=0;i<P-1;i++){ 
     
      line(i, 700-200*phi[i], i+1, 700-200*phi[i+1]);
  }
  noStroke();
  strokeWeight(0);
}



//creates a large number of exp(i(kx-wt)) basis functions.
void complex_basis(float k,float w){
 
}
