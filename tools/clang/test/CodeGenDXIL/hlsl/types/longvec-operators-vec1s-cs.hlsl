// RUN: %dxc -HV 2018 -T cs_6_9 -DTYPE=float          %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUiN: %dxc -HV 2018 -T cs_6_9 -DTYPE=int      -DINT %s | FileCheck %s --check-prefixes=CHECK,NODBL,INT,SIG
// RUiN: %dxc -HV 2018 -T cs_6_9 -DTYPE=double   -DDBL %s | FileCheck %s --check-prefixes=CHECK
// RUiN: %dxc -HV 2018 -T cs_6_9 -DTYPE=uint64_t -DINT %s | FileCheck %s --check-prefixes=CHECK,NODBL,INT,UNSIG
// RUiN: %dxc -HV 2018 -T cs_6_9 -DTYPE=float16_t      -enable-16bit-types %s | FileCheck %s --check-prefixes=CHECK,NODBL
// RUiN: %dxc -HV 2018 -T cs_6_9 -DTYPE=int16_t  -DINT -enable-16bit-types %s | FileCheck %s --check-prefixes=CHECK,NODBL,INT,SIG

// Test relevant operators on vec1s in a 6.9 compute shader to ensure they continue to be treated as scalars.

// Just a trick to capture the needed type spellings since the DXC version of FileCheck can't do that explicitly.
// CHECK-DAG: %dx.types.ResRet.[[TY:[a-z][0-9]*]] = type { [[TYPE:[a-z0-9_]*]]
// CHECK-DAG: %dx.types.ResRet.[[ITY:i32]] = type { i32

#define VTYPE vector<TYPE, 1>

void assignments(inout VTYPE things[11], TYPE scales[10]);
VTYPE arithmetic(inout VTYPE things[11])[11];
VTYPE scarithmetic(VTYPE things[11], TYPE scales[10])[11];
bool1 logic(bool1 truth[10], VTYPE consequences[11])[10];
VTYPE index(VTYPE things[11], int i)[11];
void bittwiddlers(inout VTYPE things[13]);

struct Viface {
  VTYPE values[11];
};

struct Siface {
  TYPE values[10];
};

struct Liface {
  bool1 values[10];
};

struct Binface {
  VTYPE values[13];
};

RWStructuredBuffer<Viface> Input  : register(u11);
RWStructuredBuffer<Viface> Output : register(u12);
RWStructuredBuffer<Siface> Scales : register(u13);
RWStructuredBuffer<Liface> Truths : register(u14);
RWStructuredBuffer<Binface> Bits  : register(u15);
RWStructuredBuffer<vector<uint,13> > Offsets : register(u16);

