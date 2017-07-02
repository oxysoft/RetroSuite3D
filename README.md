# RetroSuite3D
Some image effects and shaders to achieve a retro look in Unity.

This suite contains the following effects and shaders

* **Fixed palette:** Define any number of color and it will remap the final image to the defined colors
* **Graded palette:** Same as above but a bit more automated, lets you define gradients instead and it will fill in the blanks. You can also set the blending between each gradients. (e.g. AB <-> CD, gradients are created between A and B, and C and D, but you can also adjust a blending constant to blend B and C together, for a more consistant look)
* **Dithering:** Lets you set any dithering pattern you want, defined as a pattern image. You can adjust the strength and treshold.
* **Resolution downsampler:** Force the final resolution to a defined resolution.
* **Posterize effect:** Color quantization, nothing too fancy, simply linear quantization. Non-linear quantization could be nice however in the future.

![Fixed palette](Media/e1.png) ![Posterization](Media/e2.png) ![Graded palette](Media/e3.png)

Open the included scene and observe how it is setup (check the scripts attached to the camera)

![](Media/scene.png)