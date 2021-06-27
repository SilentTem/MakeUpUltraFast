#version 120
/* MakeUp - gbuffers_clouds.vsh
Render: sky, clouds

Javier Garduño - GNU Lesser General Public License v3.0
*/

#define NETHER
#define NO_SHADOWS

#include "/lib/config.glsl"
#include "/lib/color_utils_nether.glsl"

uniform float far;
uniform int current_hour_floor;
uniform int current_hour_ceil;
uniform float current_hour_fract;

// Varyings (per thread shared variables)
varying vec2 texcoord;
varying vec4 tint_color;

#if AA_TYPE > 0
  #include "/src/taa_offset.glsl"
#endif

void main() {
  texcoord = gl_MultiTexCoord0.xy;
  tint_color = gl_Color;
  #include "/src/position_vertex.glsl"
}
