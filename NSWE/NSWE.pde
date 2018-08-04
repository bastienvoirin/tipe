float x, y, alpha, beta, alphasq, betasq, lambda, asq, bsq, u, v;
float[] pos = new float[2];
int t;

void setup() {
  size(800, 800);
  rectMode(CORNERS);
  stroke(0);
  fill(0);
  erase();
}

void draw() {

}

void mouseDragged() {
  mousePressed();
}

void mousePressed() {
  erase();
  
  // Conversion des coordonnées (changement de repère)
  x = (mouseX - 400.0) / 400.0;
  y = (400.0 - mouseY) / 400.0;
  
  // Calcul de (alpha, bêta)
  alpha = (dist(-1.0, 0.0, x, y) - dist(1.0, 0.0, x, y)) / 2.0;
  beta  = (dist(0.0, -1.0, x, y) - dist(0.0, 1.0, x, y)) / 2.0;
  
  // Visualisation de (alpha, bêta)
  fill(0);
  rect(400.0, 398.0, (alpha + 1.0)*400.0, 402.0);
  rect(398.0, 400.0, 402.0,  (1.0 - beta)*400.0);
  
  // Calcul de (x, y)
  pos = solve(alpha, beta);
  x = pos[0];
  y = pos[1];
  
  ellipse((x + 1.0)*400.0, (1.0 - y)*400.0, 10.0, 10.0);
  
  // Tracé des branches d'hyperboles
  hyperbolas(alpha, beta);
}

float[] solve(float a, float b) {
  asq = a * a;
  bsq = b * b;
   
  lambda = (2 * asq * bsq) / (1 - asq - bsq);
  
  pos[0] = a * sqrt(1 + bsq + lambda); // x
  pos[1] = b * sqrt(1 + asq + lambda); // y
  
  return pos;
}

void erase() {
  background(255); // Fond blanc
  
  line(  0, 400, 800, 400); // Axe des abscisses
  line(400,   0, 400, 800); // Axe des ordonnées
  
  ellipse(400.0,   0.0, 10.0, 10.0); // N
  ellipse(400.0, 800.0, 10.0, 10.0); // S
  ellipse(  0.0, 400.0, 10.0, 10.0); // W
  ellipse(800.0, 400.0, 10.0, 10.0); // E
}

void hyperbolas(float a, float b) {
  asq = a * a;
  bsq = b * b;
  
  for(t = -400; t < 400; t++) {
    // Branche d'hyperbole définie par W(-1,0), E(1,0) et alpha
    v = t / 400.0;
    u = 1.0 + v * v / (1.0 - asq);
    u = sqrt(asq * u);
    if(alpha < 0.0) u = -u;
    point((u + 1.0)*400.0, (1.0 - v)*400.0);
    
    // Branche d'hyperbole définie par S(0,-1), N(0,1) et bêta
    u = t / 400.0;
    v = 1.0 + u * u / (1.0 - bsq);
    v = sqrt(bsq * v);
    if(beta < 0.0) v = -v;
    point((u + 1.0)*400.0, (1.0 - v)*400.0);
  }
}