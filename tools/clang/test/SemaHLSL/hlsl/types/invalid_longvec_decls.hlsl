// RUN: %dxc -E vret_main  -DTYPE=float -DNUM=7 -T vs_6_9 -verify %s
// RUN: %dxc -E vparm_main -DTYPE=float -DNUM=7 -T vs_6_9 -verify %s
// RUN: %dxc -E sparm_main -DTYPE=float -DNUM=7 -T vs_6_9 -verify %s

struct LongVec {
  float4 f;
  vector<TYPE,NUM> vec;
};

struct LongVecParm {
  float3 f : SV_Position;
  vector<TYPE,NUM> vec;
};

vector<TYPE, NUM> global_vec;// expected-error{{Vectors of over 4 elements in cbuffers are not supported}}

vector<TYPE, NUM> global_vec_arr[10];

LongVec global_vec_rec;

cbuffer BadBuffy {
  vector<TYPE, NUM> cb_vec;// expected-error{{Vectors of over 4 elements in cbuffers are not supported}}
  vector<TYPE, NUM> cb_vec_arr[10];
  LongVec cb_vec_rec;
};

ConstantBuffer< LongVec > const_buf;
TextureBuffer< LongVec > tex_buf;

vector<TYPE, NUM> vret_main() : SV_Position {
  vector<TYPE, NUM> ret = 4.0;
  return ret;
}

float3 vparm_main(vector<TYPE, NUM> vec : V) : SV_Position {
  return vec[0];
}

float3 sparm_main(LongVecParm vec) : SV_Position {
   return vec.f;
}

