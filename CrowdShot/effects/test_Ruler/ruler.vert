#version 300 es

layout(location = 0) in vec3 attrib_pos;

layout(std140) uniform glfx_GLOBAL
{
    mat4 glfx_MVP;
    mat4 glfx_PROJ;
    mat4 glfx_MV;
    vec4 glfx_VIEW_QUAT;
    vec4 js_body_color;
};

layout(std140) uniform glfx_BASIS_DATA
{
    vec4 unused;
    vec4 glfx_SCREEN;
    vec4 glfx_BG_MASK_T[2];
    vec4 glfx_HAIR_MASK_T[2];
    vec4 glfx_LIPS_MASK_T[2];
    vec4 glfx_L_EYE_MASK_T[2];
    vec4 glfx_R_EYE_MASK_T[2];
    vec4 glfx_SKIN_MASK_T[2];
    vec4 glfx_OCCLUSION_MASK_T[2];
    vec4 glfx_LIPS_SHINE_MASK_T[2];
    vec4 glfx_HAIR_STRAND_MASK_T[2];
    vec4 glfx_BODY_MASK_T[2];
};

out vec2 var_uv;

void main()
{
    vec2 v = attrib_pos.xy;
    gl_Position = vec4( v, 1., 1. );
    var_uv = v*0.5 + 0.5;
}
