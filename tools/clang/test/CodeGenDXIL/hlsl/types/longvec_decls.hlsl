// RUN: %dxc -DTYPE=float -DNUM=4 -T lib_6_9 %s | FileCheck %s

struct LongVec {
  float4 f;
  vector<TYPE,NUM> vec;
};

static vector<TYPE, NUM> static_vec;
static vector<TYPE, NUM> static_vec_arr[10];
static LongVec static_vec_rec;

groupshared vector<TYPE, NUM> gs_vec;
groupshared vector<TYPE, NUM> gs_vec_arr[10];
groupshared LongVec gs_vec_rec;

export vector<TYPE, NUM> lv_param_passthru(vector<TYPE, NUM> vec1) {
  vector<TYPE, NUM> ret = vec1;
  return ret;
}

export void lv_global_assign(vector<TYPE, NUM> vec) {
  static_vec = vec;
}

export vector<TYPE, NUM> lv_global_ret() {
  vector<TYPE, NUM> ret = static_vec;
  return ret;
}

export void lv_gs_assign(vector<TYPE, NUM> vec) {
  gs_vec = vec;
}

export vector<TYPE, NUM> lv_gs_ret() {
  vector<TYPE, NUM> ret = gs_vec;
  return ret;
}

export vector<TYPE, NUM> lv_param_arr_passthru(vector<TYPE, NUM> vec)[10] {
  vector<TYPE, NUM> ret[10];
  for (int i = 0; i < 10; i++)
    ret[i] = vec;
  return ret;
}

export void lv_global_arr_assign(vector<TYPE, NUM> vec[10]) {
  for (int i = 0; i < 10; i++)
    static_vec_arr[i] = vec[i];
}

export vector<TYPE, NUM> lv_global_arr_ret()[10] {
  vector<TYPE, NUM> ret[10];
  for (int i = 0; i < 10; i++)
    ret[i] = static_vec_arr[i];
  return ret;
}

export void lv_gs_arr_assign(vector<TYPE, NUM> vec[10]) {
  for (int i = 0; i < 10; i++)
    gs_vec_arr[i] = vec[i];
}

export vector<TYPE, NUM> lv_gs_arr_ret()[10] {
  vector<TYPE, NUM> ret[10];
  for (int i = 0; i < 10; i++)
    ret[i] = gs_vec_arr[i];
  return ret;
}

export LongVec lv_param_rec_passthru(LongVec vec) {
  LongVec ret = vec;
  return ret;
}

export void lv_global_rec_assign(LongVec vec) {
  static_vec_rec = vec;
}

export LongVec lv_global_rec_ret() {
  LongVec ret = static_vec_rec;
  return ret;
}

export void lv_gs_rec_assign(LongVec vec) {
  gs_vec_rec = vec;
}

export LongVec lv_gs_rec_ret() {
  LongVec ret = gs_vec_rec;
  return ret;
}

export vector<TYPE,NUM> lv_splat(TYPE scalar) {
  vector<TYPE,NUM> ret = scalar;
  return ret;
}

export vector<TYPE, 6> lv_initlist() {
  vector<TYPE, 6> ret = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
  return ret;
}

export vector<TYPE, 6> lv_initlist_vec(vector<TYPE, 3> vec) {
  vector<TYPE, 6> ret = {vec, 4.0, 5.0, 6.0};
  return ret;
}

export vector<TYPE, 6> lv_vec_vec(vector<TYPE, 3> vec1, vector<TYPE, 3> vec2) {
  vector<TYPE, 6> ret = {vec1, vec2};
  return ret;
}

export vector<TYPE, NUM> lv_array_cast(TYPE arr[NUM]) {
  vector<TYPE, NUM> ret = (vector<TYPE,NUM>)arr;
  return ret;
}

export vector<TYPE, 6> lv_ctor(vector<TYPE, 3> vec) {
  vector<TYPE, 6> ret = vector<TYPE,6>(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
  return ret;
}

