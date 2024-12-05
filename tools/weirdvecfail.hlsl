// RUN: %dxc -Wno-conversion -T ps_6_9       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T ps_6_9 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64

// This fails to compile with a weird error regarding incompatible vector types even though
// no attempt is made to use those types together.
ByteAddressBuffer buf;

template <typename T, int N>
vector<T, N> dostuff(vector<T, N> thing1) {
  vector<T, N> res = 0;

  // This and all following lines produce a similar error:
  // error: cannot convert from 'vector<double, 4>' to 'vector<double, 8>'
  // res += exp(thing1);
  res += exp(thing1);
  res += log(thing1);
  res += tanh(thing1);
  res += atan(thing1);

  return res;
} // This is fine with double3

# if 0
template <typename T>
T dostuff2(T thing1) {
  T res = 0;

  // This and all following lines produce a similar error:
  // error: cannot convert from 'vector<double, 4>' to 'vector<double, 8>'
  // res += exp(thing1);
  res += exp(thing1);
  res += log(thing1);
  res += tanh(thing1);
  res += atan(thing1);

  return res;
} // this is NOT!!
#endif

float4 main() : SV_Target {
  vector<double, 6> vec6 = buf.Load<vector<double, 6> >(0);
  vector<double, 7> vec7 = buf.Load<vector<double, 7> >(0);
  vector<double, 8> vec8 = buf.Load<vector<double, 8> >(0);

  dostuff(vec6);
  dostuff(vec7);
  dostuff(vec8);

  // Somehow this line is confusing things so that it instantiates dostuff for double7,
  // but the variable vec1 is passed in as double4?
  // Something like that.
  // I don't think it has to do with the vector cap directly because 6 is fine, but 7 isn't
  // I think it might be if we have a vector that equals the the remainder of 4 of the instantiated vector value used in exp and friends.
  double3 gs_vec3; // this is fine with vec8, fails with vec7
  double4 gs_vec4; // this is fine with vec7, fails with vec8

  return 0.0;
}

