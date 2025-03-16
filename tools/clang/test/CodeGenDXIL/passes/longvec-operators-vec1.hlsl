// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=float1 %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=int1      %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=double1   -DDBL %s | FileCheck %s --check-prefixes=CHECK
// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=uint64_t1 %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=float16_t1 -enable-16bit-types %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUN: %dxc -fcgl -HV 2018 -T lib_6_9 -DTYPE=int16_t1  -enable-16bit-types %s | FileCheck %s --check-prefixes=CHECK,NODBL

// Mainly a source for the vec1 IR tests.
// Serves to verify some codegen as well just for giggles.

// Just a trick to capture the needed type spellings since the DXC version of FileCheck can't do that explicitly.
// Need to capture once for the full vector type, again for the element type.
// CHECK-DAG: %"class.RWStructuredBuffer<{{.*}}>" = type { [[TYPE:<[0-9]* x [a-z0-9_]*>]] }
// CHECK-DAG: %"class.RWStructuredBuffer<{{.*}}>" = type { <{{[0-9]*}} x [[ELTY:[a-z0-9_]*]]> }
RWStructuredBuffer<TYPE> buf;

export void assignments(inout TYPE things[10], TYPE scales[10]);
export TYPE arithmetic(inout TYPE things[11])[11];
export bool logic(bool truth[10], TYPE consequences[10])[10];
export TYPE index(TYPE things[10], int i, TYPE val)[10];

struct Interface {
  TYPE assigned[10];
  TYPE arithmeticked[11];
  bool logicked[10];
  TYPE indexed[10];
  TYPE scales[10];
};

#if 0
// Requires vector loading support. Enable when available.
RWStructuredBuffer<Interface> Input;
RWStructuredBuffer<Interface> Output;

TYPE g_val;

[shader("compute")]
[numthreads(8,1,1)]
void main(uint GI : SV_GroupIndex) {
  assignments(Output[GI].assigned, Input[GI].scales);
  Output[GI].arithmeticked = arithmetic(Input[GI].arithmeticked);
  Output[GI].logicked = logic(Input[GI].logicked, Input[GI].assigned);
  Output[GI].indexed = index(Input[GI].indexed, GI, g_val);
}
#endif

// A mixed-type overload to test overload resolution and mingle different vector element types in ops
// Test assignment operators.
// CHECK-LABEL: define void @"\01?assignments
export void assignments(inout TYPE things[10]) {

  // CHECK: [[res0:%.*]] =  call [[TYPE]] @"dx.hl.op.ro.[[TYPE]] (i32, %dx.types.Handle, i32)"(i32 231, %dx.types.Handle {{%.*}}, i32 1)
  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 0
  // CHECK: store [[TYPE]] [[res0]], [[TYPE]]* [[adr0]]
  things[0] = buf.Load(1);

  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 5
  // CHECK: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 1
  // CHECK: [[vec1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // CHECK: [[res1:%.*]] = [[ADD:f?add( fast)?]] [[TYPE]] [[vec1]], [[vec5]]
  // CHECK: store [[TYPE]] [[res1]], [[TYPE]]* [[adr1]]
  things[1] += things[5];

  // CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 6
  // CHECK: [[vec6:%.*]] = load [[TYPE]], [[TYPE]]* [[adr6]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[res2:%.*]] = [[SUB:f?sub( fast)?]] [[TYPE]] [[vec2]], [[vec6]]
  // CHECK: store [[TYPE]] [[res2]], [[TYPE]]* [[adr2]]
  things[2] -= things[6];

  // CHECK: [[adr7:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 7
  // CHECK: [[vec7:%.*]] = load [[TYPE]], [[TYPE]]* [[adr7]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[res3:%.*]] = [[MUL:f?mul( fast)?]] [[TYPE]] [[vec3]], [[vec7]]
  // CHECK: store [[TYPE]] [[res3]], [[TYPE]]* [[adr3]]
  things[3] *= things[7];

  // CHECK: [[adr8:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 8
  // CHECK: [[vec8:%.*]] = load [[TYPE]], [[TYPE]]* [[adr8]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[res4:%.*]] = [[DIV:[ufs]?div( fast)?]] [[TYPE]] [[vec4]], [[vec8]]
  // CHECK: store [[TYPE]] [[res4]], [[TYPE]]* [[adr4]]
  things[4] /= things[8];

#ifndef DBL
  // NODBL: [[adr9:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 9
  // NODBL: [[vec9:%.*]] = load [[TYPE]], [[TYPE]]* [[adr9]]
  // NODBL: [[adr5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 5
  // NODBL: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // NODBL: [[res5:%.*]] = [[REM:[ufs]?rem( fast)?]] [[TYPE]] [[vec5]], [[vec9]]
  // NODBL: store [[TYPE]] [[res5]], [[TYPE]]* [[adr5]]
  things[5] %= things[9];
#endif
}