[shader("compute")]
[numthreads(8,1,1)]
// CHECK-LABEL: define void @main
void main(uint3 GID : SV_GroupThreadID) {

  // CHECK-DAG: [[Input:%.*]]  = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 11, i32 11, i32 0, i8 1 }, i32 11
  // CHECK-DAG: [[Output:%.*]]  = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 12, i32 12, i32 0, i8 1 }, i32 12
  // CHECK-DAG: [[Scales:%.*]]  = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 13, i32 13, i32 0, i8 1 }, i32 13
  // CHECK-DAG: [[Truths:%.*]]  = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 14, i32 14, i32 0, i8 1 }, i32 14
  // INT-DAG: [[Bits:%.*]]  = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 15, i32 15, i32 0, i8 1 }, i32 15

  // CHECK: [[InIx1:%.*]] = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 0)
  // CHECK: [[InIx2:%.*]] = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 1)
  // CHECK: [[OutIx:%.*]] = call i32 @dx.op.threadIdInGroup.i32(i32 95, i32 2)

  uint InIx1 = GID[0];
  uint InIx2 = GID[1];
  uint OutIx = GID[2];

  // Assign vector offsets to capture the expected values.
  // CHECK: call void @dx.op.rawBufferVectorStore.v13i32(i32 304, %dx.types.Handle {{%.*}}, i32 0, i32 0, <13 x i32> <i32 [[OFF0:[0-9]*]], i32 [[OFF1:[0-9]*]], i32 [[OFF2:[0-9]*]], i32 [[OFF3:[0-9]*]], i32 [[OFF4:[0-9]*]], i32 [[OFF5:[0-9]*]], i32 [[OFF6:[0-9]*]], i32 [[OFF7:[0-9]*]], i32 [[OFF8:[0-9]*]], i32 [[OFF9:[0-9]*]], i32 [[OFF10:[0-9]*]], i32 [[OFF11:[0-9]*]], i32 [[OFF12:[0-9]*]]>
  Offsets[0] = vector<uint,13>(sizeof(TYPE)*0,
                               sizeof(TYPE)*1,
                               sizeof(TYPE)*2,
                               sizeof(TYPE)*3,
                               sizeof(TYPE)*4,
                               sizeof(TYPE)*5,
                               sizeof(TYPE)*6,
                               sizeof(TYPE)*7,
                               sizeof(TYPE)*8,
                               sizeof(TYPE)*9,
                               sizeof(TYPE)*10,
                               sizeof(TYPE)*11,
                               sizeof(TYPE)*12);

  // Assign boolean offsets to capture the expected values.
  // CHECK: call void @dx.op.rawBufferVectorStore.v13i32(i32 304, %dx.types.Handle {{%.*}}, i32 1, i32 0, <13 x i32> <i32 [[BOFF0:[0-9]*]], i32 [[BOFF1:[0-9]*]], i32 [[BOFF2:[0-9]*]], i32 [[BOFF3:[0-9]*]], i32 [[BOFF4:[0-9]*]], i32 [[BOFF5:[0-9]*]], i32 [[BOFF6:[0-9]*]], i32 [[BOFF7:[0-9]*]], i32 [[BOFF8:[0-9]*]], i32 [[BOFF9:[0-9]*]], i32 [[BOFF10:[0-9]*]], i32 [[ALN:[0-9]*]], i32 [[IALN:[0-9]*]]>
  Offsets[1] = vector<uint,13>(sizeof(int)*0,
                               sizeof(int)*1,
                               sizeof(int)*2,
                               sizeof(int)*3,
                               sizeof(int)*4,
                               sizeof(int)*5,
                               sizeof(int)*6,
                               sizeof(int)*7,
                               sizeof(int)*8,
                               sizeof(int)*9,
                               sizeof(int)*10,
                               sizeof(TYPE),// Effectively alignof.
                               sizeof(int));// Effectively integer alignof.

  assignments(Input[InIx1+1].values, Scales[InIx2+1].values);
  Output[OutIx+2].values = arithmetic(Input[InIx1+2].values);
  Output[OutIx+3].values = scarithmetic(Input[InIx1+3].values, Scales[InIx2+3].values);
  Truths[OutIx+4].values = logic(Truths[InIx2+4].values, Input[InIx1+4].values);
  Output[OutIx+5].values = index(Input[InIx1+5].values, InIx2+5);
#ifdef INT
  bittwiddlers(Bits[InIx1+6].values);
#endif
}
// A mixed-type overload to test overload resolution and mingle different vector element types in ops
// Test assignment operators.
void assignments(inout VTYPE things[11], TYPE scales[10]) {

  // CHECK: [[VcIx:%.*]] = add i32 [[InIx1]], 1

  // CHECK: [[InHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Input]]
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF1]], i8 1, i32 [[ALN]])
  // CHECK: [[val1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF2]], i8 1, i32 [[ALN]])
  // CHECK: [[val2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF3]], i8 1, i32 [[ALN]])
  // CHECK: [[val3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF4]], i8 1, i32 [[ALN]])
  // CHECK: [[val4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF5]], i8 1, i32 [[ALN]])
  // CHECK: [[val5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF6]], i8 1, i32 [[ALN]])
  // CHECK: [[val6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF7]], i8 1, i32 [[ALN]])
  // CHECK: [[val7:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF8]], i8 1, i32 [[ALN]])
  // CHECK: [[val8:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VcIx]], i32 [[OFF9]], i8 1, i32 [[ALN]])
  // CHECK: [[val9:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0


  // CHECK: [[ScIx:%.*]] = add i32 [[InIx2]], 1
  // CHECK: [[ScHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Scales]]
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ScHdl]], i32 [[ScIx]], i32 [[OFF0]], i8 1, i32 [[ALN]])
  // CHECK: [[scl0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ScHdl]], i32 [[ScIx]], i32 [[OFF1]], i8 1, i32 [[ALN]])
  // CHECK: [[scl1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ScHdl]], i32 [[ScIx]], i32 [[OFF2]], i8 1, i32 [[ALN]])
  // CHECK: [[scl2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ScHdl]], i32 [[ScIx]], i32 [[OFF3]], i8 1, i32 [[ALN]])
  // CHECK: [[scl3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ScHdl]], i32 [[ScIx]], i32 [[OFF4]], i8 1, i32 [[ALN]])
  // CHECK: [[scl4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0

  // Nothing to check. Just a copy over.
  things[0] = scales[0];

  // CHECK: [[add1:%.*]] = [[ADD:f?add( fast)?]] [[TYPE]] [[val5]], [[val1]]
  things[1] += things[5];

  // CHECK: [[sub2:%.*]] = [[SUB:f?sub( fast)?]] [[TYPE]] [[val2]], [[val6]]
  things[2] -= things[6];

  // CHECK: [[mul3:%.*]] = [[MUL:f?mul( fast)?]] [[TYPE]] [[val7]], [[val3]]
  things[3] *= things[7];

  // CHECK: [[div4:%.*]] = [[DIV:[ufs]?div( fast)?]] [[TYPE]] [[val4]], [[val8]]
  things[4] /= things[8];

