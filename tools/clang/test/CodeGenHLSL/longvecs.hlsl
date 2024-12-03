// RUN: %dxc -Wno-conversion -T ps_6_9 -DTYPE=float  %s | Filecheck %s --check-prefixes=CHECK,F32
// RUN: %dxc -Wno-conversion -T ps_6_9 -DTYPE=double %s | Filecheck %s --check-prefixes=CHECK,F64

ByteAddressBuffer buf;


template <typename T>
T dostuff(T thing1, T thing2, T thing3);

template <typename T>
T dostuffMixed(T thing1, vector<double,8> thing2, vector<float,8> thing3);

float4 altogetherNow(vector<float, 8> vec1, vector<float, 8> vec2, vector<float, 8> vec3) {
  return vec1.xyzw + float4(vec1[4], vec1[5], vec1[6], vec1[7]) +
    vec2.xyzw + float4(vec2[4], vec2[5], vec2[6], vec2[7]) +
    vec3.xyzw + float4(vec3[4], vec3[5], vec3[6], vec3[7]);
}

vector<TYPE, 8> gs_vec1;
vector<TYPE, 8> gs_vec2;
vector<TYPE, 8> gs_vec3;

float4 main( float f : F, float f2 : F2, float f3 : F3 ) : SV_Target {
  // CHECK: [[buf:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %1, %dx.types.ResourceProperties { i32 11, i32 0 })  ; AnnotateHandle(res,props)  resource: ByteAddressBuffer

  // F32:   [[vec1_lo:%.*]] = call %dx.types.ResRet.[[TY:f32]] @dx.op.rawBufferLoad.f32(i32 139, %dx.types.Handle [[buf]], i32 0
  // F64:   [[vec1_lo:%.*]] = call %dx.types.ResRet.[[TY:f64]] @dx.op.rawBufferLoad.f64(i32 139, %dx.types.Handle [[buf]], i32 0
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
  // CHECK: [[vec1:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec1_7]]
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
  // CHECK: [[vec2:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec2_7]]
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
  // CHECK: [[vec3:%.*]] = insertelement <8 x [[TYPE]]> [[ping]], [[TYPE]] [[vec3_7]]
  vector<TYPE, 8> vec3 = buf.Load<vector<TYPE, 8> >(120);

  // CHECK: [[dvec_lo:%.*]] = call %dx.types.ResRet.f64 @dx.op.rawBufferLoad.f64(i32 139, %dx.types.Handle [[buf]], i32 180
  // CHECK: [[dvec_0:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_lo]], 0
  // CHECK: [[dvec_1:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_lo]], 1
  // CHECK: [[dvec_2:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_lo]], 2
  // CHECK: [[dvec_3:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_lo]], 3
  // CHECK: [[dvec_hi:%.*]] = call %dx.types.ResRet.f64 @dx.op.rawBufferLoad.f64(i32 139, %dx.types.Handle [[buf]], i32 212
  // CHECK: [[dvec_4:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_hi]], 0
  // CHECK: [[dvec_5:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_hi]], 1
  // CHECK: [[dvec_6:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_hi]], 2
  // CHECK: [[dvec_7:%.*]] = extractvalue %dx.types.ResRet.f64 [[dvec_hi]], 3

  // CHECK: [[ping:%.*]] = insertelement <8 x double> undef,    double [[dvec_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x double> [[ping]], double [[dvec_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x double> [[pong]], double [[dvec_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x double> [[ping]], double [[dvec_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x double> [[pong]], double [[dvec_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x double> [[ping]], double [[dvec_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x double> [[pong]], double [[dvec_6]]
  // CHECK: [[dvec:%.*]] = insertelement <8 x double> [[ping]], double [[dvec_7]]
  // Kept to allow testing mixing of types. Need an explicit float too
  vector<double, 8> dvec = buf.Load<vector<double, 8> >(180);

  // CHECK: [[fvec_lo:%.*]] = call %dx.types.ResRet.f32 @dx.op.rawBufferLoad.f32(i32 139, %dx.types.Handle [[buf]], i32 240
  // CHECK: [[fvec_0:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_lo]], 0
  // CHECK: [[fvec_1:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_lo]], 1
  // CHECK: [[fvec_2:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_lo]], 2
  // CHECK: [[fvec_3:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_lo]], 3
  // CHECK: [[fvec_hi:%.*]] = call %dx.types.ResRet.f32 @dx.op.rawBufferLoad.f32(i32 139, %dx.types.Handle [[buf]], i32 {{256|272}}
  // CHECK: [[fvec_4:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_hi]], 0
  // CHECK: [[fvec_5:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_hi]], 1
  // CHECK: [[fvec_6:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_hi]], 2
  // CHECK: [[fvec_7:%.*]] = extractvalue %dx.types.ResRet.f32 [[fvec_hi]], 3

  // CHECK: [[ping:%.*]] = insertelement <8 x float> undef,    float [[fvec_0]]
  // CHECK: [[pong:%.*]] = insertelement <8 x float> [[ping]], float [[fvec_1]]
  // CHECK: [[ping:%.*]] = insertelement <8 x float> [[pong]], float [[fvec_2]]
  // CHECK: [[pong:%.*]] = insertelement <8 x float> [[ping]], float [[fvec_3]]
  // CHECK: [[ping:%.*]] = insertelement <8 x float> [[pong]], float [[fvec_4]]
  // CHECK: [[pong:%.*]] = insertelement <8 x float> [[ping]], float [[fvec_5]]
  // CHECK: [[ping:%.*]] = insertelement <8 x float> [[pong]], float [[fvec_6]]
  // CHECK: [[fvec:%.*]] = insertelement <8 x float> [[ping]], float [[fvec_7]]
  vector<float, 8> fvec = buf.Load<vector<float, 8> >(240);

  vec1 = dostuff(vec1, vec2, vec3);

  // Test mixed type operations
  vec2 = dostuffMixed(vec3, dvec, fvec);

  f = dostuff(vec1[0], vec2[4], vec3[7]);

  // TEST Groupshared. Really fucks things up now!
  //gs_vec1 = dostuff(gs_vec1, gs_vec2, gs_vec3);

  // mix groupshared and non
  //vec1 = dostuff(vec1, gs_vec2, vec3);

  return (float4)altogetherNow(vec1, vec2, vec3);//*dvec.x;// - altogetherNow(gs_vec1, gs_vec2, gs_vec3);
}

