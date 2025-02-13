// RUN: %dxc -DTYPE=float4    -DIX=SIx -T vs_6_6 %s | FileCheck %s
// RUN: %dxc -DTYPE=bool4     -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I1
// RUN: %dxc -DTYPE=uint64_t2 -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I64
// RUN: %dxc -DTYPE=double2   -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,F64

// RUN: %dxc -DTYPE=float4    -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX
// RUN: %dxc -DTYPE=bool4     -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I1
// RUN: %dxc -DTYPE=uint64_t2 -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I64
// RUN: %dxc -DTYPE=double2   -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,F64

// RUN: %dxc -DTYPE=float    -DIX=SIx -T vs_6_6 %s | FileCheck %s
// RUN: %dxc -DTYPE=bool     -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I1
// RUN: %dxc -DTYPE=uint64_t -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I64
// RUN: %dxc -DTYPE=double   -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,F64

// RUN: %dxc -DTYPE=float    -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX
// RUN: %dxc -DTYPE=bool     -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I1
// RUN: %dxc -DTYPE=uint64_t -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I64
// RUN: %dxc -DTYPE=double   -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,F64

// RUN: %dxc -DTYPE=float1    -DIX=SIx -T vs_6_6 %s | FileCheck %s
// RUN: %dxc -DTYPE=bool1     -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I1
// RUN: %dxc -DTYPE=uint64_t1 -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,I64
// RUN: %dxc -DTYPE=double1   -DIX=SIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,F64

// RUN: %dxc -DTYPE=float1    -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX
// RUN: %dxc -DTYPE=bool1     -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I1
// RUN: %dxc -DTYPE=uint64_t1 -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,I64
// RUN: %dxc -DTYPE=double1   -DIX=VIx -T vs_6_6 %s | FileCheck %s --check-prefixes=CHECK,VIX,F64

///////////////////////////////////////////////////////////////////////
// Test codegen for various load and store operations and conversions
//  for different scalar/vector buffer types and indices.
///////////////////////////////////////////////////////////////////////



// CHECK-DAG: %dx.types.ResRet.[[TY:[a-z][0-9][0-9]]] = type { [[TYPE:[a-z0-9]*]],
// CHECK-DAG: %dx.types.ResRet.[[TY32:[a-z][0-9][0-9]]] = type { [[TYPE]],

  ByteAddressBuffer RoByBuf : register(t1);
RWByteAddressBuffer RwByBuf : register(u1);

  StructuredBuffer< TYPE > RoStBuf : register(t2);
RWStructuredBuffer< TYPE > RwStBuf : register(u2);

  Buffer< TYPE > RoTyBuf : register(t3);
RWBuffer< TYPE > RwTyBuf : register(u3);

ConsumeStructuredBuffer<TYPE> CnStBuf : register(u4);
AppendStructuredBuffer<TYPE> ApStBuf  : register(u5);

void main(uint SIx[2] : SIX, uint1 VIx[2] : VIX) {
  // ByteAddressBuffer Tests

  // CHECK-DAG: [[HDLROBY:%.*]] = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 0 }, i32 1, i1 false)
  // CHECK-DAG: [[HDLRWBY:%.*]] = call %dx.types.Handle @dx.op.createHandleFromBinding(i32 217, %dx.types.ResBind { i32 1, i32 1, i32 0, i8 1 }, i32 1, i1 false)

  // CHECK: [[IX0:%.*]] = call i32 @dx.op.loadInput.i32(i32 4,

  // CHECK: [[ANHDLRWBY:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[HDLRWBY]]
  // CHECK: call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ANHDLRWBY]], i32 [[IX0]]
  // I1: icmp ne i32 %{{.*}}, 0
  TYPE babElt1 = RwByBuf.Load< TYPE >(IX[0]);

  // CHECK: [[ANHDLROBY:%.*]] = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle [[HDLROBY]]
  // CHECK: call %dx.types.ResRet.[[TY]] @dx.op.rawBufferLoad.[[TY]](i32 139, %dx.types.Handle [[ANHDLROBY]], i32 [[IX0]]
  // I1: icmp ne i32 %{{.*}}, 0
  TYPE babElt2 = RoByBuf.Load< TYPE >(IX[0]);

  // I1: zext i1 %{{.*}} to i32
  // CHECK: all void @dx.op.rawBufferStore.[[TY]](i32 140, %dx.types.Handle [[ANHDLRWBY]], i32 [[IX0]]
  RwByBuf.Store< TYPE >(IX[0], babElt1 + babElt2);
}
