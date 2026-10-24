#version 330
#extension GL_ARB_separate_shader_objects : enable

const float PI = 3.1415926535897932384626433832795;
const float PI_2 = 1.57079632679489661923;

layout(location=1) in vec2 fsTex;
layout(location=2) in vec3 fragPos;

layout(location=0) out vec4 target;

uniform vec4 colorCenter;
uniform vec4 colorMax;

uniform float maxSize;

float lerp(float x, vec2 p0, vec2 p1)
{
  return p0.y + (p1.y - p0.y) * ((x - p0.x)/(p1.x - p0.x));
}

vec4 toHSV(vec4 rgb)
{
  vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
  vec4 p = mix(vec4(rgb.bg, K.wz), vec4(rgb.gb, K.xy), step(rgb.b, rgb.g));
  vec4 q = mix(vec4(p.xyw, rgb.r), vec4(rgb.r, p.yzx), step(p.x, rgb.r));

  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return vec4(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x, rgb.a);
}

vec4 toRGB(vec4 hsv)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(hsv.xxx + K.xyz) * 6.0 - K.www);
    return vec4(hsv.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), hsv.y), hsv.a);
}

// x is in [0.0, 1.0]
vec4 lerpColor(float x, vec4 color1, vec4 color2)
{
  // convert RGB color space to HSV
  vec4 hsv1 = toHSV(color1), hsv2 = toHSV(color2);
  float hue = (mod(mod((hsv2.x-hsv1.x), 1.) + 1.5, 1.)-0.5)*x + hsv1.x;
  vec4 hsv = vec4(hue, mix(hsv1.yzw, hsv2.yzw, x));
  // convert HSV color space back to RGB
  return toRGB(hsv);
}

float EaseInSine(float x)
{
    return 1.0 - cos((x * PI) / 2.0);
}

vec4 coordToColor(vec2 pos, float maxSize)
{
  float r = length(pos);
  float factor = lerp(r, vec2(0,0), vec2(maxSize,1));
  return lerpColor(EaseInSine(factor), colorCenter, colorMax);
}

void main()
{
  target = coordToColor(fragPos.xy, maxSize);
}