#ifndef DBL
  // NODBL: [[rem5:%.*]] = [[REM:[ufs]?rem( fast)?]] [[TYPE]] [[val5]], [[val9]]
  things[5] %= things[9];
#endif

  // CHECK: [[res6:%[0-9]*]] = [[ADD]] [[TYPE]] [[scl1]], [[val6]]
  things[6] += scales[1];

  // CHECK: [[res7:%[0-9]*]] = [[SUB]] [[TYPE]] [[val7]], [[scl2]]
  things[7] -= scales[2];

  // CHECK: [[res8:%[0-9]*]] = [[MUL]] [[TYPE]] [[scl3]], [[val8]]
  things[8] *= scales[3];

  // CHECK: [[res9:%[0-9]*]] = [[DIV]] [[TYPE]] [[val9]], [[scl4]]
  things[9] /= scales[4];

}

// Test arithmetic operators.
VTYPE arithmetic(inout VTYPE things[11])[11] {
  TYPE res[11];
  // CHECK: [[ResIx:%.*]] = add i32 [[OutIx]], 2
  // CHECK: [[ResHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Output]]
  // CHECK: [[VecIx:%.*]] = add i32 [[InIx1]], 2
  // CHECK: [[InHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Input]]
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF0]], i8 1, i32 [[ALN]])
  // CHECK: [[vec0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF1]], i8 1, i32 [[ALN]])
  // CHECK: [[vec1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF2]], i8 1, i32 [[ALN]])
  // CHECK: [[vec2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF3]], i8 1, i32 [[ALN]])
  // CHECK: [[vec3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF4]], i8 1, i32 [[ALN]])
  // CHECK: [[vec4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF5]], i8 1, i32 [[ALN]])
  // CHECK: [[vec5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF6]], i8 1, i32 [[ALN]])
  // CHECK: [[vec6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF7]], i8 1, i32 [[ALN]])
  // CHECK: [[vec7:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF8]], i8 1, i32 [[ALN]])
  // CHECK: [[vec8:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF9]], i8 1, i32 [[ALN]])
  // CHECK: [[vec9:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF10]], i8 1, i32 [[ALN]])
  // CHECK: [[vec10:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0


  // CHECK: [[sub1:%.*]] = [[SUB]] [[TYPE]] {{-?(0|0\.?0*e?\+?0*|0xH8000)}}, [[val0]]
  res[0] = +things[0];
  res[1] = -things[0];

  // CHECK: [[add2:%.*]] = [[ADD]] [[TYPE]] [[val2]], [[val1]]
  res[2] = things[1] + things[2];

  // CHECK: [[sub3:%.*]] = [[SUB]] [[TYPE]] [[val2]], [[val3]]
  res[3] = things[2] - things[3];

  // CHECK: [[mul4:%.*]] = [[MUL]] [[TYPE]] [[val4]], [[val3]]
  res[4] = things[3] * things[4];

  // CHECK: [[div5:%.*]] = [[DIV]] [[TYPE]] [[val4]], [[val5]]
  res[5] = things[4] / things[5];