// Test arithmetic operators.
// CHECK-LABEL: define void @"\01?arithmetic
export TYPE arithmetic(inout TYPE things[11])[11] {
  TYPE res[11];
  // CHECK: [[adr0:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 0
  // CHECK: [[res1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr0]]
  // CHECK: [[res0:%.*]] = [[SUB]] [[TYPE]]
  res[0] = -things[0];
  res[1] = +things[0];

  // CHECK: [[adr1:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 1
  // CHECK: [[vec1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[res2:%.*]] = [[ADD]] [[TYPE]] [[vec1]], [[vec2]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 2
  // CHECK: store [[TYPE]] [[res2]], [[TYPE]]* [[adr2]]
  res[2] = things[1] + things[2];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[res3:%.*]] = [[SUB]] [[TYPE]] [[vec2]], [[vec3]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 3
  // CHECK: store [[TYPE]] [[res3]], [[TYPE]]* [[adr3]]
  res[3] = things[2] - things[3];

  // CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[res4:%.*]] = [[MUL]] [[TYPE]] [[vec3]], [[vec4]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 4
  // CHECK: store [[TYPE]] [[res4]], [[TYPE]]* [[adr4]]
  res[4] = things[3] * things[4];

  // CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 5
  // CHECK: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // CHECK: [[res5:%.*]] = [[DIV]] [[TYPE]] [[vec4]], [[vec5]]
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 5
  // CHECK: store [[TYPE]] [[res5]], [[TYPE]]* [[adr5]]
  res[5] = things[4] / things[5];

#ifndef DBL
  // NODBL: [[adr5:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 5
  // NODBL: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // NODBL: [[adr6:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 6
  // NODBL: [[vec6:%.*]] = load [[TYPE]], [[TYPE]]* [[adr6]]
  // NODBL: [[res6:%.*]] = [[REM]] [[TYPE]] [[vec5]], [[vec6]]
  // NODBL: [[adr6:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 6
  // NODBL: store [[TYPE]] [[res6]], [[TYPE]]* [[adr6]]
  res[6] = things[5] % things[6];
#endif

  // CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 7
  // CHECK: [[vec7:%.*]] = load [[TYPE]], [[TYPE]]* [[adr7]]
  // CHECK: [[res7:%.*]] = [[ADD]] [[TYPE]] [[vec7]], <[[ELTY]] [[POS1:(1|1\.0*e\+0*|0xH3C00)]]>
  // CHECK: store [[TYPE]] [[res7]], [[TYPE]]* [[adr7]]
  // This is a post op, so the original value goes into res[].
  // CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 7
  // CHECK: store [[TYPE]] [[vec7]], [[TYPE]]* [[adr7]]
  res[7] = things[7]++;

  // CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 8
  // CHECK: [[vec8:%.*]] = load [[TYPE]], [[TYPE]]* [[adr8]]
  // CHECK: [[res8:%.*]] = [[ADD]] [[TYPE]] [[vec8]]
  // CHECK: store [[TYPE]] [[res8]], [[TYPE]]* [[adr8]]
  // This is a post op, so the original value goes into res[].
  // CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 8
  // CHECK: store [[TYPE]] [[vec8]], [[TYPE]]* [[adr8]]
  res[8] = things[8]--;

  // CHECK: [[adr9:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 9
  // CHECK: [[vec9:%.*]] = load [[TYPE]], [[TYPE]]* [[adr9]]
  // CHECK: [[res9:%.*]] = [[ADD]] [[TYPE]] [[vec9]]
  // CHECK: store [[TYPE]] [[res9]], [[TYPE]]* [[adr9]]
  // CHECK: [[adr9:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 9
  // CHECK: store [[TYPE]] [[res9]], [[TYPE]]* [[adr9]]
  res[9] = ++things[9];

  // CHECK: [[adr10:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %things, i32 0, i32 10
  // CHECK: [[vec10:%.*]] = load [[TYPE]], [[TYPE]]* [[adr10]]
  // CHECK: [[res10:%.*]] = [[ADD]] [[TYPE]] [[vec10]]
  // CHECK: store [[TYPE]] [[res10]], [[TYPE]]* [[adr10]]
  // CHECK: [[adr10:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %res, i32 0, i32 10
  // CHECK: store [[TYPE]] [[res10]], [[TYPE]]* [[adr10]]
  res[10] = --things[10];

  // Memcpy res into return value.
  // CHECK: [[retptr:%.*]] = bitcast [11 x [[TYPE]]]* %agg.result to i8*
  // CHECK: [[resptr:%.*]] = bitcast [11 x [[TYPE]]]* %res to i8*
  // CHECK: call void @llvm.memcpy.p0i8.p0i8.i64(i8* [[retptr]], i8* [[resptr]]
  // CHECK: ret void
  return res;
}