template <typename T>
T dostuff(T thing1, T thing2, T thing3) {
  T res = 0;

  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 36, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec2]])  ; FMin(a,b)
  res += min(thing1, thing2);
  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec3]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // CHECK: [[tmp:%.*]] = call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec1]], <8 x [[TYPE]]> [[vec2]])  ; FMax(a,b)
  // CHECK: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 36, <8 x [[TYPE]]> [[tmp]], <8 x [[TYPE]]> [[vec3]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // Even in the double test, these will be downconverted because these builtins only take floats.
  // F64: [[vec2:%.*]] = fptrunc <8 x double> {{%.*}} to <8 x float>
  // F64: [[vec1:%.*]] = fptrunc <8 x double> {{%.*}} to <8 x float>

  // CHECK: [[tmp:%.*]] = fcmp fast olt <8 x float> [[vec2]], [[vec1]]
  // TODO: figure out how to nail this down. optimizaiton keeps turning my floats into doubles, all consts and assigned to a double. Probably because of that.
  // CHECK: select <8 x i1> [[tmp]], <8 x {{float|double}}> zeroinitializer, <8 x {{float|double}}> <{{float|double}} 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <8 x float> [[vec1]], <float 0x
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 21, <8 x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <8 x float> @dx.op.unary.v8f32(i32 23, <8 x float> [[vec1]])  ; Log(value)
  // CHECK: fmul fast <8 x float> [[tmp]], <float 0x
  res += log(thing1);

  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 20, <8 x float> [[vec1]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 17, <8 x float> [[vec1]])  ; Atan(value)
  res += atan(thing1);

  // TODO: add checks for fma
  // F32: [[dvec3:%.*]] = fpext <8 x float> [[vec3]] to <8 x double>
  // F32: [[dvec2:%.*]] = fpext <8 x float> [[vec2]] to <8 x double>
  // F32: [[dvec1:%.*]] = fpext <8 x float> [[vec1]] to <8 x double>
  // F32: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[dvec1]], <8 x double> [[dvec2]], <8 x double> [[dvec3]]) ; Fma(a,b,c)
  // F64: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[dvec1:%.*]], <8 x double> [[dvec2:%.*]], <8 x double> [[dvec3:%.*]]) ; Fma(a,b,c)
  res += (T)fma((vector<double,8>)thing1, (vector<double,8>)(thing2), (vector<double,8>)thing3);
  return res;
}