#ifndef DBL
  // NODBL: [[rem6:%.*]] = [[REM]] [[TYPE]] [[val5]], [[val6]]
  res[6] = things[5] % things[6];
#endif

  // CHECK: store [[TYPE]] [[res7]], [[TYPE]]* [[adr7]]
  res[7] = things[7]++;

  // CHECK: store [[TYPE]] [[res8]], [[TYPE]]* [[adr8]]
  res[8] = things[8]--;

  // CHECK: [[add9:%.*]] = [[ADD]] [[TYPE]] [[val9]], [[POS1]]
  res[9] = ++things[9];

  // CHECK: [[add10:%.*]] = [[ADD]] [[TYPE]] [[val10]], [[NEG1]]
  res[10] = --things[10];

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 0
  // CHECK: store [[TYPE]] [[res0]], [[TYPE]]* [[adr0]]
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 1
  // CHECK: [[res1:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[sub1]], i64 0
  // CHECK: store [[TYPE]] [[res1]], [[TYPE]]* [[adr1]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 2
  // CHECK: [[res2:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[add2]], i64 0
  // CHECK: store [[TYPE]] [[res2]], [[TYPE]]* [[adr2]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 3
  // CHECK: [[res3:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[sub3]], i64 0
  // CHECK: store [[TYPE]] [[res3]], [[TYPE]]* [[adr3]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 4
  // CHECK: [[res4:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[mul4]], i64 0
  // CHECK: store [[TYPE]] [[res4]], [[TYPE]]* [[adr4]]
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 5
  // CHECK: [[res5:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[div5]], i64 0
  // CHECK: store [[TYPE]] [[res5]], [[TYPE]]* [[adr5]]
  // NODBL: [[adr6:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 6
  // NODBL: [[res6:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[rem6]], i64 0
  // NODBL: store [[TYPE]] [[res6]], [[TYPE]]* [[adr6]]
  // CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 7
  // This is a post op, so the original value goes into res[].
  // CHECK: store [[TYPE]] [[ld7]], [[TYPE]]* [[adr7]]
  // CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 8
  // This is a post op, so the original value goes into res[].
  // CHECK: store [[TYPE]] [[ld8]], [[TYPE]]* [[adr8]]
  // CHECK: [[adr9:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 9
  // CHECK: [[res9:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[add9]], i64 0
  // CHECK: store [[TYPE]] [[res9]], [[TYPE]]* [[adr9]]
  // CHECK: [[adr10:%.*]] = getelementptr inbounds [11 x [[TYPE]]], [11 x [[TYPE]]]* %agg.result, i32 0, i32 10
  // CHECK: [[res10:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[add10]], i64 0
  // CHECK: store [[TYPE]] [[res10]], [[TYPE]]* [[adr10]]
  // CHECK: ret void
  return res;
}

