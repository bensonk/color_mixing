// Pretty color mixing with PWM
// Benson Kalahar
// August 2011

// LEDs on 9, 10, and 11
#define RED 9
#define GREEN 10
#define BLUE 11

// These are fudge-factors for varying LED brightness
// given the same power. Red takes a lot more juice to
// produce the same amount of light. I'm not sure why.
#define R_MAX 255
#define G_MAX 90
#define B_MAX 50

// Length of time in which the fade lasts
#define FADE_DURATION 20000


void setup() {
  randomSeed(4); // Random number chosen by fair dice roll
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
}

void fade(byte old_r, byte old_g, byte old_b,
          byte new_r, byte new_g, byte new_b) {
  for(float i = 0.0; i <= FADE_DURATION; i++) {
    float new_portion = i / FADE_DURATION;
    float old_portion = 1.0 - new_portion;
    
    byte r = old_r * old_portion + new_r * new_portion;
    byte g = old_g * old_portion + new_g * new_portion;
    byte b = old_b * old_portion + new_b * new_portion;
    
    display_color(r, g, b);
  }
}

void display_color(byte r, byte g, byte b) {
  analogWrite(RED, r);
  analogWrite(GREEN, g);
  analogWrite(BLUE, b);
}

// Start dark and fade up to whatever color is randomly chosen:
byte r = 0, g = 0, b = 0;

void loop() {
  byte new_r = random(R_MAX);
  byte new_g = random(G_MAX);
  byte new_b = random(B_MAX);
  
  fade(r, g, b, new_r, new_g, new_b);
  
  r = new_r;
  g = new_g;
  b = new_b;
}
