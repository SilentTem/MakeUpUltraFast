#version 120
/* MakeUp Ultra Fast - composite.fsh
Render: Composite after gbuffers

Javier Garduño - GNU Lesser General Public License v3.0
*/

#define AA 4 // [0 4 6 12] Set antialiasing quality
#define TONEMAP 0 // [0 1 2] Set tonemap
#define CROSS 0 // [0 1] Activate color crossprocess

// 'Global' constants from system
uniform sampler2D colortex0;
uniform ivec2 eyeBrightnessSmooth;
// uniform float aspectRatio;
uniform float viewWidth;
uniform float viewHeight;
uniform int worldTime;

// Varyings (per thread shared variables)
varying vec2 texcoord;

#include "/lib/color_utils_nether.glsl"
#include "/lib/fxaa_intel.glsl"
#include "/lib/tone_maps.glsl"

void main() {
  // x: Block, y: Sky ---
  float candle_bright = (eyeBrightnessSmooth.x / 240.0) * .1;
  
  exposure = 1.0;

	vec3 color = texture2D(colortex0, texcoord).rgb;

	#if AA != 0
		color = fxaa311(color, AA);
	#endif

	color *= exposure;
  color = tonemap(color);

  gl_FragData[0] = vec4(color, 1.0);
	gl_FragData[1] = vec4(0.0); // ¿Performance?
}