// Test arithmetic operators with scalars.
VTYPE scarithmetic(VTYPE things[11], TYPE scales[10])[11] {
  VTYPE res[11];

  // CHECK: [[ResIx:%.*]] = add i32 [[OutIx]], 3
  // CHECK: [[ResHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Output]]
  // CHECK: [[VecIx:%.*]] = add i32 [[InIx1]], 3
  // CHECK: [[InHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Input]]
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF0]], i8 1, i32 [[ALN]])
  // CHECK: [[vec0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF1]], i8 1, i32 [[ALN]])
  // CHECK: [[vec1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF2]], i8 1, i32 [[ALN]])
  // CHECK: [[vec2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF3]], i8 1, i32 [[ALN]])
  // CHECK: [[vec3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF4]], i8 1, i32 [[ALN]])
  // CHECK: [[vec4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF5]], i8 1, i32 [[ALN]])
  // CHECK: [[vec5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[InHdl]], i32 [[VecIx]], i32 [[OFF6]], i8 1, i32 [[ALN]])
  // CHECK: [[vec6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0

  // CHECK: [[SclIx:%.*]] = add i32 [[InIx2]], 3
  // CHECK: [[SclHdl:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[Scales]]
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF0]], i8 1, i32 [[ALN]])
  // CHECK: [[scl0:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF1]], i8 1, i32 [[ALN]])
  // CHECK: [[scl1:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF2]], i8 1, i32 [[ALN]])
  // CHECK: [[scl2:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF3]], i8 1, i32 [[ALN]])
  // CHECK: [[scl3:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF4]], i8 1, i32 [[ALN]])
  // CHECK: [[scl4:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF5]], i8 1, i32 [[ALN]])
  // CHECK: [[scl5:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0
  // CHECK: [[ld:%.*]] = call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[SclHdl]], i32 [[SclIx]], i32 [[OFF6]], i8 1, i32 [[ALN]])
  // CHECK: [[scl6:%.*]] = extractvalue %dx.types.ResRet.[[TY]] [[ld]], 0

  // CHECK: [[res0:%[0-9]*]] = [[ADD]] [[TYPE]] [[scl0]], [[vec0]]
  res[0] = things[0] + scales[0];

  // CHECK: [[res1:%[0-9]*]] = [[SUB]] [[TYPE]] [[vec1]], [[scl1]]
  res[1] = things[1] - scales[1];

  // CHECK: [[res2:%[0-9]*]] = [[MUL]] [[TYPE]] [[scl2]], [[vec2]]
  res[2] = things[2] * scales[2];

  // CHECK: [[res3:%[0-9]*]] = [[DIV]] [[TYPE]] [[vec3]], [[scl3]]
  res[3] = things[3] / scales[3];

  // CHECK: [[res4:%[0-9]*]] = [[ADD]] [[TYPE]] [[scl4]], [[vec4]]
  res[4] = scales[4] + things[4];

  // CHECK: [[res5:%[0-9]*]] = [[SUB]] [[TYPE]] [[scl5]], [[vec5]]
  res[5] = scales[5] - things[5];

  // CHECK: [[res6:%[0-9]*]] = [[MUL]] [[TYPE]] [[scl6]], [[vec6]]
  res[6] = scales[6] * things[6];
  res[7] = res[8] = res[9] = res[10] = 0;

  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF0]], [[TYPE]] [[res0]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF1]], [[TYPE]] [[res1]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF2]], [[TYPE]] [[res2]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF3]], [[TYPE]] [[res3]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF4]], [[TYPE]] [[res4]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF5]], [[TYPE]] [[res5]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])
  // CHECK: call void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ResHdl]], i32 [[ResIx]], i32 [[OFF6]], [[TYPE]] [[res6]], [[TYPE]] undef, [[TYPE]] undef, [[TYPE]] undef, i8 1, i32 [[ALN]])

  return res;
}


