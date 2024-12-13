// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=1       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=1 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=2       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=2 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=3       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=3 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=4       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=4 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=5       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=5 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=6       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=6 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=7       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=7 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=8       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=8 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=9       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=9 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=10       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=10 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=11       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=11 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=12       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=12 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=13       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=13 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=14       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=14 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=15       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=15 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=16       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=16 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=17       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=17 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=18       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=18 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=128       %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T cs_6_9 -DELTS=128 -DF64 %s | Filecheck %s --check-prefixes=CHECK,F64

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

// Main test function overloads. One expects matching element types.
// The others uses different types to test ops and overload resolution.
template <typename T, int N> vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N> thing3);
template <int N> vector<TYPE, N> dostuff(vector<TYPE, N> thing1, vector<UNTYPE, N> thing2, vector<TYPE, N> thing3);
template<typename T, int N> vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N+1> thing3);
vector<TYPE, ELTS> dospecificstuff(vector<TYPE, ELTS> thing1, vector<TYPE, ELTS> thing2, vector<TYPE, ELTS> thing3);


// Just a trick to capture the needed type spellings since the DXC version of FileCheck can't do that explicitly.
// F32-DAG: %dx.types.ResRet.[[TY:f32]] = type { [[TYPE:float]]
// F32-DAG: %dx.types.ResRet.[[UNTY:f64]] = type { [[UNTYPE:double]]
// F64-DAG: %dx.types.ResRet.[[TY:f64]] = type { [[TYPE:double]]
// F64-DAG: %dx.types.ResRet.[[UNTY:f32]] = type { [[UNTYPE:float]]

// Verify that groupshared vectors are kept as aggregates
// CHECK: @"\01?gs_vec1@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A" = external addrspace(3) global <[[ELTS:[0-9]*]] x [[TYPE]]>
// CHECK: @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A" = external addrspace(3) global <[[ELTS]] x [[TYPE]]>
// CHECK: @"\01?gs_vec3@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A" = external addrspace(3) global <[[ELTSp1:[0-9]*]] x [[TYPE]]>
groupshared vector<TYPE, ELTS> gs_vec1, gs_vec2;
groupshared vector<TYPE, ELTS+1> gs_vec3;

[numthreads(8,1,1)]
void main() {

  // CHECK: [[buf:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer

  // A contrivance to capture the vec size - 1.
  // CHECK: call void @dx.op.rawBufferStore.i32(i32 140, %dx.types.Handle [[buf]], i32 10000, i32 undef, i32 [[ELTSm1:[0-9]*]]
  buf.Store<int>(10000, ELTS-1);

  // CHECK: [[buf:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 4107, i32 0 })  ; AnnotateHandle(res,props)  resource: RWByteAddressBuffer

  // CHECK: call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 0
  // CHECK-DAG: [[vec1:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F32-DAG: [[vec1_32:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F64-DAG: [[vec1_64:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  vector<TYPE, ELTS> vec1 = buf.Load<vector<TYPE, ELTS> >(0);

  // CHECK: call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 60
  // CHECK-DAG: [[vec2:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F32-DAG: [[vec2_32:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F64-DAG: [[vec2_64:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  vector<TYPE, ELTS> vec2 = buf.Load<vector<TYPE, ELTS> >(600);

  // CHECK: call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[buf]], i32 120
  // CHECK-DAG: [[vec3:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F32-DAG: [[vec3_32:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F64-DAG: [[vec3_64:%.*]] = insertelement <[[ELTS]] x [[TYPE]]> {{.*}}, [[TYPE]] {{%.*}}, i64 [[ELTSm1]]
  vector<TYPE, ELTS> vec3 = buf.Load<vector<TYPE, ELTS> >(1200);

  // CHECK: call %dx.types.ResRet.[[UNTY]] @dx.op.rawBufferLoad.[[UNTY]](i32 139, %dx.types.Handle [[buf]], i32 180
  // CHECK-DAG: [[unvec:%.*]] = insertelement <[[ELTS]] x [[UNTYPE]]> {{.*}}, [[UNTYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F32-DAG: [[unvec_64:%.*]] = insertelement <[[ELTS]] x [[UNTYPE]]> {{.*}}, [[UNTYPE]] {{%.*}}, i64 [[ELTSm1]]
  // F64-DAG: [[unvec_32:%.*]] = insertelement <[[ELTS]] x [[UNTYPE]]> {{.*}}, [[UNTYPE]] {{%.*}}, i64 [[ELTSm1]]
  vector<UNTYPE, ELTS> unvec = buf.Load<vector<UNTYPE, ELTS> >(1800);

  // Just some jumps to keep things interesting.
  // Test vectors of equal type and size.
  vec1 = dostuff(vec1, vec2, vec3);

  // Test mixed type operations
  vec2 = dostuff(vec2, unvec, vec3);

  // Test groupshared vectors of different sizes.
  gs_vec2 = dostuff(gs_vec1, gs_vec2, gs_vec3);

  // Test groupshared and default namespace vectors.
  gs_vec1 = dospecificstuff(vec3, gs_vec2, gs_vec1);

  buf.Store<vector<TYPE, ELTS> >(2400, vec1 * vec2 - vec3 * gs_vec1 + gs_vec2 / gs_vec3);
}

