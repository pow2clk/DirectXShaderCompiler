// RUN: %dxc -T ps_6_9 %s | Filecheck %s

// Long vector tests for vec ops that don't scalarize to simply a repetition
//  of the same dx.op calls. These require more specific testing.

// Consider tracking registers more closely.

// AND and OR HAVE A LOT OF BUGS! keep crashing either in the InsertElementInst::isValidOperands check for insertelement
// or the binaryoperator when it checks for ints and finds float. No conversion.
// RUIN: %dxc -DFUNC=and       -DARITY=2 -T ps_6_9 %s | Filecheck %s --check-prefixes=CHECK,BINARY
// RUIN: %dxc -DFUNC=or        -DARITY=2 -T ps_6_9 %s | Filecheck %s --check-prefixes=CHECK,BINARY

StructuredBuffer< vector<float, 8> > buf;
ByteAddressBuffer rbuf;

float4 main(uint i : SV_PrimitiveID, bool b : B) : SV_Target {
  vector<float, 8> vec1 = rbuf.Load< vector<float, 8> >(i++*32);
  vector<float, 8> vec2 = rbuf.Load< vector<float, 8> >(i++*32);
  vector<float, 8> vec3 = rbuf.Load< vector<float, 8> >(i++*32);

  // CHECK: [[resret:%.*]] = call %dx.types.ResRet.{{.*}} @dx.op.rawBufferLoad

  // CHECK: fmul fast <8 x float> %{{.*}} <float
  vec1 = degrees(vec1);
  // CHECK: fmul fast <8 x float> %{{.*}} <float
  vec2 = radians(vec2);

  // CHECK: fcmp fast olt <8 x float>
  // CHECK: zext <8 x i1> %{{.*}} <8 x i32>
  // CHECK: zext <8 x i1> %{{.*}} <8 x i32>
  vec1 = sign(vec1);

  // clamp uses min/max, which have vector overloads.
  // CHECK: call <8 x float> @dx.op.binary.v8f32
  // CHECK: call <8 x float> @dx.op.binary.v8f32
  // CHECK-LABEL: FMin(a,b)
  vec1 = clamp(vec1, vec2, vec3);

  // CHECK: and <8 x i32>
  // CHECK: or <8 x i32>
  vec1 = frexp(vec1, vec2);

  // CHECK: fsub fast <8 x float>
  // CHECK: fmul fast <8 x float>
  vec1 = lerp(vec1, vec2, vec3);

  // CHECK-LABEL: fdiv fast <8 x float> <float 1.000
  vec1 = rcp(vec1);

  // CHECK-LABEL: fmul fast <8 x float> %{{.*}} <float 2.0000
  // CHECK: fsub fast <8 x float>
  // CHECK: fmul fast <8 x float>
  vec1 = smoothstep(vec1, vec2, vec3);

  // CHECK: fdiv fast <8 x float>
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: call float @dx.op.unary.f32(i32 17, float %{{.*}}) ; Atan(value)
  // CHECK: fadd fast <8 x float> %{{.*}}, <float 0x
  // CHECK: fadd fast <8 x float> %{{.*}}, <float 0x
  // CHECK: fcmp fast olt <8 x float>
  // CHECK: fcmp fast oeq <8 x float>
  // CHECK: fcmp fast oge <8 x float>
  // CHECK: fcmp fast olt <8 x float>
  // CHECK: and <8 x i1>
  // CHECK: select <8 x i1> %{{.*}}, <8 x float> %{{.*}}, <8 x float>
  // CHECK: and <8 x i1>
  // CHECK: select <8 x i1> %{{.*}}, <8 x float> %{{.*}}, <8 x float>
  // CHECK: and <8 x i1>
  // CHECK: select <8 x i1> %{{.*}}, <8 x float> <float 0x
  // CHECK: and <8 x i1>
  // CHECK: select <8 x i1> %{{.*}}, <8 x float> <float 0x
  vec1 = atan2(vec1, vec2);


  // CHECK: fdiv fast <8 x float>
  // CHECK: fsub fast <8 x float> <float
  // CHECK: fcmp fast oge <8 x float>
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)
  // CHECK: call float @dx.op.unary.f32(i32 6, float %{{.*}}) ; FAbs(value)

  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)
  // CHECK: call float @dx.op.unary.f32(i32 22, float %{{.*}}) ; Frc(value)

  // CHECK: fsub fast <8 x float> <float
  // CHECK: select <8 x i1> %{{.*}}, <8 x float> %{{.*}}, <8 x float>
  // CHECK: fmul fast <8 x float>
  vec1 = fmod(vec1, vec2);

  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: fmul fast <8 x float>
  vec1 = ldexp(vec1, vec2);

  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) ; Log(value)
  // CHECK: fmul fast <8 x float>
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  // CHECK: call float @dx.op.unary.f32(i32 21, float %{{.*}}) ; Exp(value)
  vec1 = pow(vec1, vec2);


  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: call float @dx.op.unary.f32(i32 29, float %{{.*}}) ; Round_z(value)
  // CHECK: fsub fast <8 x float>
  vec1 = modf(vec1, vec2);

  // CHECK: fmul fast float
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  // CHECK: call float @dx.op.tertiary.f32(i32 46, float %{{.*}}, float %{{.*}}, float %{{.*}}) ; FMad(a,b,c)
  vec1 = dot(vec1, vec2);

  vector<bool, 8> bvec = b;
  // CHECK: or i1
  // CHECK: or i1
  // CHECK: or i1
  // CHECK: or i1
  // CHECK: or i1
  // CHECK: or i1
  // CHECK: or i1
  bvec &= any(vec1);

  // CHECK: and i1
  // CHECK: and i1
  // CHECK: and i1
  // CHECK: and i1
  // CHECK: and i1
  // CHECK: and i1
  // CHECK: and i1
  bvec &= all(vec2);

  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  // CHECK: select i1
  vector <float, 8 > retvec = select(bvec, vec1, vec2);

  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  // call {{.*}} @dx.op.wave
  return WaveMatch(retvec);
}
