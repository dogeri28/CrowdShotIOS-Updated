#version 300 es

layout( location = 0 ) in vec3 attrib_pos;

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

out vec2 var_body_mask_uv;
out vec2 var_uv;
out vec4 body_color;

vec3 quat_rotate( vec4 q, vec3 v )
{
    return v + 2.*cross( q.xyz, cross( q.xyz, v ) + q.w*v );
}

uniform sampler2D glfx_BODY_MASK;

void main()
{
    vec2 v = attrib_pos.xy;
    gl_Position = vec4( v, 1., 1. );
    var_uv = v*0.5 + 0.5;

    mat2x3 body_basis = mat2x3(glfx_BODY_MASK_T[0].xyz, glfx_BODY_MASK_T[1].xyz);
    var_body_mask_uv = vec3(v,1.)*body_basis;
    body_color = js_body_color;
}
