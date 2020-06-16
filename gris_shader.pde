PImage label;
PShape can;
float angle;

// PShader bwShader;
PShader promedio;
PShader luma;
PShader rojo;
PShader verde;
PShader azul;
PShader enfoque;
PShader realce;
PShader pulir;
PShader realce_borde;
PShader deteccion_borde;

int opcion = 1;
boolean bandera = false;

void setup() {
    size(640, 600, P3D);
    label = loadImage("imagen_prueba_02.jpg");
    can = createCan(150, 350, 32, label);
    // bwShader = loadShader("bwfrag.glsl");
    promedio = loadShader("promedio.glsl");
    luma  =    loadShader("luma.glsl");
    rojo  =    loadShader("rojo.glsl");
    verde =    loadShader("verde.glsl");
    azul  =    loadShader("azul.glsl");
    enfoque =  loadShader("enfoque.glsl");
    realce =   loadShader("realce.glsl");
    pulir =    loadShader("pulir.glsl");
    realce_borde = loadShader("realce_borde.glsl");
    deteccion_borde = loadShader("deteccion_borde.glsl");
}

void draw() {
  background(0);
  
  if(!bandera) {
      if(opcion == 1){
        shader(promedio);
      }
      if(opcion == 2){
        shader(luma);
      }
      if(opcion == 3){
        shader(rojo);
      }
      if(opcion == 4){
        shader(verde);
      }
      if(opcion == 5){
        shader(azul);
      }
  } else {
      if(opcion == 1){
        shader(enfoque);
      }
      if(opcion == 2){
        shader(realce);
      }
      if(opcion == 3){
        shader(pulir);
      }
      if(opcion == 4){
        shader(realce_borde);
      }
      if(opcion == 5){
        shader(deteccion_borde);
      }
  }
    
  translate(width/2, height/2);
  rotateY(angle);
  shape(can);
  angle += 0.004;
}

void mouseClicked() {
  if(bandera){
    bandera = false;
  }else{
    bandera = true;
  }
}

void keyPressed() {
    // False --> PROMEDIO RGB
    // True  --> ENFOQUE
    if(key == 'q'){
        opcion = 1;
    }
    // False --> LUMA
    // True --> REALCE
    if(key == 'w'){
        opcion = 2;
    }
    // False --> RGB-ROJO
    // True --> PULIR
    if(key == 'e'){
        opcion = 3;
    }
    // False --> RGB-VERDE
    // True --> REALCE BORDE
    if(key == 'r'){
        opcion = 4;
    }
    // False --> RGB-AZUL
    // True --> DETECCION BORDE
    if(key == 't'){
        opcion = 5;
    }
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);
  }
  sh.endShape();
  return sh;
}
