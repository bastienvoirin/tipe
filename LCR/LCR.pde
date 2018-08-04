float x, x1, x2, y, b, c, delta, asq, bsq, u, v, g, d, lsq, rsq, error, count;
float pos[] = new float[2];
int t;

void setup() {
  sample();
  
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
  x = (mouseX - 400.0) / 200.0;
  y = (400.0 - mouseY) / 200.0;
  
  // Calcul de (g, d)
  g = (dist(-2.0, 0.0, x, y) - dist(0.0, 0.0, x, y)) / 2.0;
  d = (dist( 0.0, 0.0, x, y) - dist(2.0, 0.0, x, y)) / 2.0;
  
  // Visualisation de (g, d)
  fill(0);
  rect(200.0, 398.0, (g + 1.0) * 200.0, 402.0);
  rect(600.0, 398.0, (d + 3.0) * 200.0, 402.0);
  
  // Calcul de (x, y)
  pos = solve(g, d);
  x = pos[0];
  y = pos[1];
  
  ellipse((x + 2.0) * 200.0, (2.0 - y) * 200.0, 10.0, 10.0);
  
  // Tracé des branches d'hyperboles
  hyperbolas(g, d);
}

float[] solve(float l, float r) {
  lsq = l * l;
  rsq = r * r;
  
  // Coefficients et discriminant de l'équation du second degré d'inconnue x
  b = 2 * (lsq + rsq - 2 * lsq * rsq) / (rsq - lsq);
  c = 1 - lsq * rsq;
  delta = b * b - 4 * c;
  
  // Résolution de l'équation
  x = - b / 2;
  x1 = x - sqrt(delta) / 2;
  x2 = x + sqrt(delta) / 2;
  x = x1;
  if((l >= 0 && x1 <= -1.0) || (r >= 0 && x1 <= 1.0)) x = x2;
  y = sqrt( (1 - lsq) * ((x + 1) * (x + 1) / lsq - 1) );
  
  pos[0] = x;
  pos[1] = y;
  
  return pos;
}

void erase() {
  background(255); // Fond blanc
  
  line(  0, 400, 800, 400); // Axe des abscisses
  line(400,   0, 400, 800); // Axe des ordonnées
  
  ellipse(  0.0, 400.0, 10.0, 10.0); // L
  ellipse(400.0, 400.0, 10.0, 10.0); // C
  ellipse(800.0, 400.0, 10.0, 10.0); // R
}

void hyperbolas(float a, float b) {
  asq = a * a;
  bsq = b * b;
  
  for(t = -400; t < 400; t++) {
    // Branche d'hyperbole définie par L(-2,0), C(0,0) et g
    v = t / 200.0;
    u = asq * ( 1.0 + v * v / (1 - asq) );
    u = - 1.0 + sqrt(u);
    if(g <= 0) u = - 2.0 - u;
    point((u + 2.0) * 200.0, (2.0 - v) * 200.0);
    
    // Branche d'hyperbole définie par C(0,0), R(2,0) et d
    u = bsq * ( 1.0 + v * v / (1 - bsq) );
    u = 1.0 + sqrt(u);
    if(d <= 0) u = 2.0 - u;
    point((u + 2.0) * 200.0, (2.0 - v) * 200.0);
  }
}

void sample() {
  count = 0.0;
  
  for(t = 0; t < 1000000; t++) {
    x = random(-1.0, 1.0);
    y = random(   0, 1.0);
    
    // Calcul de (g, d)
    g = (dist(-2.0, 0.0, x, y) - dist(0.0, 0.0, x, y)) / 2.0;
    d = (dist( 0.0, 0.0, x, y) - dist(2.0, 0.0, x, y)) / 2.0;
    
    pos = solve(g, d);
    
    error = dist(x, y, pos[0], pos[1]);
    if(error > 0.0) count++;
  }
  
  println(count / t * 100, "%");
}