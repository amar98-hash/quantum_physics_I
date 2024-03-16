
int N=500, M=500, P=500;

float [] psi = new float[N];
float [] k   = new float[P];
float [] phi   = new float[P];
float [] A   = new float[P];

float t=0.0;

void setup(){
  
  size(1000,1000,P2D);
  
  for(int i=0;i<N;i++){
    psi[i]=0.0;
  }
  for(int i=0;i<P;i++){
    k[i]= 2*PI*float(i)/P+2*PI*2.0/2.0;
    phi[i]=1.0*exp(-pow(k[i],2)/300.0);//*sin(k[i]*20.0);
  }
}


void draw(){
  background(0);
  t=t+1;
 // momentum();
  waveform();
  
  render_phi();
  render_psi();
  //println(cos(t));



}


void waveform(){
  float w=0.0,x=0.0, psi_accum=0.0;
  for(int i=0;i<N;i++){
    x=float(i)/N;//-1.0/2.0;
    
    for(int j=0;j<P;j++){
       w=0.03*k[j]*k[j];
       
       psi_accum+= phi[j]*cos(20.0*k[j]*x-w*t);
    }
    
    //if(0.1*psi_accum<10.0){
    //  psi[i]=0.0;
    //}
    //else{
    psi[i] =0.3*psi_accum;//}
    psi_accum=0.0;
  }
  
}


void render_psi(){
   strokeWeight(8);
   stroke(0,180,0);
  for(int i=0;i<N-1;i++){ 
      line(i,300 -psi[i], i+1, 300-psi[i+1]);
    
  }
  noStroke();
  strokeWeight(0);
}

void render_phi(){
  strokeWeight(8);
   stroke(180,180);
   
  for(int i=0;i<P-1;i++){ 
     
      line(i, 700-200*phi[i], i+1, 700-200*phi[i+1]);
  }
  noStroke();
}
