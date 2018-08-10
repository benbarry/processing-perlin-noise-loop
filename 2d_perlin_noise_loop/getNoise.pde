float getNoise(float x, float y) {

  float noiseSize = (totalFrames * speedStep) * 4;
  float tileSize = noiseSize / 2;

  float barrier = tileSize * (barrierSetting / 100);

  if (x >= tileSize) {
    x -= tileSize;
  }

  if (y >= tileSize) {
    y -= tileSize;
  }

  float noiseOriginal = noise(x * noiseScale, y * noiseScale);
  float noiseFlipOne = noise((tileSize - x) * noiseScale, y * noiseScale);
  float noiseFlipTwo = noise(x * noiseScale, (tileSize - y) * noiseScale);
  float noiseFlipThree = noise((tileSize - x) * noiseScale, (tileSize - y) * noiseScale);

  float noiseAverage = (noiseOriginal + noiseFlipOne + noiseFlipTwo + noiseFlipThree) / 4;

  float noiseOutput;

  float[] distance = {
    y, // North
    tileSize - x, // East
    tileSize - y, // South
    x  // West
  };

  float location;

  if (distance[0] == min(distance)) {
    // North
    if (distance[0] > tileSize - barrier) {
      noiseOutput = noiseOriginal;
    } else {
      location = norm(y, 0, tileSize - barrier);
      noiseOutput = (noiseOriginal * location) + (noiseAverage * (1-location));
    }
  } else if (distance[1] == min(distance)) {
    // East
    if (distance[1] > tileSize - barrier) {
      noiseOutput = noiseOriginal;
    } else {
      location = norm(x, barrier, tileSize);
      noiseOutput = (noiseOriginal * (1-location)) + (noiseAverage * location);
    }
  } else if (distance[2] == min(distance)) {
    // South
    if (distance[2] > tileSize - barrier) {
      noiseOutput = noiseOriginal;
    } else {
      location = norm(y, barrier, tileSize);
      noiseOutput = (noiseOriginal * (1-location)) + (noiseAverage * location);
    }
  } else {
    // West
    if (distance[3] > tileSize - barrier) {
      noiseOutput = noiseOriginal;
    } else {
      location = norm(x, 0, tileSize - barrier);
      noiseOutput = (noiseOriginal * location) + (noiseAverage * (1-location));
    }
  }

  return noiseOutput;
}
