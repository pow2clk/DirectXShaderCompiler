// RUN: %dxc -Tlib_6_9 -verify %s

// TODO add signature testing.

vector<float, 8> vec1; // expected-error {{Vectors of over 4 elements in cbuffers are not supported}}
cbuffer CBUF {
  vector<float, 8> vec2; // expected-error {{Vectors of over 4 elements in cbuffers are not supported}}
};

groupshared vector<float, 8> vec34;
static vector<float, 8> vec4;

export
vector<double, 3> doit(vector<double, 5> vec5) {
  vec5.x = 1; // expected-error {{Invalid swizzle 'x' on vector of over 4 elements.}}
  return vec5.xyw; // expected-error {{Invalid swizzle 'xyw' on vector of over 4 elements.}}
}
