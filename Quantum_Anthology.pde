/*
  QUANTUM ANTHOLOGY - BRIDGE TO BRIDGE STUDIO EDITION
 Curated by: Umut
 Code Architecture: Object Oriented PGraphics Buffering
 */

// --- AYARLAR ---
int FADE_DURATION = 50;

// --- YÖNETİCİ DEĞİŞKENLER ---
Scene[] scenes;
int currentSceneIndex = 0;
int nextSceneIndex = 1;
int timer = 0;
boolean isFading = false;
float fadeAlpha = 0;
PFont titleFont, bodyFont;

void setup() {
  size(540, 960, P3D); // Mobil/Dikey Ekran Formatı
  pixelDensity(2);
  smooth(8);

  // Font Ayarları
  titleFont = createFont("Arial Bold", 24);
  bodyFont = createFont("Arial", 14);

  scenes = new Scene[5];

  // 1. ESER: IS THIS QUANTUM COMPUTING
  scenes[0] = new SceneSicim();
  scenes[0].duration = 200;
  scenes[0].title = "Is This Quantum Computing";
  scenes[0].description = "Bu proje, Spirohedron şeklinden esinlenen bir Sicim Görselleştirmesidir. Sicimlerin titreşimsel hareketini simüle eder ve Vera Molnár'ın %1 düzensizlik algoritmasına benzer bir rastgelelik unsuru ekleyerek yapıya hafif bozulmalar katar.";

  // 2. ESER: HYPNOTIC GLUONS
  scenes[1] = new SceneGluon();
  scenes[1].duration = 90; 
  scenes[1].title = "Hypnotic Gluons Build Everything";
  scenes[1].description = "Kuantum kromodinamiğindeki (QCD) kuarklar ve gluonların karmaşık etkileşimlerinden esinlenen bir Gluon Alanı Görselleştirmesi. Parçacıkların canlı bir 3B uzayda salındığı ve etkileşime girdiği dinamik yapı.";

  // 3. ESER: HYPERCUBE
  scenes[2] = new SceneHypercube();
  scenes[2].duration = 180; 
  scenes[2].title = "Hypercube";
  scenes[2].description = "Dördüncü boyutun gölgesini üç boyutlu uzayda titreşimli bir iz olarak temsil eden bu hiperküp, zamanla bükülen geometrinin kuantum olasılıklarını görünür kılmayı amaçlıyor.";

  // 4. ESER: ORBIT
  scenes[3] = new SceneGravity();
  scenes[3].duration = 180; 
  scenes[3].title = "Orbit";
  scenes[3].description = "Evrenin dokusunu eğip bükerek ışığın yolunu yeniden çizen bu kütleçekim noktaları, görünmeyen kozmik akışların mimarları olarak sahnede titreşen birer iz bırakıyor.";

  // 5. ESER: QUANTUM LANIAKEA
  scenes[4] = new SceneLaniakea();
  scenes[4].duration = 200; 
  scenes[4].title = "Quantum Laniakea";
  scenes[4].description = "Atom altı parçacıkların kaotik titreşimleriyle Laniakea Süperkümesi’nin devasa akışlarını aynı kozmik nefeste birleştiren bu çalışma, ölçekler arası rezonansın evrendeki gizli ritmini görünür kılıyor.";

  // Başlangıç Kurulumları
  scenes[0].setupScene();
  scenes[1].setupScene();
}

