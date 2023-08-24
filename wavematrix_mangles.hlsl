// RUN: %dxc -fcgl -T cs_6_8 %s | FileCheck %s


RWByteAddressBuffer rwbuf;

groupshared float gs[512];

[NumThreads(64,1,1)]
void main(uint3 gtid : SV_GroupThreadID, uint gidx : SV_GroupIndex)
{
  // CHECK: dx.hl.wavematrix_annotate.amo
  // CHECK: dx.hl.wavematrix_annotate.amo
  WaveMatrixLeft<float, 64, 64> left;
  WaveMatrixRight<float, 64, 64> right;
  WaveMatrixAccumulator<float, 64, 64> acc;
  WaveMatrixLeftColAcc<float, 64, 64> leftcol;
  WaveMatrixRightRowAcc<float, 64, 64> rightrow;

  // CHECK: dx.hl.wavematrix_fill.amo.f32
  // CHECK: dx.hl.wavematrix_fill.amo.f32
  left.Fill(1);
  right.Fill(2);

  // CHECK: dx.hl.wavematrix_loadgroupshared.amo.f32
  // CHECK: dx.hl.wavematrix_storegroupshared.amo.f32
  left.Load(gs, 0, 16, false);
  left.Store(gs, 32, 16, true);

  // CHECK: dx.hl.wavematrix_multiply.amo
  // CHECK: dx.hl.wavematrix_multiply.amo
  //multiplyaccumulate?
  acc.Multiply(left, right);
  acc.MultiplyAccumulate(left, right);

  // CHECK: dx.hl.wavematrix_scalarop.amo.f32
  // CHECK: dx.hl.wavematrix_scalarop.amo.f32
  // CHECK: dx.hl.wavematrix_scalarop.amo.f32
  // CHECK: dx.hl.wavematrix_scalarop.amo.f32
  acc.ScalarMultiply(4);
  acc.ScalarDivide(4);
  acc.ScalarAdd(4);
  acc.ScalarSubtract(4);

  // CHECK: dx.hl.wavematrix_add.amo
  acc.Add(leftcol);

  // CHECK: dx.hl.wavematrix_accumulate.amo
  // CHECK: dx.hl.wavematrix_accumulate.amo
  leftcol.SumAccumulate(left);
  rightrow.SumAccumulate(right);

}