// Test logic operators.
// Only permissable in pre-HLSL2021
bool1 logic(bool1 truth[10], VTYPE consequences[11])[10] {
  bool1 res[10];
  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 0
  // CHECK: [[val0:%.*]] = load i32, i32* [[adr0]]
  // CHECK: [[res0:%.*]] = xor i32 [[val0]], 1
  res[0] = !truth[0];

  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 1
  // CHECK: [[val1:%.*]] = load i32, i32* [[adr1]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  // CHECK: [[val2:%.*]] = load i32, i32* [[adr2]]
  // CHECK: [[res1:%.*]] = or i32 [[val2]], [[val1]]
  res[1] = truth[1] || truth[2];

  // CHECK: [[bval2:%.*]] = icmp ne i32 [[val2]], 0
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  // CHECK: [[val3:%.*]] = load i32, i32* [[adr3]]
  // CHECK: [[bval3:%.*]] = icmp ne i32 [[val3]], 0
  // CHECK: [[bres2:%.*]] = and i1 [[bval2]], [[bval3]]
  // CHECK: [[res2:%.*]] = zext i1 [[bres2]] to i32
  res[2] = truth[2] && truth[3];

  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 4
  // CHECK: [[val4:%.*]] = load i32, i32* [[adr4]]
  // CHECK: [[bval4:%.*]] = icmp ne i32 [[val4]], 0
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 5
  // CHECK: [[val5:%.*]] = load i32, i32* [[adr5]]
  // CHECK: [[bval5:%.*]] = icmp ne i32 [[val5]], 0
  // CHECK: [[bres3:%.*]] = select i1 [[bval3]], i1 [[bval4]], i1 [[bval5]]
  // CHECK: [[res3:%.*]] = zext i1 [[bres3]] to i32
  res[3] = truth[3] ? truth[4] : truth[5];

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 0
  // CHECK: [[ld0:%.*]] = load [[TYPE]], [[TYPE]]* [[adr0]]
  // CHECK: [[val0:%.*]] = extractelement [[TYPE]] [[ld0]], i32 0
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 1
  // CHECK: [[ld1:%.*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // CHECK: [[val1:%.*]] = extractelement [[TYPE]] [[ld1]], i32 0
  // CHECK: [[cmp4:%.*]] = [[CMP:[fi]?cmp( fast)?]] {{o?}}eq [[TYPE]] [[val0]], [[val1]]
  // CHECK: [[res4:%.*]] = zext i1 [[cmp4]] to i32
  res[4] = consequences[0] == consequences[1];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 2
  // CHECK: [[ld2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[val2:%.*]] = extractelement [[TYPE]] [[ld2]], i32 0
  // CHECK: [[cmp5:%.*]] = [[CMP]] {{u?}}ne [[TYPE]] [[val1]], [[val2]]
  // CHECK: [[res5:%.*]] = zext i1 [[cmp5]] to i32
  res[5] = consequences[1] != consequences[2];

  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 3
  // CHECK: [[ld3:%.*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // CHECK: [[val3:%.*]] = extractelement [[TYPE]] [[ld3]], i32 0
  // CHECK: [[cmp6:%.*]] = [[CMP]] {{[osu]?}}lt [[TYPE]] [[val2]], [[val3]]
  // CHECK: [[res6:%.*]] = zext i1 [[cmp6]] to i32
  res[6] = consequences[2] <  consequences[3];

  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 4
  // CHECK: [[ld4:%.*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // CHECK: [[val4:%.*]] = extractelement [[TYPE]] [[ld4]], i32 0
  // CHECK: [[cmp7:%.*]] = [[CMP]] {{[osu]]?}}gt [[TYPE]] [[val3]], [[val4]]
  // CHECK: [[res7:%.*]] = zext i1 [[cmp7]] to i32
  res[7] = consequences[3] >  consequences[4];

  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 5
  // CHECK: [[ld5:%.*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // CHECK: [[val5:%.*]] = extractelement [[TYPE]] [[ld5]], i32 0
  // CHECK: [[cmp8:%.*]] = [[CMP]] {{[osu]]?}}le [[TYPE]] [[val4]], [[val5]]
  // CHECK: [[res8:%.*]] = zext i1 [[cmp8]] to i32
  res[8] = consequences[4] <= consequences[5];

  // CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %consequences, i32 0, i32 6
  // CHECK: [[ld6:%.*]] = load [[TYPE]], [[TYPE]]* [[adr6]]
  // CHECK: [[val6:%.*]] = extractelement [[TYPE]] [[ld6]], i32 0
  // CHECK: [[cmp9:%.*]] = [[CMP]] {{[osu]?}}ge [[TYPE]] [[val5]], [[val6]]
  // CHECK: [[res9:%.*]] = zext i1 [[cmp9]] to i32
  res[9] = consequences[5] >= consequences[6];

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 0
  // CHECK: store i32 [[res0]], i32* [[adr0]]
  // CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 1
  // CHECK: store i32 [[res1]], i32* [[adr1]]
  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 2
  // CHECK: store i32 [[res2]], i32* [[adr2]]
  // CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 3
  // CHECK: store i32 [[res3]], i32* [[adr3]]
  // CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 4
  // CHECK: store i32 [[res4]], i32* [[adr4]]
  // CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 5
  // CHECK: store i32 [[res5]], i32* [[adr5]]
  // CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 6
  // CHECK: store i32 [[res6]], i32* [[adr6]]
  // CHECK: [[adr7:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 7
  // CHECK: store i32 [[res7]], i32* [[adr7]]
  // CHECK: [[adr8:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 8
  // CHECK: store i32 [[res8]], i32* [[adr8]]
  // CHECK: [[adr9:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 9
  // CHECK: store i32 [[res9]], i32* [[adr9]]

  // CHECK: ret void
  return res;
}

static const int Ix = 2;

