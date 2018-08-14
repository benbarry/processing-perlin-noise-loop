# Processing Perlin Noise Tiled Loop
This was the first solution I came up with. It worked well for my needs at the time, but I wasn't satisfied it was the best solution. I'm leaving it here in case it helps someone else in the future.

### Example Video
* https://player.vimeo.com/video/284445212

### Inspiration came from:
* https://forum.processing.org/one/topic/how-to-make-perlin-noise-loop.html
* https://processing.org/discourse/alpha/board_Contribution_Simlation_action_display_num_1088808238.html
<br>
<hr>

### Below is a brief illustrated explanation of this solution.

To start with we generate some random Perlin noise and tile it into a 2x2 grid.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-1.png" width="400">

We then take each tile and mirror it three times (horizontal, vertical, and simultaneously horizontal and vertical). We average each point of these three with original tile to create a tile that seamless.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-2.png" width="400">

Because the new averaged tile doesn't appear as random as we'd like, we blend it to just show the edge.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-3.png" width="400">

This leaves the middle of our tile as our original random noise.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-4.png" width="400">

The result is a tile that appears both random and seamless.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-5.png" width="400">

This allows us to move through the noise space and have an end point at which our noise is identical to where we started.<br>
<img src="https://github.com/benbarry/processing-perlin-noise-loop/blob/master/readme-files/step-6.png" width="400">
