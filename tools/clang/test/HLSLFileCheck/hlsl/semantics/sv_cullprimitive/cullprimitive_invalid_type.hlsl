// RUN: %dxc -T ps_6_4 -E main %s | FileCheck %s
// RUN: %dxc -T ms_6_5 -E ms %s | FileCheck %s -check-prefix=MS
// RUN: %dxc -T ms_6_5 -E ms2 %s | FileCheck %s -check-prefix=MS2

// SV_CullPrimitive must be a scalar bool.

// CHECK: error: SV_CullPrimitive must be applied to a scalar bool, but 'b' has type 'uint'
uint main(uint b : SV_CullPrimitive) : SV_Target {
  return b;
}

struct Prim {
  float f : A;
  int cull : SV_CullPrimitive;
};

// MS: error: SV_CullPrimitive must be applied to a scalar bool, but 'cull' has type 'int'
[numthreads(1, 1, 1)] [outputtopology("triangle")]
void ms(out indices uint3 idx[1], out primitives Prim prims[1]) {
  SetMeshOutputCounts(0, 0);
}

struct PrimArr {
  bool cull[2] : SV_CullPrimitive;
};

// MS2: error: SV_CullPrimitive must be applied to a scalar bool, but 'cull' has type 'bool [2]'
[numthreads(1, 1, 1)] [outputtopology("triangle")]
void ms2(out indices uint3 idx[1], out primitives PrimArr prims[1]) {
  SetMeshOutputCounts(0, 0);
}