void draw() {
  background(0);

  // --- 1. RENDER (Arka Planda Çizim) ---
  scenes[currentSceneIndex].update();
  scenes[currentSceneIndex].drawToBuffer();

  if (isFading) {
    scenes[nextSceneIndex].update();
    scenes[nextSceneIndex].drawToBuffer();
  }

  // --- 2. COMPOSITING (Ekrana Basma) ---
  image(scenes[currentSceneIndex].pg, 0, 0);

  if (isFading) {
    float alphaVal = map(fadeAlpha, 0, FADE_DURATION, 0, 255);
    tint(255, alphaVal);
    image(scenes[nextSceneIndex].pg, 0, 0);
    noTint();

    fadeAlpha++;

    if (fadeAlpha >= FADE_DURATION) {
      isFading = false;
      currentSceneIndex = nextSceneIndex;
      nextSceneIndex = (currentSceneIndex + 1) % scenes.length;
      timer = 0;
      fadeAlpha = 0;
      scenes[nextSceneIndex].setupScene();
    }
  } else {
    timer++;
    if (timer > scenes[currentSceneIndex].duration) {
      isFading = true;
    }
  }

  // --- 3. UI LAYER (Bilgi Ekranı) ---
  
  hint(DISABLE_DEPTH_TEST);
  drawUI();
  hint(ENABLE_DEPTH_TEST);
}

void drawUI() {
  // Mevcut sahnenin bilgilerini al 
  Scene s = scenes[currentSceneIndex];

  // Alt Panel Arkaplanı 
  noStroke();
  fill(0, 180);
  rect(0, height - 220, width, 220);

  // Stüdyo İsmi
  fill(100, 255, 200); 
  textFont(bodyFont);
  textAlign(CENTER);
  text("Bridge to Bridge Studio", width/2, height - 190);

  // Eser Başlığı
  fill(255);
  textFont(titleFont);
  text(s.title, width/2, height - 155);

  // Eser Açıklaması
  fill(200);
  textFont(bodyFont);
  textSize(13);
  textLeading(18); 
  
  text(s.description, 40, height - 130, width - 80, 120);

  // Progress Bar 
  float progress = map(timer, 0, s.duration, 0, width);
  if (!isFading) {
    stroke(100, 255, 200, 150);
    strokeWeight(2);
    line(0, height-2, progress, height-2);
  }
}

// ==========================================
// SCENE CLASS & SUBCLASSES
// ==========================================

abstract class Scene {
  PGraphics pg;
  int duration = 180;
  String title = "";
  String description = "";

  Scene() {
    pg = createGraphics(width, height, P3D);
  }

  void setupScene() {
  }
  abstract void update();

  void drawToBuffer() {
    pg.beginDraw();
    pg.background(0);
    renderContent();
    pg.endDraw();
  }

  abstract void renderContent();
}

// --- 1. Is This Quantum Computing ---
class SceneSicim extends Scene {
  int numPoints = 1000;
  float time = 0;
  float randomnessFactor = 0.05;

  void setupScene() {
    time = 0;
  }
  void update() {
    time += 0.02;
  }

  void renderContent() {
    pg.lights();
    pg.translate(width / 2, height / 2, -300);
    pg.rotateX(frameCount * 0.01);
    pg.rotateY(frameCount * 0.02);
    pg.noFill();
    pg.strokeWeight(3);
    pg.beginShape();
    for (int i = 0; i < numPoints; i++) {
      float t = map(i, 0, numPoints, 0, TWO_PI);
      float baseR = 140 + 55 * sin(4 * t + time) + 35 * cos(7 * t + time * 0.5);
      float baseX = baseR * cos(t * 2);
      float baseY = baseR * sin(t * 3);
      float baseZ = 70 * cos(5 * t + time) + 28 * sin(8 * t + time * 0.3);
      float randomShift = 1 + randomnessFactor * random(-1, 1);
      float x = baseX * randomShift;
      float y = baseY * randomShift;
      float z = baseZ * randomShift;
      float red = 127 + 127 * sin(time + t);
      float green = 127 + 127 * sin(time * 0.7 + t * 1.5);
      float blue = 127 + 127 * cos(time * 1.3 + t * 2);
      pg.stroke(red, green, blue, 220);
      pg.vertex(x, y, z);
    }
    pg.endShape(CLOSE);
  }
}

