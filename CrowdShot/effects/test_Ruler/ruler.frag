#version 300 es

precision highp float;

in vec2 var_uv;

layout(location = 0) out vec4 F;

uniform sampler2D glfx_BACKGROUND;

void main()
{
    F = texture(glfx_BACKGROUND, var_uv);
}