template <typename T>
T dostuffMixed(T thing1, vector<double,8> thing2, vector<float,8> thing3) {
  T res = 0;

  // CHECK: [[dfvec:%.*]] = fpext <8 x float> [[fvec]] to <8 x double>
  // CHECK: [[tmp:%.*]] = call <8 x double> @dx.op.binary.v8f64(i32 35, <8 x double> [[dvec3]], <8 x double> [[dvec]])  ; FMax(a,b)
  // CHECK: call <8 x double> @dx.op.binary.v8f64(i32 36, <8 x double> [[tmp]], <8 x double> [[dfvec]])  ; FMin(a,b)
  res += clamp(thing1, thing2, thing3);

  // CHECK: call <8 x double> @dx.op.binary.v8f64(i32 36, <8 x double> [[dvec3]], <8 x double> [[dvec]])  ; FMin(a,b)
  res += min(thing1, thing2);

  // TRY TO MERGE
  // F64: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec3]], <8 x [[TYPE]]> [[dfvec]])  ; FMax(a,b)
  // F32: call <8 x [[TYPE]]> @dx.op.binary.v8[[TY]](i32 35, <8 x [[TYPE]]> [[vec3]], <8 x [[TYPE]]> [[fvec]])  ; FMax(a,b)
  res += max(thing1, thing3);

  // Even in the double test, these will be downconverted because these builtins only take floats.
  // CHECK: [[fdvec:%.*]] = fptrunc <8 x double> [[dvec]] to <8 x float>
  // F64: [[vec3:%.*]] = fptrunc <8 x double> {{%.*}} to <8 x float>

  // CHECK: [[tmp:%.*]] = fcmp fast olt <8 x float> [[fdvec]], [[vec3]]
  // TODO: figure out how to nail this down. optimizaiton keeps turning my floats into doubles, all consts and assigned to a double. Probably because of that.
  // CHECK: select <8 x i1> [[tmp]], <8 x {{float|double}}> zeroinitializer, <8 x {{float|double}}> <{{float|double}} 1
  res += step(thing1, thing2);

  // CHECK: [[tmp:%.*]] = fmul fast <8 x float> [[vec3]], <float 0x
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 21, <8 x float> [[tmp]])  ; Exp(value)
  res += exp(thing1);

  // CHECK: [[tmp:%.*]] = call <8 x float> @dx.op.unary.v8f32(i32 23, <8 x float> [[vec3]])  ; Log(value)
  // CHECK: fmul fast <8 x float> [[tmp]], <float 0x
  res += log(thing1);

  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 20, <8 x float> [[vec3]])  ; Htan(value)
  res += tanh(thing1);
  // CHECK: call <8 x float> @dx.op.unary.v8f32(i32 17, <8 x float> [[vec3]])  ; Atan(value)
  res += atan(thing1);

  // TODO: add checks for fma
  // F32: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[dvec3]], <8 x double> [[dvec]], <8 x double> [[dfvec]]) ; Fma(a,b,c)
  // F64: call <8 x double> @dx.op.tertiary.v8f64(i32 47, <8 x double> [[dvec1:%.*]], <8 x double> [[dvec2:%.*]], <8 x double> [[dvec3:%.*]]) ; Fma(a,b,c)
  res += (T)fma((vector<double,8>)thing1, (vector<double,8>)(thing2), (vector<double,8>)thing3);
  return res;
}
