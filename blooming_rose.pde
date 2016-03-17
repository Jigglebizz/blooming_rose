int x_size = 1200;
int y_size = 1200;
  
int density = 50;
int waves = 3;
float radius = 12;
int rings = 3;
int amplitude = 100;
float time_divider = 800f;
int flower_radius = 400;
int flowers = 3;
float scale_factor = 0.45f;

void setup() {
  size(1200, 1200);
  colorMode(HSB, 100);
}

void draw() {
  background(0);  
  
  for (int i = 0; i < flowers; i++) {
    drawFlower(1f - scale_factor * ((float)i / (float)flowers));
  }
}

void drawFlower(float scale) {
    float angle_interval = (float)TWO_PI / ((float)waves * (float)rings);
  
    for (int i = 0; i < rings; i++) { 
      drawRing(angle_interval * i, scale);
    }
}

void drawRing(float angle_shift, float scale) {
  for(int i = 0; i < density + 1; i++) {
    
    // Where do we draw the dot?
    // Calculate our polar coordinates (theta/r vs x/y)
    float theta = ((float)TWO_PI / (float)density) * (float)i;
    float wave_func = theta * waves + (millis() / time_divider);
    float r = (flower_radius + (amplitude * sin(wave_func))) * scale;
    
    float sat = 100f - 100f * (r / (float)(flower_radius + amplitude));
    float hue = cos(millis() / (time_divider * 10f));
    
    // How do we draw the dot?
    // This includes our polar-cartesian equation.
    stroke(hue * sat, sat, 100);
    fill(hue * sat, 75, 100);
    ellipse(x_size / 2 + r * cos(theta + angle_shift), 
            y_size / 2 + r * sin(theta + angle_shift), 
            radius * scale * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2), 
            radius * scale * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2));
  } 
}