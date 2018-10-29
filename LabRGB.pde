float [] rgb2Lab(float r, float g, float b) {
  float [] lab = new float[3];

  lab[0] = 0.3475 * r + 0.8231 * g + 0.5550 * b;
  lab[1] = 0.2162 * r + 0.4316 * g - 0.6411 * b;
  lab[2] = 0.1304 * r - 0.1033 * g - 0.0269 * b;

  return lab;
}

float [] lab2RGB(float l, float a, float b) {
  float [] rgb = new float[3];

  rgb[0] = 0.5773 * l + 0.2621 * a + 5.6947 * b;
  rgb[1] = 0.5774 * l + 0.6072 * a - 2.5444 * b;
  rgb[2] = 0.5832 * l - 1.0627 * a + 0.2073 * b;

  return rgb;
}