//  Test the required ops on long vectors and confirm correct lowering.
template <typename T, int N>
vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N> thing3) {
  vector<T, N> res = 0;

  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[vec1]], <[[ELTS]] x [[TYPE]]> [[vec2]])  ; FMin(a,b)
  res += min(thing1, thing2);
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[vec1]], <[[ELTS]] x [[TYPE]]> [[vec3]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[vec1]], <[[ELTS]] x [[TYPE]]> [[vec2]])  ; FMax(a,b)
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[tmp]], <[[ELTS]] x [[TYPE]]> [[vec3]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // F32: [[vec3_64:%.*]] = fpext <[[ELTS]] x float> [[vec3]] to <[[ELTS]] x double>
  // F32: [[vec2_64:%.*]] = fpext <[[ELTS]] x float> [[vec2]] to <[[ELTS]] x double>
  // F32: [[vec1_64:%.*]] = fpext <[[ELTS]] x float> [[vec1]] to <[[ELTS]] x double>
  // CHECK: call <[[ELTS]] x double> @dx.op.tertiary.v[[ELTS]]f64(i32 47, <[[ELTS]] x double> [[vec1_64]], <[[ELTS]] x double> [[vec2_64]], <[[ELTS]] x double> [[vec3_64]]) ; Fma(a,b,c)
  res += (vector<T, N>)fma((vector<double, N>)thing1, (vector<double, N>)(thing2), (vector<double, N>)thing3);

  // Even in the double test, these will be downconverted because these builtins only take floats.
  // F64: [[vec2_32:%.*]] = fptrunc <[[ELTS]] x double> [[vec2]] to <[[ELTS]] x float>
  // F64: [[vec1_32:%.*]] = fptrunc <[[ELTS]] x double> [[vec1]] to <[[ELTS]] x float>

  // CHECK: [[tmp:%.*]] = fcmp fast olt <[[ELTS]] x float> [[vec2_32]], [[vec1_32]]
  // CHECK: select <[[ELTS]] x i1> [[tmp]], <[[ELTS]] x [[TYPE]]> zeroinitializer, <[[ELTS]] x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <[[ELTS]] x float> [[vec1_32]], <float 0x
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 21, <[[ELTS]] x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 23, <[[ELTS]] x float> [[vec1_32]])  ; Log(value)
  res += log(thing1);

  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 20, <[[ELTS]] x float> [[vec1_32]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 17, <[[ELTS]] x float> [[vec1_32]])  ; Atan(value)
  res += atan(thing1);

  return res;
}

