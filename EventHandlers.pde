boolean imageBackground = true;
void mousePressed() {
  
  
  switch (mouseButton) {
  case LEFT:
    //get the color of the pixel and appendint on the keyColor
    keyColours = append(keyColours, get(mouseX, mouseY));
    //printKeyColours(keyColours);
    break;
    
    case RIGHT:
    colourCorrecting = true;
    //currentReference = (currentReference + 1 ) % 2;
    currentReference1 = get(mouseX, mouseY, 200, 360);
    break;
  }
}

void mouseMoved() {
  colourUnderMouse = get(mouseX, mouseY);
}

void keyPressed() {
  switch (key) {
  case ' ':
    playing = !playing;
    if (playing) {
      vfx.loop();
    } else {
      vfx.pause();
    }
    break;

  case 'b':
    blur = ! blur;
    break;
    
  case 'z':
    keyColours = shorten(keyColours);
    break;

  case 's':
    saveKeyData("data/chromakey.json");
    break;
    
  case CODED:
    closeColourDistance = changeCloseColourDistance(keyCode);
    break;
  }
}

float changeCloseColourDistance(int code) {
  float d = closeColourDistance;
  float jumpTo;
  
  switch (code) {
  case UP:
    d += CLOSE_COLOUR_DELTA;
    break;
  case DOWN:
    d = max(0, d - CLOSE_COLOUR_DELTA);
    break;

  case LEFT:
    vfx.play();
    jumpTo = max(0.0, vfx.time() - 0.02);
    vfx.jump(jumpTo);
    vfx.pause();
    break;

  case RIGHT:
    vfx.play();
    jumpTo = min(vfx.time() + 0.02, vfx.duration());
    vfx.jump(jumpTo);
    vfx.pause();
    break;
  }

  return d;
}