// Test indexing operators
VTYPE index(VTYPE things[11], int i)[11] {
  // CHECK: [[res:%.*]] = alloca [10 x [[TYPE]]]
  VTYPE res[11];

  // CHECK: [[res0:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 0
  // CHECK: store [[TYPE]] {{(0|0*\.?0*e?\+?0*|0xH0000)}}, [[TYPE]]* [[res0]]
  res[0] = 0;

  // CHECK: [[adri:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 %i
  // CHECK: store [[TYPE]] [[POS1]], [[TYPE]]* [[adri]]
  res[i] = 1;

  // CHECK: [[adr2:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 2
  // CHECK: store [[TYPE]] {{(2|2\.?0*e?\+?0*|0xH4000)}}, [[TYPE]]* [[adr2]]
  res[Ix] = 2;

  // CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 0
  // CHECK: [[ld0:%.*]] = load [[TYPE]], [[TYPE]]* [[adr0]]
  // CHECK: [[adr3:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 3
  // CHECK: [[thg0:%.*]] = extractelement [[TYPE]] [[ld0]], i64 0
  // CHECK: store [[TYPE]] [[thg0]], [[TYPE]]* [[adr3]]
  res[3] = things[0];

  // CHECK: [[adri:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 %i
  // CHECK: [[ldi:%.*]] = load [[TYPE]], [[TYPE]]* [[adri]]
  // CHECK: [[adr4:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 4
  // CHECK: [[thgi:%.*]] = extractelement [[TYPE]] [[ldi]], i64 0
  // CHECK: store [[TYPE]] [[thgi]], [[TYPE]]* [[adr4]]
  res[4] = things[i];

  // CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x [[TYPE]]], [10 x [[TYPE]]]* %things, i32 0, i32 2
  // CHECK: [[ld2:%.*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // CHECK: [[adr5:%.*]] = getelementptr [10 x [[TYPE]]], [10 x [[TYPE]]]* [[res]], i32 0, i32 5
  // CHECK: [[thg2:%.*]] = extractelement [[TYPE]] [[ld2]], i64 0
  // CHECK: store [[TYPE]] [[thg2]], [[TYPE]]* [[adr5]]
  res[5] = things[Ix];
  // CHECK: ret void
  return res;
}