// Test logic operators.
// Only permissable in pre-HLSL2021
// CHECK-LABEL: define void @"\01?logic
export bool logic(bool truth[10], TYPE consequences[10])[10] {
  bool res[10];
  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 0
  // CHECK: [[vec0:%.*]] = load i32, i32* [[adr0]]
  // CHECK: [[bvec0:%.*]] = icmp ne i32 [[vec0]], 0
  // CHECK: [[bres0:%.*]] = xor i1 [[bvec0]], true
  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 0
  // CHECK: [[res0:%.*]] = zext i1 [[bres0]] to i32
  // CHECK: store i32 [[res0]], i32* [[adr0]]
  res[0] = !truth[0];

  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 1
  // CHECK: [[vec1:%.*]] = load i32, i32* [[adr1]]
  // CHECK: [[bvec1:%.*]] = icmp ne i32 [[vec1]], 0
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load i32, i32* [[adr2]]
  // CHECK: [[bvec2:%.*]] = icmp ne i32 [[vec2]], 0
  // CHECK: [[bres1:%.*]] = or i1 [[bvec1]], [[bvec2]]
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 1
  // CHECK: [[res1:%.*]] = zext i1 [[bres1]] to i32
  // CHECK: store i32 [[res1]], i32* [[adr1]]
  res[1] = truth[1] || truth[2];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load i32, i32* [[adr2]]
  // CHECK: [[bvec2:%.*]] = icmp ne i32 [[vec2]], 0
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load i32, i32* [[adr3]]
  // CHECK: [[bvec3:%.*]] = icmp ne i32 [[vec3]], 0
  // CHECK: [[bres2:%.*]] = and i1 [[bvec2]], [[bvec3]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 2
  // CHECK: [[res2:%.*]] = zext i1 [[bres2]] to i32
  // CHECK: store i32 [[res2]], i32* [[adr2]]
  res[2] = truth[2] && truth[3];

  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load i32, i32* [[adr3]]
  // CHECK: [[bvec3:%.*]] = icmp ne i32 [[vec3]], 0
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load i32, i32* [[adr4]]
  // CHECK: [[bvec4:%.*]] = icmp ne i32 [[vec4]], 0
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 5
  // CHECK: [[vec5:%.*]] = load i32, i32* [[adr5]]
  // CHECK: [[bvec5:%.*]] = icmp ne i32 [[vec5]], 0
  // CHECK: [[bres3:%.*]] = select i1 [[bvec3]], i1 [[bvec4]], i1 [[bvec5]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 3
  // CHECK: [[res3:%.*]] = zext i1 [[bres3]] to i32
  // CHECK: store i32 [[res3]], i32* [[adr3]]
  res[3] = truth[3] ? truth[4] : truth[5];

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 0
  // CHECK: [[vec0:%.*]] = load [[TYPE]], [[TYPE]]* [[adr0]]
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 1
  // CHECK: [[vec1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // CHECK: [[cmp4:%.*]] = [[CMP:[fi]?cmp( fast)?]] {{o?}}eq [[TYPE]] [[vec0]], [[vec1]]
  // CHECK: [[bres4:%.*]] = extractelement <1 x i1> [[cmp4]], i64 0
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 4
  // CHECK: [[res4:%.*]] = zext i1 [[bres4]] to i32
  // CHECK: store i32 [[res4]], i32* [[adr4]]
  res[4] = consequences[0] == consequences[1];

  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 1
  // CHECK: [[vec1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[cmp5:%.*]] = [[CMP]] {{u?}}ne [[TYPE]] [[vec1]], [[vec2]]
  // CHECK: [[bres5:%.*]] = extractelement <1 x i1> [[cmp5]], i64 0
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 5
  // CHECK: [[res5:%.*]] = zext i1 [[bres5]] to i32
  // CHECK: store i32 [[res5]], i32* [[adr5]]
  res[5] = consequences[1] != consequences[2];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 2
  // CHECK: [[vec2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[cmp6:%.*]] = [[CMP]] {{[osu]?}}lt [[TYPE]] [[vec2]], [[vec3]]
  // CHECK: [[bres6:%.*]] = extractelement <1 x i1> [[cmp6]], i64 0
  // CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 6
  // CHECK: [[res6:%.*]] = zext i1 [[bres6]] to i32
  // CHECK: store i32 [[res6]], i32* [[adr6]]
  res[6] = consequences[2] <  consequences[3];

  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 3
  // CHECK: [[vec3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[cmp7:%.*]] = [[CMP]] {{[osu]]?}}gt [[TYPE]] [[vec3]], [[vec4]]
  // CHECK: [[bres7:%.*]] = extractelement <1 x i1> [[cmp7]], i64 0
  // CHECK: [[adr7:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 7
  // CHECK: [[res7:%.*]] = zext i1 [[bres7]] to i32
  // CHECK: store i32 [[res7]], i32* [[adr7]]
  res[7] = consequences[3] >  consequences[4];

  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 4
  // CHECK: [[vec4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 5
  // CHECK: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // CHECK: [[cmp8:%.*]] = [[CMP]] {{[osu]]?}}le [[TYPE]] [[vec4]], [[vec5]]
  // CHECK: [[bres8:%.*]] = extractelement <1 x i1> [[cmp8]], i64 0
  // CHECK: [[adr8:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 8
  // CHECK: [[res8:%.*]] = zext i1 [[bres8]] to i32
  // CHECK: store i32 [[res8]], i32* [[adr8]]
  res[8] = consequences[4] <= consequences[5];

  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 5
  // CHECK: [[vec5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 6
  // CHECK: [[vec6:%.*]] = load [[TYPE]], [[TYPE]]* [[adr6]]
  // CHECK: [[cmp9:%.*]] = [[CMP]] {{[osu]?}}ge [[TYPE]] [[vec5]], [[vec6]]
  // CHECK: [[bres9:%.*]] = extractelement <1 x i1> [[cmp9]], i64 0
  // CHECK: [[adr9:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 9
  // CHECK: [[res9:%.*]] = zext i1 [[bres9]] to i32
  // CHECK: store i32 [[res9]], i32* [[adr9]]
  res[9] = consequences[5] >= consequences[6];

  // Memcpy res into return value.
  // CHECK: [[retptr:%.*]] = bitcast [10 x i32]* %agg.result to i8*
  // CHECK: [[resptr:%.*]] = bitcast [10 x i32]* %res to i8*
  // CHECK: call void @llvm.memcpy.p0i8.p0i8.i64(i8* [[retptr]], i8* [[resptr]]
  // CHECK: ret void
  return res;
}