// --- 2. Hypnotic Gluons Build Everything ---
class SceneGluon extends Scene {
  int numParticles = 200;
  float[] angleX, angleY, radius, speed, zPos, zSpeed;

  void setupScene() {
    angleX = new float[numParticles];
    angleY = new float[numParticles];
    radius = new float[numParticles];
    speed = new float[numParticles];
    zPos = new float[numParticles];
    zSpeed = new float[numParticles];
    for (int i = 0; i < numParticles; i++) {
      angleX[i] = random(TWO_PI);
      angleY[i] = random(TWO_PI);
      radius[i] = random(70, 200);
      speed[i] = random(0.02, 0.05);
      zPos[i] = random(-80, 80);
      zSpeed[i] = random(0.01, 0.05);
    }
  }
  void update() {
  }

  void renderContent() {
    pg.translate(width / 2, height / 2, 0);
    pg.rotateX(PI / 6);
    pg.rotateY(frameCount * 0.01);
    pg.noFill();
    for (int i = 0; i < numParticles; i++) {
      float x = radius[i] * cos(angleX[i]);
      float y = radius[i] * sin(angleY[i]);
      float z = zPos[i];
      angleX[i] += speed[i] * sin(frameCount * 0.01 + i);
      angleY[i] += speed[i] * cos(frameCount * 0.01 + i);
      zPos[i] += zSpeed[i];
      if (zPos[i] > 100 || zPos[i] < -100) zSpeed[i] *= -1;
      float r = 255 * (sin(angleX[i] * 2) + 1) / 2;
      float g = 255 * (cos(angleY[i] * 2) + 1) / 2;
      float b = 255 * (sin(angleX[i] * 3) + 1) / 2;
      pg.stroke(r, g, b, 180);
      pg.pushMatrix();
      pg.translate(x, y, z);
      pg.sphere(3.5);
      pg.popMatrix();
      for (int j = 0; j < 5; j++) {
        float alpha = map(j, 0, 5, 100, 255);
        pg.stroke(r, g, b, alpha);
        float x1 = radius[i] * cos(angleX[i] + j * PI / 5);
        float y1 = radius[i] * sin(angleY[i] + j * PI / 5);
        float z1 = zPos[i] + random(-10, 10);
        float x2 = radius[i] * cos(angleX[i] + j * PI / 5 + PI);
        float y2 = radius[i] * sin(angleY[i] + j * PI / 5 + PI);
        float z2 = zPos[i] + random(-10, 10);
        pg.line(x1, y1, z1, x2, y2, z2);
      }
    }
  }
}

// --- 3. Hypercube ---
class SceneHypercube extends Scene {
  int numCubes = 100;
  float boxSize = 300;
  float decrement = 2.5;

  void update() {
  }
  void renderContent() {
    pg.translate(width / 2, height / 2);
    pg.rotateX(frameCount * 0.01);
    pg.rotateY(frameCount * 0.01);
    pg.noFill();
    for (int i = 0; i < numCubes; i++) {
      float currentSize = boxSize - i * decrement;
      pg.stroke(random(255), random(255), random(255));
      drawCube(currentSize);
    }
  }
  void drawCube(float s) {
    PVector[] v = new PVector[8];
    v[0]=new PVector(-s/2, -s/2, -s/2);
    v[1]=new PVector(s/2, -s/2, -s/2);
    v[2]=new PVector(s/2, s/2, -s/2);
    v[3]=new PVector(-s/2, s/2, -s/2);
    v[4]=new PVector(-s/2, -s/2, s/2);
    v[5]=new PVector(s/2, -s/2, s/2);
    v[6]=new PVector(s/2, s/2, s/2);
    v[7]=new PVector(-s/2, s/2, s/2);
    for (int i = 0; i < 4; i++) {
      int n = (i + 1) % 4;
      pg.line(v[i].x, v[i].y, v[i].z, v[n].x, v[n].y, v[n].z);
      pg.line(v[i+4].x, v[i+4].y, v[i+4].z, v[n+4].x, v[n+4].y, v[n+4].z);
      pg.line(v[i].x, v[i].y, v[i].z, v[i+4].x, v[i+4].y, v[i+4].z);
    }
    for (int i = 4; i < 8; i++) {
      int n = (i + 1) % 4 + 4;
      pg.line(v[i].x, v[i].y, v[i].z, v[n].x, v[n].y, v[n].z);
    }
  }
}

