int x_size = 600;
int y_size = 600;
  
int density = 100;
int waves = 3;
float radius = 6;
int rings = 3;
int amplitude = 50;
float time_divider = 800f;
int flower_radius = 200;

void setup() {
  size(600, 600);
  colorMode(HSB, 100);
}

void draw() {
  background(0);  
  
  float angle_interval = (float)TWO_PI / ((float)waves * (float)rings);
  
  for (int i = 0; i < rings; i++) { 
    drawRing(angle_interval * i);
  }
}

void drawRing(float angle_shift) {
    for(int i = 0; i < density; i++) {
    float theta = ((float)TWO_PI / (float)density) * (float)i;
    float wave_func = theta * waves + (millis() / time_divider);
    float r = flower_radius + (amplitude * sin(wave_func));
    
    stroke(0, 0, 100);
    fill(0, 0, 100);
    ellipse(x_size / 2 + r * cos(theta + angle_shift), 
            y_size / 2 + r * sin(theta + angle_shift), 
            radius * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2), 
            radius * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2));
  } 
}