#version 300 es

precision highp float;
precision lowp sampler2D;
precision mediump sampler2DShadow;

in vec2 var_uv;

layout(std140) uniform glfx_GLOBAL
{
    mat4 glfx_MVP;
    mat4 glfx_PROJ;
    mat4 glfx_MV;
    vec4 glfx_VIEW_QIAT;
    vec4 text_color;
};

layout( location = 0 ) out vec4 frag_color;

uniform sampler2D glfx_TEXT0;

void main()
{
    vec3 base = text_color.xyz;
    float opacity = texture(glfx_TEXT0,var_uv).x * text_color.w;

    vec3 color = 0.03*base;

    frag_color = vec4(color,opacity);

}