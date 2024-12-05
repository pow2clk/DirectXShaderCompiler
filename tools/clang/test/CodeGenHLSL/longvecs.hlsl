// RUN: %dxc -Wno-conversion -T cs_6_9       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64

RWByteAddressBuffer buf;

// "TYPE" is the mainly focused test type.
// "UNTYPE" is the other type used for mixed precision testing.
#ifdef F64
typedef double TYPE;
typedef float UNTYPE;
#else
typedef float TYPE;
typedef double UNTYPE;
#endif

// Two main test function overloads. One expects matching element types.
// The other uses different types to test ops and overload resolution.
template <typename T, int N> vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N> thing3);
template <int N> vector<TYPE, N> dostuff(vector<TYPE, N> thing1, vector<UNTYPE, N> thing2, vector<TYPE, N> thing3);

// Just a trick to capture the needed type spellings since the DXC version of FileCheck can't do that explicitly.
// F32-DAG: %dx.types.ResRet.[[TY:f32]] = type { [[TYPE:float]]
// F32-DAG: %dx.types.ResRet.[[UNTY:f64]] = type { [[UNTYPE:double]]
// F64-DAG: %dx.types.ResRet.[[TY:f64]] = type { [[TYPE:double]]
// F64-DAG: %dx.types.ResRet.[[UNTY:f32]] = type { [[UNTYPE:float]]

// Verify that groupshared vectors are kept as aggregates
// CHECK: @"\01?gs_vec1@@3V?$vector@{{M|N}}$07@@A" = external addrspace(3) global <8 x [[TYPE]]>
// CHECK: @"\01?gs_vec2@@3V?$vector@{{M|N}}$07@@A" = external addrspace(3) global <8 x [[TYPE]]>
// CHECK: @"\01?gs_vec3@@3V?$vector@{{M|N}}$07@@A" = external addrspace(3) global <8 x [[TYPE]]>
groupshared vector<TYPE, 8> gs_vec1, gs_vec2, gs_vec3;

