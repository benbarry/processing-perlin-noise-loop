// Canvas Size (In Pixels)
  int canvasWidth = 960,
      canvasHeight = 540;

  int canvasPadding = 30;

// Total number of columns and rows of dots
  int cols = 60,
      rows = 30;

// Grid Unit
  float gridUnitX = ((canvasWidth - (canvasPadding * 2)) / (cols-1));
  float gridUnitY = ((canvasHeight - (canvasPadding * 2)) / (rows-1));

// Noise Settings
  int noiseSeed = 1; // Change or randomize this to change the noise pattern
  float noiseScale = 0.005; // Change this to a adjust the scale of the noise

  float barrierSetting = 80; // Where to transition from noiseOriginal to noiseAverage (Percentage of 100)

// Animation Speed
  float speed,
        speedStep = 0.5; // Change this to increase or decrease the animation speed

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
}

void draw() {

  if (speed >= (totalFrames * speedStep)) {
    speed = 0;
    println("Loop Reset");
    record = false;
  }

  background(0);

  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {

      float xPos = canvasPadding + (x * gridUnitX);
      float yPos = canvasPadding + (y * gridUnitY);

      float xNoise = xPos + speed * 2;
      float yNoise = yPos + speed * 2;

      float noise = getNoise(xNoise, yNoise);

      float lineRotation = map(noise, 0.0, 1.0, 1, 360);
      float lineColor = map(noise, 0.0, 1.0, 0, 255);

      stroke(lineColor);

      pushMatrix();
      translate(xPos + gridUnitX / 2, yPos + gridUnitY / 2);
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