static const int Ix = 2;

// Test indexing operators
// CHECK-LABEL: define void @"\01?index
export TYPE index(TYPE things[10], int i)[10] {
  // CHECK: [[res:%.*]] = alloca [10 x [[TYPE]]]
  // CHECK: store i32 %i, i32* [[iadd:%.[0-9]*]]
  TYPE res[10];

  // CHECK: [[res0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 0
  // CHECK: store [[TYPE]] zeroinitializer, [[TYPE]]* [[res0]]
  res[0] = 0;

  // CHECK: [[i:%.*]] = load i32, i32* [[iadd]]
  // CHECK: [[adri:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 [[i]]
  // CHECK: store [[TYPE]] <[[ELTY]] {{(1|1\.0*e\+0*|0xH3C00).*}}>, [[TYPE]]* [[adri]]
  res[i] = 1;

  // CHECK: [[res2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 2
  // CHECK: store [[TYPE]] <[[ELTY]] {{(2|2\.0*e\+0*|0xH4000).*}}>, [[TYPE]]* [[res2]]
  res[Ix] = 2;

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 0
  // CHECK: [[thg0:%.*]] = load [[TYPE]], [[TYPE]]* [[adr0]]
  // CHECK: [[res3:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 3
  // CHECK: store [[TYPE]] [[thg0]], [[TYPE]]* [[res3]]
  res[3] = things[0];

  // CHECK: [[i:%.*]] = load i32, i32* [[iadd]]
  // CHECK: [[adri:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 [[i]]
  // CHECK: [[thgi:%.*]] = load [[TYPE]], [[TYPE]]* [[adri]]
  // CHECK: [[res4:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 4
  // CHECK: store [[TYPE]] [[thgi]], [[TYPE]]* [[res4]]
  res[4] = things[i];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 2
  // CHECK: [[thg2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[res5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 5
  // CHECK: store [[TYPE]] [[thg2]], [[TYPE]]* [[res5]]
  res[5] = things[Ix];
  // CHECK: ret void
  return res;
}

