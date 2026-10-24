#version 330
#extension GL_ARB_separate_shader_objects : enable

layout(location=1) in vec2 fsTex;
layout(location=0) out vec4 target;
layout(location=2) in vec4 inColor;

void main()
{
  target = inColor;
}