// --- 4. Orbit ---
class SceneGravity extends Scene {
  int numLines = 200;
  int numPoints = 100;
  float amplitude = 15;
  float waveSpeed = 0.05;
  PVector center;

  void setupScene() {
    center = new PVector(width/2, height/2);
  }
  void update() {
  }

  void renderContent() {
    pg.strokeWeight(1.2);
    pg.noFill();
    for (int i = 0; i < numLines; i++) {
      float t = map(i, 0, numLines-1, 0.1, 1);
      float r = map(sin(frameCount*0.02 + i), -1, 1, 100*t, 255);
      float g = map(sin(frameCount*0.015 + i*1.1), -1, 1, 50*t, 255);
      float b = map(sin(frameCount*0.018 + i*0.7), -1, 1, 100*t, 255);
      pg.stroke(r, g, b);
      PVector dir = PVector.sub(center, new PVector(random(width), random(height)));
      dir.mult(t*0.5);
      pg.beginShape();
      for (int j = 0; j <= numPoints; j++) {
        float x = map(j, 0, numPoints, 0, width);
        float y = map(j, 0, numPoints, 0, height);
        x += dir.x * sin(j*0.1 + frameCount*waveSpeed);
        y += dir.y * sin(j*0.1 + frameCount*waveSpeed);
        x += sin(j*0.2 + frameCount*0.03 + i*0.1) * amplitude * t;
        y += cos(j*0.15 + frameCount*0.02 + i*0.1) * amplitude * t;
        pg.vertex(x, y);
      }
      pg.endShape();
    }
  }
}

// --- 5. Quantum Laniakea ---
class SceneLaniakea extends Scene {
  int numParticles = 6000;
  LaniakeaParticle[] particles;

  void setupScene() {
    particles = new LaniakeaParticle[numParticles];
    for (int i = 0; i < numParticles; i++) particles[i] = new LaniakeaParticle();
  }
  void update() {
    for (int i = 0; i < numParticles; i++) particles[i].update();
  }
  void renderContent() {
    pg.lights();
    pg.translate(width/2, height/2, -600);
    pg.rotateY(frameCount * 0.0015);
    pg.rotateX(frameCount * 0.001);
    for (int i = 0; i < numParticles; i++) particles[i].display(pg);
  }
}

class LaniakeaParticle {
  PVector pos;
  float angleOffset, radius, speed;
  LaniakeaParticle() {
    radius = random(width * 0.2, width * 0.8);
    float theta = random(TWO_PI);
    float phi = random(PI);
    pos = new PVector(radius * sin(phi) * cos(theta), radius * sin(phi) * sin(theta), radius * cos(phi));
    angleOffset = random(TWO_PI);
    speed = random(0.0015, 0.008);
  }
  void update() {
    float t = frameCount * speed + angleOffset;
    float r = radius + 40*sin(t*2.0);
    float theta = t*1.2;
    float phi = PI/2 + 0.4*sin(t*1.5);
    pos.x = r * sin(phi) * cos(theta);
    pos.y = r * sin(phi) * sin(theta);
    pos.z = r * cos(phi);
  }
  void display(PGraphics pg) {
    float intensity = map(radius, width * 0.2, width * 0.8, 255, 60);
    pg.stroke(160 + 90*sin(frameCount*0.01 + pos.x*0.01), 170 + 85*sin(frameCount*0.015 + pos.y*0.01), 255, intensity);
    pg.strokeWeight(2);
    pg.point(pos.x, pos.y, pos.z);
  }
}





