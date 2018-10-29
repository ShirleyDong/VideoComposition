 final float USER_SCALING = 1;
 float [] getMeansFrom(PImage p) {
  float [] m = new float [3];

  p.loadPixels();
  for (int i = 0; i < p.pixels.length; i += 1) {
    float [] cp = rgb2Lab(red(p.pixels[i]), green(p.pixels[i]), blue(p.pixels[i]));

    for (int j = 0; j < cp.length; j += 1) {
      m[j] += cp[j];
    }
  }


  for (int j = 0; j < m.length; j += 1) {
    m[j] /= p.pixels.length;
  }


  return m;
}


float [] getVariancesFrom(PImage p) {
  float [] m = getMeansFrom(p);
  float [] sd = new float [3];

  p.loadPixels();

  for (int i = 0; i < p.pixels.length; i += 1) {
    float [] cp = rgb2Lab(red(p.pixels[i]), green(p.pixels[i]), blue(p.pixels[i]));

    for (int j = 0; j < sd.length; j += 1) {
      sd[j] += ((cp[j] - m[j]) * (cp[j] - m[j]));
    }
  }

  for (int j = 0; j < sd.length; j += 1) {
    sd[j] = sqrt(sd[j] / p.pixels.length);
  }

  return sd;
}



void applyScalingsFromTo(PImage r, PImage t) {
  float [] s = new float[3];

  float [] sdRef = getVariancesFrom(r);
  float [] mTarget = getMeansFrom(t);
  float [] sdTarget = getVariancesFrom(t);

  for (int j = 0; j < s.length; j += 1) {
    s[j] = 1 - USER_SCALING + USER_SCALING * sdRef[j] / sdTarget[j];
  }

  t.loadPixels();

  for (int i = 0; i < t.pixels.length; i += 1) {
    if((alpha(t.pixels[i] )!= 0)){
    float [] cp = rgb2Lab(red(t.pixels[i]), green(t.pixels[i]), blue(t.pixels[i]));

    for (int j = 0; j < 3; j += 1) {
      cp[j] = s[j] * (cp[j] - mTarget[j]) + mTarget[j];
    }

    float [] rgb = lab2RGB(cp[0], cp[1], cp[2]);
    t.pixels[i] = color(rgb[0], rgb[1], rgb[2]);
  }}

  t.updatePixels();
}