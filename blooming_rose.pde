int density = 50;
int waves = 3;
float radius = 12;
int rings = 3;
int amplitude = 150;
float time_divider = 800f;
int flower_radius = 333;
int flowers = 3;
float scale_factor = 0.45f;
int trail_density = 25;
float color_scale = 0.5f;

PGraphics pg;
boolean firstDraw;

void setup() {
  size(1000, 1000);
  
  pg = createGraphics(width, height);
  firstDraw = true;
}

void draw() {
  pg.beginDraw();
  if (firstDraw) {
     pg.background(0);
     firstDraw = false;
  }
  pg.fill(0, 0, 0, trail_density);
  pg.rect(0, 0, width, height);
  //pg.background(0); 
  
  for (int i = 0; i < flowers; i++) {
    drawFlower(1f - scale_factor * ((float)i / (float)flowers));
  }
  pg.endDraw();
  image(pg, 0, 0);
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
    float hue = 100 * (millis() / (time_divider * 10f));//0.5f + 0.5f * cos(millis() / (time_divider * 10f));
    
    // How do we draw the dot?
    // This includes our polar-cartesian equation.
    pg.colorMode(HSB, 100f);
    pg.stroke((hue + sat * color_scale) % 100, sat, 100f);
    pg.fill((hue + sat * color_scale) % 100, 75, 100f);
    pg.ellipse(width / 2 + r * cos(theta + angle_shift), 
            height / 2 + r * sin(theta + angle_shift), 
            radius * scale * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2), 
            radius * scale * (0.5f + sin(theta * waves + (theta / i + 20) + (millis() / time_divider)) / 2));
  } 
}