// Test bit twiddling operators.
// INT-LABEL: define void @"\01?bittwiddlers
export void bittwiddlers(inout uint things[11]) {
  // CHECK: [[adr1:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 1
  // CHECK: [[ld1:%[0-9]*]] = load i32, i32* [[adr1]]
  // CHECK: [[val1:%[0-9]*]] = extractelement i32 [[ld1]], i32 0
  // CHECK: [[xor1:%[0-9]*]] = xor [[ELTY]] [[val1]], -1
  // CHECK: [[res1:%.*]] = insertelement i32 undef, [[ELTY]] [[xor1]], i32 0
  // CHECK: [[adr0:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 0
  // CHECK: store i32 [[res1]], i32* [[adr0]]
  things[0] = ~things[1];

  // CHECK: [[adr2:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 2
  // CHECK: [[ld2:%[0-9]*]] = load i32, i32* [[adr2]]
  // CHECK: [[val2:%[0-9]*]] = extractelement i32 [[ld2]], i32 0
  // CHECK: [[adr3:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  // CHECK: [[ld3:%[0-9]*]] = load i32, i32* [[adr3]]
  // CHECK: [[val3:%[0-9]*]] = extractelement i32 [[ld3]], i32 0
  // CHECK: [[or1:%[0-9]*]] = or [[ELTY]] [[val3]], [[val2]]
  // CHECK: [[res1:%.*]] = insertelement i32 undef, [[ELTY]] [[or1]], i32 0
  // CHECK: store i32 [[res1]], i32* [[adr1]]
  things[1] = things[2] | things[3];

  // CHECK: [[adr4:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  // CHECK: [[ld4:%[0-9]*]] = load i32, i32* [[adr4]]
  // CHECK: [[val4:%[0-9]*]] = extractelement i32 [[ld4]], i32 0
  // CHECK: [[and2:%[0-9]*]] = and [[ELTY]] [[val4]], [[val3]]
  // CHECK: [[res2:%.*]] = insertelement i32 undef, [[ELTY]] [[and2]], i32 0
  // CHECK: store i32 [[res2]], i32* [[adr2]]
  things[2] = things[3] & things[4];

  // CHECK: [[adr5:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  // CHECK: [[ld5:%[0-9]*]] = load i32, i32* [[adr5]]
  // CHECK: [[val5:%[0-9]*]] = extractelement i32 [[ld5]], i32 0
  // CHECK: [[xor3:%[0-9]*]] = xor [[ELTY]] [[val5]], [[val4]]
  // CHECK: [[res3:%.*]] = insertelement i32 undef, [[ELTY]] [[xor3]], i32 0
  // CHECK: store i32 [[res3]], i32* [[adr3]]
  things[3] = things[4] ^ things[5];

  // CHECK: [[adr6:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  // CHECK: [[ld6:%[0-9]*]] = load i32, i32* [[adr6]]
  // CHECK: [[val6:%[0-9]*]] = extractelement i32 [[ld6]], i32 0
  // CHECK: [[shv6:%[0-9]*]] = and [[ELTY]] [[val6]]
  // CHECK: [[shl4:%[0-9]*]] = shl [[ELTY]] [[val5]], [[shv6]]
  // CHECK: [[res4:%.*]] = insertelement i32 undef, [[ELTY]] [[shl4]], i32 0
  // CHECK: store i32 [[res4]], i32* [[adr4]]
  things[4] = things[5] << things[6];

  // CHECK: [[adr7:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 7
  // CHECK: [[ld7:%[0-9]*]] = load i32, i32* [[adr7]]
  // CHECK: [[val7:%[0-9]*]] = extractelement i32 [[ld7]], i32 0
  // CHECK: [[shv7:%[0-9]*]] = and [[ELTY]] [[val7]]
  // CHECK: [[shr5:%[0-9]*]] = ashr [[ELTY]] [[val6]], [[shv7]]
  // CHECK: [[res5:%.*]] = insertelement i32 undef, [[ELTY]] [[shr5]], i32 0
  // CHECK: store i32 [[res5]], i32* [[adr5]]
  things[5] = things[6] >> things[7];

  // CHECK: [[adr8:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 8
  // CHECK: [[ld8:%[0-9]*]] = load i32, i32* [[adr8]]
  // CHECK: [[val8:%[0-9]*]] = extractelement i32 [[ld8]], i32 0
  // CHECK: [[or6:%[0-9]*]] = or [[ELTY]] [[val8]], [[val6]]
  // CHECK: [[res6:%.*]] = insertelement i32 undef, [[ELTY]] [[or6]], i32 0
  // CHECK: store i32 [[res6]], i32* [[adr6]]
  things[6] |= things[8];

  // CHECK: [[adr9:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 9
  // CHECK: [[ld9:%[0-9]*]] = load i32, i32* [[adr9]]
  // CHECK: [[val9:%[0-9]*]] = extractelement i32 [[ld9]], i32 0
  // CHECK: [[and7:%[0-9]*]] = and [[ELTY]] [[val9]], [[val7]]
  // CHECK: [[res7:%.*]] = insertelement i32 undef, [[ELTY]] [[and7]], i32 0
  // CHECK: store i32 [[res7]], i32* [[adr7]]
  things[7] &= things[9];

  // CHECK: [[adr10:%[0-9]*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 10
  // CHECK: [[ld10:%[0-9]*]] = load i32, i32* [[adr10]]
  // CHECK: [[val10:%[0-9]*]] = extractelement i32 [[ld10]], i32 0
  // CHECK: [[xor8:%[0-9]*]] = xor [[ELTY]] [[val10]], [[val8]]
  // CHECK: [[res8:%.*]] = insertelement i32 undef, [[ELTY]] [[xor8]], i32 0
  // CHECK: store i32 [[res8]], i32* [[adr8]]
  things[8] ^= things[10];

  // CHECK: ret void
}
