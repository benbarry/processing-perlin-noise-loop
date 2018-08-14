// Canvas Size (In Pixels)
  int canvasWidth = 960,
      canvasHeight = 540;

  int canvasPadding = 30;

// Total number of columns and rows
  int cols = 60,
      rows = 30;

// Grid Unit
  float gridUnitX = (canvasWidth - (canvasPadding * 2)) / float(cols);
  float gridUnitY = (canvasHeight - (canvasPadding * 2)) / float(rows);

// Noise Settings
  int noiseSeed = 1; // Change or randomize this to change the noise pattern
  float noiseScale = 0.1; // Change this to a adjust the scale of the noise

  float barrier = 0.8; // Where to transition from noiseOriginal to noiseStart (Range 0.0 - 1.0)

// Animation Speed
  float speed,
        speedStep = 0.1; // Change this to increase or decrease the animation speed

// Recording
  boolean record = false; // Set to 'true' to record

  int framerate = 30, // Frames per second
      videoLength = 45, // Desired length in seconds
      totalFrames = videoLength * framerate; // Total number of frames to record

void settings() {
  size(canvasWidth, canvasHeight);
  pixelDensity(displayDensity());
  noiseSeed(noiseSeed);
}

void setup() {
  frameRate(framerate);
  strokeWeight(1.5);
  noFill();
}

void draw() {

  if (frameCount % totalFrames == 0) {
    speed = 0;
    record = false;
    println("Loop Reset");
  }

  background(15);

  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {

      float xPos = canvasPadding + (x * gridUnitX);
      float yPos = canvasPadding + (y * gridUnitY);

      float noiseOriginal = noise((x + speed) * noiseScale, (y + speed) * noiseScale);

      float noiseOutput = noiseOriginal;

      if (frameCount % totalFrames >= totalFrames * barrier) {
        float noiseStart = noise((x + speed - (totalFrames * speedStep)) * noiseScale, (y + speed - (totalFrames * speedStep)) * noiseScale);
        float location = norm(frameCount % totalFrames, totalFrames * barrier, totalFrames);
        noiseOutput = (noiseOriginal * (1-location)) + (noiseStart * location);
      }

      float lineRotation = map(noiseOutput, 0.0, 1.0, 1, 360);
      float lineColor = map(noiseOutput, 0.0, 1.0, 50, 200);

      stroke(lineColor);

      pushMatrix();
      translate(xPos + gridUnitX, yPos + gridUnitY);
      rotate(radians(lineRotation));
      line(0, 0, gridUnitX / 2, gridUnitY / 2);
      popMatrix();

    }
  }

  if (record) {
    saveFrame("frames-ns-"+noiseSeed+"/######.png");
  }

  speed += speedStep;
}