[numthreads(8,1,1)]
void main() {
  // CHECK: [[buf:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer

  // CHECK: [[vec1_lo:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 0
  // CHECK: [[vec1_0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_lo]], 0
  // CHECK: [[vec1_1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_lo]], 1
  // CHECK: [[vec1_2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_lo]], 2
  // CHECK: [[vec1_3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_lo]], 3
  // CHECK: [[vec1_hi:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 {{16|32}}
  // CHECK: [[vec1_4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_hi]], 0
  // CHECK: [[vec1_5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_hi]], 1
  // CHECK: [[vec1_6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_hi]], 2
  // CHECK: [[vec1_7:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec1_hi]], 3

  // "Ping" and "pong" variables are just to deal with the nature of filecheck overwriting
  // the variable before it can be used later in the line

  // F32:   [[ping:%.*]] = insertelement <8 x [[TYPE:float]]> undef, float [[vec1_0]]
  // F64:   [[ping:%.*]] = insertelement <8 x [[TYPE:double]]> undef, double [[vec1_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec1_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec1_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec1_6]]
  // CHECK-DAG: [[vec1:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_7]]
  // F32-DAG: [[vec1_32:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_7]]
  // F64-DAG: [[vec1_64:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_7]]
  vector<TYPE, 8> vec1 = buf.Load<vector<TYPE, 8> >(0);

  // CHECK: [[vec2_lo:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 60
  // CHECK: [[vec2_0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_lo]], 0
  // CHECK: [[vec2_1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_lo]], 1
  // CHECK: [[vec2_2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_lo]], 2
  // CHECK: [[vec2_3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_lo]], 3
  // CHECK: [[vec2_hi:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 {{76|92}}
  // CHECK: [[vec2_4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_hi]], 0
  // CHECK: [[vec2_5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_hi]], 1
  // CHECK: [[vec2_6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_hi]], 2
  // CHECK: [[vec2_7:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec2_hi]], 3

  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> undef,    [[TYPE]] [[vec2_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec2_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec2_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec2_6]]
  // CHECK-DAG: [[vec2:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_7]]
  // F32-DAG: [[vec2_32:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_7]]
  // F64-DAG: [[vec2_64:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_7]]
  vector<TYPE, 8> vec2 = buf.Load<vector<TYPE, 8> >(60);

  // CHECK: [[vec3_lo:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 120
  // CHECK: [[vec3_0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_lo]], 0
  // CHECK: [[vec3_1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_lo]], 1
  // CHECK: [[vec3_2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_lo]], 2
  // CHECK: [[vec3_3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_lo]], 3
  // CHECK: [[vec3_hi:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 {{136|152}}
  // CHECK: [[vec3_4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_hi]], 0
  // CHECK: [[vec3_5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_hi]], 1
  // CHECK: [[vec3_6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_hi]], 2
  // CHECK: [[vec3_7:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[vec3_hi]], 3

  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> undef,    [[TYPE]] [[vec3_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec3_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec3_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[TYPE]]> [[pong]], [[TYPE]] [[vec3_6]]
  // CHECK-DAG: [[vec3:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_7]]
  // F64-DAG: [[vec3_64:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_7]]
  vector<TYPE, 8> vec3 = buf.Load<vector<TYPE, 8> >(120);

  // CHECK: [[unvec_lo:%.*]] = call %dx.types.ResRet.[[UNTY]] @dx.op.rawBufferLoad.[[UNTY]](i32 139, %dx.types.Handle [[buf]], i32 180
  // CHECK: [[unvec_0:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_lo]], 0
  // CHECK: [[unvec_1:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_lo]], 1
  // CHECK: [[unvec_2:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_lo]], 2
  // CHECK: [[unvec_3:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_lo]], 3
  // CHECK: [[unvec_hi:%.*]] = call %dx.types.ResRet.[[UNTY]] @dx.op.rawBufferLoad.[[UNTY]](i32 139, %dx.types.Handle [[buf]], i32 {{196|212}}
  // CHECK: [[unvec_4:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_hi]], 0
  // CHECK: [[unvec_5:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_hi]], 1
  // CHECK: [[unvec_6:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_hi]], 2
  // CHECK: [[unvec_7:%.*]] = extractvalue %dx.types.ResRet.[[UNTY]] [[unvec_hi]], 3

  // CHECK: [[ping:%.*]] = insertelement <8 x [[UNTYPE]]> undef,    [[UNTYPE]] [[unvec_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[UNTYPE]]> [[pong]], [[UNTYPE]] [[unvec_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[UNTYPE]]> [[pong]], [[UNTYPE]] [[unvec_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x [[UNTYPE]]> [[pong]], [[UNTYPE]] [[unvec_6]]
  // CHECK-DAG: [[unvec:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_7]]
  // F32-DAG: [[unvec_64:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_7]]
  // F64-DAG: [[unvec_32:%.*]] = insertelement <8 x [[UNTYPE]]> [[ping]], [[UNTYPE]] [[unvec_7]]
  vector<UNTYPE, 8> unvec = buf.Load<vector<UNTYPE, 8> >(180);

  vec1 = dostuff(vec1, vec2, vec3);

  // Test mixed type operations
  vec2 = dostuff(vec2, unvec, vec3);

  gs_vec2 = dostuff(gs_vec1, gs_vec2, gs_vec3);

  // mix groupshared and non
  //vec1 = dostuff(vec1, gs_vec2, vec3);

  buf.Store<vector<TYPE, 8> >(240, vec1 * vec2 - vec3 * gs_vec1 + gs_vec2 / gs_vec3);
}

//  Test the required ops on long vectors and confirm correct lowering.
template <typename T, int N>
vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N> thing3) {
  vector<T, N> res = 0;

  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 36, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec2]])  ; FMin(a,b)
  res += min(thing1, thing2);
  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec3]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec2]])  ; FMax(a,b)
  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 36, <8 x [[TYPE]]> [[tmp]], <8 x [[TYPE]]> [[vec3]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // F32: [[vec3_64:%.*]] = fpext <8 x float> [[vec3]] to <8 x double>
  // F32: [[vec2_64:%.*]] = fpext <8 x float> [[vec2]] to <8 x double>
  // F32: [[vec1_64:%.*]] = fpext <8 x float> [[vec1]] to <8 x double>
  // CHECK: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[vec1_64]], <8 x double> [[vec2_64]], <8 x double> [[vec3_64]]) ; Fma(a,b,c)
  res += (vector<T, N>)fma((vector<double, N>)thing1, (vector<double, N>)(thing2), (vector<double, N>)thing3);

  // Even in the double test, these will be downconverted because these builtins only take floats.
  // F64: [[vec2_32:%.*]] = fptrunc <8 x double> [[vec2]] to <8 x float>
  // F64: [[vec1_32:%.*]] = fptrunc <8 x double> [[vec1]] to <8 x float>

  // CHECK: [[tmp:%.*]] = fcmp fast olt <8 x float> [[vec2_32]], [[vec1_32]]
  // CHECK: select <8 x i1> [[tmp]], <8 x [[TYPE]]> zeroinitializer, <8 x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <8 x float> [[vec1_32]], <float 0x
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 21, <8 x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <8 x float> @dx.op.unary.v8f32(i32 23, <8 x float> [[vec1_32]])  ; Log(value)
  // CHECK: fmul fast <8 x float> [[tmp]], <float 0x
  res += log(thing1);

  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 20, <8 x float> [[vec1_32]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 17, <8 x float> [[vec1_32]])  ; Atan(value)
  res += atan(thing1);

  return res;
}

