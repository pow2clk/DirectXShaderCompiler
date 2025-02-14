// RUN: %dxc  -DTYPE=float -DNUM=7 -T ps_6_9 -verify %s

struct LongVec {
  float4 f;
  vector<TYPE,NUM> vec;
};

struct LongVecParm {
  float f;
  float4 tar2 : SV_Target2;
  vector<TYPE,NUM> vec;
};

vector<TYPE, NUM> global_vec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}

vector<TYPE, NUM> global_vec_arr[10]; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}

LongVec global_vec_rec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}

cbuffer BadBuffy {
  vector<TYPE, NUM> cb_vec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
  vector<TYPE, NUM> cb_vec_arr[10]; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
  LongVec cb_vec_rec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
};

tbuffer BadTuffy {
  vector<TYPE, NUM> cb_vec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
  vector<TYPE, NUM> cb_vec_arr[10]; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
  LongVec cb_vec_rec; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
};

ConstantBuffer< LongVec > const_buf; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
TextureBuffer< LongVec > tex_buf; // expected-error{{Vectors of over 4 elements in cbuffers are not supported}}

vector<TYPE, 5> main( // expected-error{{Vectors of over 4 elements in entry function return type are not supported}}
                     vector<TYPE, NUM> vec : V, // expected-error{{Vectors of over 4 elements in entry function parameters are not supported}}
                     LongVecParm parm, Buffer buf : B) : SV_Target { // expected-error{{Vectors of over 4 elements in entry function parameters are not supported}}
  parm.f = vec; // expected-warning {{implicit truncation of vector type}}
  parm.tar2 = vec; // expected-warning {{implicit truncation of vector type}}
  return vec; // expected-warning {{implicit truncation of vector type}}
}

