#version 330
#extension GL_ARB_separate_shader_objects : enable

const float PI = 3.1415926535897932384626433832795;
const float PI_2 = 1.57079632679489661923;

layout(location=0) in vec2 inPos;
layout(location=1) in vec2 inTex;

out gl_PerVertex
{
	vec4 gl_Position;
};
layout(location=1) out vec2 fsTex;
layout(location=2) out vec4 vertexColor;

uniform mat4 proj;
uniform mat4 world;

uniform vec4 colorCenter;
uniform vec4 colorMax;

uniform float maxSize;

// Polar coordinate utility functions
float hypot(vec2 pos)
{
  return sqrt(pos.x * pos.x + pos.y * pos.y);
}

/*
float atan2(vec2 pos)
{
  if (pos.x > 0)
  {
    return atan(pos.y / pos.x);
  }

  if (pos.x < 0 && pos.y >= 0)
  {
    return atan(pos.y / pos.x) + PI;
  }

  if (pos.x < 0 && pos.y < 0)
  {
    return atan(pos.y / pos.x) - PI;
  }

  if (pos.x == 0 && pos.y > 0)
  {
    return PI_2;
  }

  if (pos.x == 0 && pos.y < 0)
  {
    return -PI_2;
  }

  // The following is not mathematically correct, as it's undefined
  return 0.0;
}

vec2 toPolar(vec2 cartesian)
{
  return vec2(hypot(pos), atan2(pos));
}
*/

float lerp(float x, vec2 p0, vec2 p1)
{
  return p0.y + (p1.y - p0.y) * ((x - p0.x)/(p1.x - p0.x));
}

// x is in [0.0, 1.0]
vec4 lerpColor(float x, vec4 color1, vec4 color2)
{
  return color1 + (color2 - color1) * x;
}

vec4 coordToColor(vec2 pos, float maxSize)
{
  float r = hypot(pos);
  //float phi = atan2(pos);

  float factor = lerp(r, vec2(0,0), vec2(maxSize,1));

  return lerpColor(factor, colorCenter, colorMax);
}

void main()
{
  gl_Position = proj * world * vec4(inPos.xy, 0, 1);
  vertexColor = coordToColor(inPos.xy, maxSize);
}