// A mixed-type overload to test overload resolution and mingle different vector element types in ops
template<int N>
vector<TYPE, N> dostuff(vector<TYPE, N> thing1, vector<UNTYPE, N> thing2, vector<TYPE, N> thing3) {
  vector<TYPE, N> res = 0;

  // F64: [[unvec_64:%.*]] = fpext <8 x float> [[unvec]] to <8 x double>
  // CHECK: call <8 x double> @dx.op.binary.v8f64(i32 36, <8 x double> [[vec2_64]], <8 x double> [[unvec_64]])  ; FMin(a,b)
  res += min(thing1, thing2);

  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec2]], <8 x [[TYPE]]> [[vec3]]) ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <8 x double> @dx.op.binary.v8f64(i32 35, <8 x double> [[vec2_64]], <8 x double> [[unvec_64]])  ; FMax(a,b)
  // CHECK: call <8 x double> @dx.op.binary.v8f64(i32 36, <8 x double> [[tmp]], <8 x double> [[vec3_64]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // CHECK: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[vec2_64]], <8 x double> [[unvec_64]], <8 x double> [[vec3_64]]) ; Fma(a,b,c)
  res += (vector<TYPE, 8>)fma((vector<double,8>)thing1, (vector<double,8>)(thing2), (vector<double,8>)thing3);

  // F32: [[unvec_32:%.*]] = fptrunc <8 x double> [[unvec]] to <8 x float>
  // CHECK: [[tmp:%.*]] = fcmp fast olt <8 x float> [[unvec_32]], [[vec2_32]]
  // CHECK: select <8 x i1> [[tmp]], <8 x [[TYPE]]> zeroinitializer, <8 x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <8 x float> [[vec2_32]], <float 0x
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 21, <8 x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <8 x float> @dx.op.unary.v8f32(i32 23, <8 x float> [[vec2_32]])  ; Log(value)
  // CHECK: fmul fast <8 x float> [[tmp]], <float 0x
  res += log(thing1);

  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 20, <8 x float> [[vec2_32]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 17, <8 x float> [[vec2_32]])  ; Atan(value)
  res += atan(thing1);

  return res;
}
