#version 300 es

precision highp float;

in vec2 var_uv;
in vec2 var_skin_smooth_uv;
in float var_smooth_value;

layout(location = 0) out vec4 F;

uniform sampler2D glfx_BACKGROUND;
uniform sampler2D glfx_SKIN_SMOOTH_HALF_STUFF;

void main()
{
    vec3 bg = texture(glfx_BACKGROUND, var_uv).rgb;
    vec4 skin_smooth = texture(glfx_SKIN_SMOOTH_HALF_STUFF, var_skin_smooth_uv);
    const float treshold = 0.8;
    if (skin_smooth.a > treshold) {
        F = vec4((1. - var_smooth_value) * bg + var_smooth_value * skin_smooth.rgb, 1.0);
    } else {
        F = vec4(bg, 1.0);
    }
}
