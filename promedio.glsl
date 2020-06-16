#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const vec4 lumcoeff = vec4(0.299, 0.587, 0.114, 0);
vec3 prom_rgb = vec3(1.0, 1.0, 1.0);

void main() {
  vec4 col = texture2D(texture, vertTexCoord.st);
  float tmp = (dot(prom_rgb, col.rgb) / 3);
  gl_FragColor = vec4(tmp, tmp, tmp, 1);
}