// A mixed-type overload to test overload resolution and mingle different vector element types in ops
template<int N>
vector<TYPE, N> dostuff(vector<TYPE, N> thing1, vector<UNTYPE, N> thing2, vector<TYPE, N> thing3) {
  vector<TYPE, N> res = 0;

  // F64: [[unvec_64:%.*]] = fpext <[[ELTS]] x float> [[unvec]] to <[[ELTS]] x double>
  // CHECK: call <[[ELTS]] x double> @dx.op.binary.v[[ELTS]]f64(i32 36, <[[ELTS]] x double> [[vec2_64]], <[[ELTS]] x double> [[unvec_64]])  ; FMin(a,b)
  res += min(thing1, thing2);

  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[vec2]], <[[ELTS]] x [[TYPE]]> [[vec3]]) ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x double> @dx.op.binary.v[[ELTS]]f64(i32 35, <[[ELTS]] x double> [[vec2_64]], <[[ELTS]] x double> [[unvec_64]])  ; FMax(a,b)
  // CHECK: call <[[ELTS]] x double> @dx.op.binary.v[[ELTS]]f64(i32 36, <[[ELTS]] x double> [[tmp]], <[[ELTS]] x double> [[vec3_64]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // CHECK: call <[[ELTS]] x double> @dx.op.tertiary.v[[ELTS]]f64(i32 47, <[[ELTS]] x double> [[vec2_64]], <[[ELTS]] x double> [[unvec_64]], <[[ELTS]] x double> [[vec3_64]]) ; Fma(a,b,c)
  res += (vector<TYPE, ELTS>)fma((vector<double,ELTS>)thing1, (vector<double,ELTS>)(thing2), (vector<double,ELTS>)thing3);

  // F32: [[unvec_32:%.*]] = fptrunc <[[ELTS]] x double> [[unvec]] to <[[ELTS]] x float>
  // CHECK: [[tmp:%.*]] = fcmp fast olt <[[ELTS]] x float> [[unvec_32]], [[vec2_32]]
  // CHECK: select <[[ELTS]] x i1> [[tmp]], <[[ELTS]] x [[TYPE]]> zeroinitializer, <[[ELTS]] x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <[[ELTS]] x float> [[vec2_32]], <float 0x
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 21, <[[ELTS]] x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 23, <[[ELTS]] x float> [[vec2_32]])  ; Log(value)
  res += log(thing1);

  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 20, <[[ELTS]] x float> [[vec2_32]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 17, <[[ELTS]] x float> [[vec2_32]])  ; Atan(value)
  res += atan(thing1);

  return res;
}

// Test with different sized vectors.
// Used for groupshared tests.
template<typename T, int N>
vector<T, N> dostuff(vector<T, N> thing1, vector<T, N> thing2, vector<T, N+1> thing3) {
  vector<T, N> res = 0;

  // CHECK: [[gs_vec3_pre:%.*]] = load <[[ELTSp1]] x [[TYPE]]>, <[[ELTSp1]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec3@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // CHECK-DAG: [[gs_vec2:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F32-DAG: [[gs_vec2_32:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F64-DAG: [[gs_vec2_64:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // CHECK-DAG: [[gs_vec1:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec1@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F32-DAG: [[gs_vec1_32:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec1@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F64-DAG: [[gs_vec1_64:%.*]] = load <[[ELTS]] x [[TYPE]]>, <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec1@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"

  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[gs_vec1]], <[[ELTS]] x [[TYPE]]> [[gs_vec2]])  ; FMin(a,b)
  res += min(thing1, thing2);
  // CHECK-DAG: [[gs_vec3:%.*]] = shufflevector <[[ELTSp1]] x [[TYPE]]> [[gs_vec3_pre]], <[[ELTSp1]] x [[TYPE]]> undef, <[[ELTS]] x i32>
  // F64-DAG: [[gs_vec3_64:%.*]] = shufflevector <[[ELTSp1]] x [[TYPE]]> [[gs_vec3_pre]], <[[ELTSp1]] x [[TYPE]]> undef, <[[ELTS]] x i32>
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[gs_vec1]], <[[ELTS]] x [[TYPE]]> [[gs_vec3]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[gs_vec1]], <[[ELTS]] x [[TYPE]]> [[gs_vec2]])  ; FMax(a,b)
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[tmp]], <[[ELTS]] x [[TYPE]]> [[gs_vec3]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // F32: [[gs_vec3_64:%.*]] = fpext <[[ELTS]] x float> [[gs_vec3]] to <[[ELTS]] x double>
  // F32: [[gs_vec2_64:%.*]] = fpext <[[ELTS]] x float> [[gs_vec2]] to <[[ELTS]] x double>
  // F32: [[gs_vec1_64:%.*]] = fpext <[[ELTS]] x float> [[gs_vec1]] to <[[ELTS]] x double>
  // CHECK: call <[[ELTS]] x double> @dx.op.tertiary.v[[ELTS]]f64(i32 47, <[[ELTS]] x double> [[gs_vec1_64]], <[[ELTS]] x double> [[gs_vec2_64]], <[[ELTS]] x double> [[gs_vec3_64]]) ; Fma(a,b,c)
  res += (vector<T, N>)fma((vector<double, N>)thing1, (vector<double, N>)(thing2), (vector<double, N>)thing3);

  // Even in the double test, these will be downconverted because these builtins only take floats.
  // F64: [[gs_vec2_32:%.*]] = fptrunc <[[ELTS]] x double> [[gs_vec2]] to <[[ELTS]] x float>
  // F64: [[gs_vec1_32:%.*]] = fptrunc <[[ELTS]] x double> [[gs_vec1]] to <[[ELTS]] x float>

  // CHECK: [[tmp:%.*]] = fcmp fast olt <[[ELTS]] x float> [[gs_vec2_32]], [[gs_vec1_32]]
  // CHECK: select <[[ELTS]] x i1> [[tmp]], <[[ELTS]] x [[TYPE]]> zeroinitializer, <[[ELTS]] x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <[[ELTS]] x float> [[gs_vec1_32]], <float 0x
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 21, <[[ELTS]] x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 23, <[[ELTS]] x float> [[gs_vec1_32]])  ; Log(value)
  // CHICK: fmul fast <[[ELTS]] x float> [[tmp]], <float 0x
  res += log(thing1);

  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 20, <[[ELTS]] x float> [[gs_vec1_32]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <[[ELTS]] x float> @dx.op.unary.v[[ELTS]]f32(i32 17, <[[ELTS]] x float> [[gs_vec1_32]])  ; Atan(value)
  res += atan(thing1);

  // CHECK-DAG: store <[[ELTS]] x [[TYPE]]> [[gs_vec2:%.*]], <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F32-DAG: store <[[ELTS]] x [[TYPE]]> [[gs_vec2_32:%.*]], <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  // F64-DAG: store <[[ELTS]] x [[TYPE]]> [[gs_vec2_64:%.*]], <[[ELTS]] x [[TYPE]]> addrspace(3)* @"\01?gs_vec2@@3V?$vector@{{M|N}}${{[0-9][0-9A-Z@]*}}@@A"
  return res;
}