#ifdef INT
// Test bit twiddling operators.
void bittwiddlers(inout VTYPE things[13]) {
  // INT: [[adr1:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 1
  // INT: [[ld1:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr1]]
  // INT: [[val1:%[0-9]*]] = extractelement [[TYPE]] [[ld1]], i32 0
  // INT: [[xor1:%[0-9]*]] = xor [[TYPE]] [[val1]], -1
  // INT: [[res1:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[xor1]], i32 0
  // INT: [[adr0:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 0
  // INT: store [[TYPE]] [[res1]], [[TYPE]]* [[adr0]]
  things[0] = ~things[1];

  // INT: [[adr2:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 2
  // INT: [[ld2:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr2]]
  // INT: [[val2:%[0-9]*]] = extractelement [[TYPE]] [[ld2]], i32 0
  // INT: [[adr3:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 3
  // INT: [[ld3:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr3]]
  // INT: [[val3:%[0-9]*]] = extractelement [[TYPE]] [[ld3]], i32 0
  // INT: [[or1:%[0-9]*]] = or [[TYPE]] [[val3]], [[val2]]
  // INT: [[res1:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[or1]], i32 0
  // INT: store [[TYPE]] [[res1]], [[TYPE]]* [[adr1]]
  things[1] = things[2] | things[3];

  // INT: [[adr4:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 4
  // INT: [[ld4:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr4]]
  // INT: [[val4:%[0-9]*]] = extractelement [[TYPE]] [[ld4]], i32 0
  // INT: [[and2:%[0-9]*]] = and [[TYPE]] [[val4]], [[val3]]
  // INT: [[res2:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[and2]], i32 0
  // INT: store [[TYPE]] [[res2]], [[TYPE]]* [[adr2]]
  things[2] = things[3] & things[4];

  // INT: [[adr5:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 5
  // INT: [[ld5:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr5]]
  // INT: [[val5:%[0-9]*]] = extractelement [[TYPE]] [[ld5]], i32 0
  // INT: [[xor3:%[0-9]*]] = xor [[TYPE]] [[val5]], [[val4]]
  // INT: [[res3:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[xor3]], i32 0
  // INT: store [[TYPE]] [[res3]], [[TYPE]]* [[adr3]]
  things[3] = things[4] ^ things[5];

  // INT: [[adr6:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 6
  // INT: [[ld6:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr6]]
  // INT: [[val6:%[0-9]*]] = extractelement [[TYPE]] [[ld6]], i32 0
  // INT: [[shv6:%[0-9]*]] = and [[TYPE]] [[val6]]
  // INT: [[shl4:%[0-9]*]] = shl [[TYPE]] [[val5]], [[shv6]]
  // INT: [[res4:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[shl4]], i32 0
  // INT: store [[TYPE]] [[res4]], [[TYPE]]* [[adr4]]
  things[4] = things[5] << things[6];

  // INT: [[adr7:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 7
  // INT: [[ld7:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr7]]
  // INT: [[val7:%[0-9]*]] = extractelement [[TYPE]] [[ld7]], i32 0
  // INT: [[shv7:%[0-9]*]] = and [[TYPE]] [[val7]]
  // UNSIG: [[shr5:%[0-9]*]] = lshr [[TYPE]] [[val6]], [[shv7]]
  // SIG: [[shr5:%[0-9]*]] = ashr [[TYPE]] [[val6]], [[shv7]]
  // INT: [[res5:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[shr5]], i32 0
  // INT: store [[TYPE]] [[res5]], [[TYPE]]* [[adr5]]
  things[5] = things[6] >> things[7];

  // INT: [[adr8:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 8
  // INT: [[ld8:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr8]]
  // INT: [[val8:%[0-9]*]] = extractelement [[TYPE]] [[ld8]], i32 0
  // INT: [[or6:%[0-9]*]] = or [[TYPE]] [[val8]], [[val6]]
  // INT: [[res6:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[or6]], i32 0
  // INT: store [[TYPE]] [[res6]], [[TYPE]]* [[adr6]]
  things[6] |= things[8];

  // INT: [[adr9:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 9
  // INT: [[ld9:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr9]]
  // INT: [[val9:%[0-9]*]] = extractelement [[TYPE]] [[ld9]], i32 0
  // INT: [[and7:%[0-9]*]] = and [[TYPE]] [[val9]], [[val7]]
  // INT: [[res7:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[and7]], i32 0
  // INT: store [[TYPE]] [[res7]], [[TYPE]]* [[adr7]]
  things[7] &= things[9];

  // INT: [[adr10:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 10
  // INT: [[ld10:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr10]]
  // INT: [[val10:%[0-9]*]] = extractelement [[TYPE]] [[ld10]], i32 0
  // INT: [[xor8:%[0-9]*]] = xor [[TYPE]] [[val10]], [[val8]]
  // INT: [[res8:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[xor8]], i32 0
  // INT: store [[TYPE]] [[res8]], [[TYPE]]* [[adr8]]
  things[8] ^= things[10];

  // INT: [[adr11:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 11
  // INT: [[ld11:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr11]]
  // INT: [[val11:%[0-9]*]] = extractelement [[TYPE]] [[ld11]], i32 0
  // INT: [[shv11:%[0-9]*]] = and [[TYPE]] [[val11]]
  // INT: [[shl9:%[0-9]*]] = shl [[TYPE]] [[val9]], [[shv11]]
  // INT: [[res9:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[shl9]], i32 0
  // INT: store [[TYPE]] [[res9]], [[TYPE]]* [[adr9]]
  things[9] <<= things[11];

  // INT: [[adr12:%[0-9]*]] = getelementptr inbounds [13 x [[TYPE]]], [13 x [[TYPE]]]* %things, i32 0, i32 12
  // INT: [[ld12:%[0-9]*]] = load [[TYPE]], [[TYPE]]* [[adr12]]
  // INT: [[val12:%[0-9]*]] = extractelement [[TYPE]] [[ld12]], i32 0
  // INT: [[shv12:%[0-9]*]] = and [[TYPE]] [[val12]]
  // UNSIG: [[shr10:%[0-9]*]] = lshr [[TYPE]] [[val10]], [[shv12]]
  // SIG: [[shr10:%[0-9]*]] = ashr [[TYPE]] [[val10]], [[shv12]]
  // INT: [[res10:%.*]] = insertelement [[TYPE]] undef, [[TYPE]] [[shr10]], i32 0
  // INT: store [[TYPE]] [[res10]], [[TYPE]]* [[adr10]]
  things[10] >>= things[12];

  // INT: ret void
}
#endif // INT
