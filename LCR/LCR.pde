float x, x1, x2, y, a, b, c, delta, asq, bsq, u, v, g, d, gsq, dsq;

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
  erase();
  mousePressed();
}

void mousePressed() {
  erase();
  
  // Conversion des coordonnées (changement de repère)
  x = (mouseX - 400.0) / 200.0;
  y = (400.0 - mouseY) / 200.0;
  
  // Calcul de (g, d)
  g = (dist(-2.0, 0.0, x, y) - dist(0.0, 0.0, x, y)) / 2.0;
  d = (dist(0.0, 0.0, x, y) - dist(2.0, 0.0, x, y)) / 2.0;
  gsq = g * g;
  dsq = d * d;
  
  // Visualisation de (g, d)
  fill(0);
  rect(200.0, 398.0, (g + 1.0)*200.0, 402.0);
  rect(600.0, 398.0, (d + 3.0)*200.0, 402.0);
  
  // Résolution de l'équation vérifiée par x
  
  b = 2 * (gsq + dsq - 2*gsq*dsq) / (dsq - gsq);
  c = 1 - gsq*dsq;
  delta = b*b - 4*c;
  
  x = - b / 2;
  x1 = x - sqrt(delta) / 2;
  x2 = x + sqrt(delta) / 2;
  x = x1;
  if((g >= 0 && x1 <= -1.0) || (d >= 0 && x1 <= 1.0)) {
    x = x2;
  }
  y = sqrt( (1-gsq) * ((x+1)*(x+1)/gsq - 1) );
  
  ellipse(x*200.0 + 400.0, 400.0 - y*200.0, 10.0, 10.0);
  
  // Tracé des branches d'hyperboles
  hyperbolas(g, d);
}

void erase() {
  background(255,0.0);
  line(0,400,800,400); // Axe des abscisses
  line(400,0,400,800); // Axe des ordonnées
  ellipse(  0.0, 400.0, 10.0, 10.0); // L
  ellipse(400.0, 400.0, 10.0, 10.0); // C
  ellipse(800.0, 400.0, 10.0, 10.0); // R
}

void hyperbolas(float a, float b) {
  asq = a * a;
  bsq = b * b;
  
  for(int t = -400; t < 400; t++) {
    // Branche d'hyperbole définie par (-2,0), (0,0) et g
    v = t/200.0;
    u = asq * ( 1.0 + v*v / (1 - asq) );
    u = - 1.0 + sqrt(u);
    if(g <= 0) u = - 2.0 - u;
    point((u + 2.0)*200.0, (2.0 - v)*200.0);
    
    // Branche d'hyperbole définie par (0,0), (2,0) et d
    u = bsq * ( 1.0 + v*v / (1 - bsq) );
    u = 1.0 + sqrt(u);
    if(d <= 0) u = 2.0 - u;
    point((u + 2.0)*200.0, (2.0 - v)*200.0);
  }
}