vector<TYPE, ELTS> dospecificstuff(vector<TYPE, ELTS> thing1, vector<TYPE, ELTS> thing2, vector<TYPE, ELTS> thing3) {
  vector<TYPE, ELTS> res = 0;

  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[vec3]], <[[ELTS]] x [[TYPE]]> [[gs_vec2]])  ; FMin(a,b)
  res += min(thing1, thing2);
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[vec3]], <[[ELTS]] x [[TYPE]]> [[gs_vec1]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 35, <[[ELTS]] x [[TYPE]]> [[vec3]], <[[ELTS]] x [[TYPE]]> [[gs_vec2]])  ; FMax(a,b)
  // CHECK: call <[[ELTS]] x [[TYPE]]> @dx.op.binary.v[[ELTS]][[TY]](i32 36, <[[ELTS]] x [[TYPE]]> [[tmp]], <[[ELTS]] x [[TYPE]]> [[gs_vec1]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // F32: [[gs_vec2_64:%.*]] = fpext <[[ELTS]] x float> [[gs_vec2]] to <[[ELTS]] x double>
  // CHECK: call <[[ELTS]] x double> @dx.op.tertiary.v[[ELTS]]f64(i32 47, <[[ELTS]] x double> [[vec3_64]], <[[ELTS]] x double> [[gs_vec2_64]], <[[ELTS]] x double> [[gs_vec1_64]]) ; Fma(a,b,c)
  res += (vector<TYPE, ELTS>)fma((vector<double, ELTS>)thing1, (vector<double, ELTS>)(thing2), (vector<double, ELTS>)thing3);

  // F64: [[gs_vec2_32:%.*]] = fptrunc <[[ELTS]] x double> [[gs_vec2]] to <[[ELTS]] x float>
  // F64: [[vec3_32:%.*]] = fptrunc <[[ELTS]] x double> [[vec3]] to <[[ELTS]] x float>
  // CHECK: [[tmp:%.*]] = fcmp fast olt <[[ELTS]] x float> [[gs_vec2_32]], [[vec3_32]]
  // CHECK: select <[[ELTS]] x i1> [[tmp]], <[[ELTS]] x [[TYPE]]> zeroinitializer, <[[ELTS]] x [[TYPE]]> <[[TYPE]] 1
  res += step(thing1, thing2);

  return res;
}
