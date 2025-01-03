// RUN: %dxc -DFUNC=acos -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=asin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=cos -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=cosh -T ps_6_9 %s | Filecheck %s
// RUIN: %dxc -DFUNC=degrees -T ps_6_9 %s | Filecheck %s
// RUIN: %dxc -DFUNC=radians -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sinh -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=tan -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=abs -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ceil -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=exp2 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=floor -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=frac -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=log10 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=log2 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=round -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=rsqrt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sqrt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=trunc -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=f16tof32 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=f32tof16 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isfinite -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isinf -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isnan -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=saturate -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=reversebits -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=countbits -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=firstbithigh -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=firstbitlow -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx_coarse -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx_fine -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy_coarse -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy_fine -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=fwidth -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadAcrossX -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadAcrossY -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadAcrossDiagonal -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitAnd -DTYPE=uint -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitOr -DTYPE=uint -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitXor -DTYPE=uint -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveProduct -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveSum -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveMin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveMax -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WavePrefixSum -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WavePrefixProduct -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveReadLaneFirst -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveAllEqual -T ps_6_9 %s | Filecheck %s

#ifndef TYPE
#define TYPE int
#endif

#if ARITY == 1
#define CALLARGS(x) x
#elif ARITY == 2
#define CALLARGS(x) x, x
#endif


StructuredBuffer< vector<TYPE, 8> > buf;
ByteAddressBuffer rbuf;

float4 main(uint i : SV_PrimitiveID) : SV_Target {
  // CHECK: [[resret:%.*]] = call %dx.types.ResRet.{{.*}} @dx.op.rawBufferLoad
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  // CHECK: call {{.*}} @dx.op.
  vector<TYPE, 8> arg = rbuf.Load< vector<TYPE, 8> >(i*32);

  vector<TYPE, 8> vec = FUNC(CALLARGS(arg));
  return float4(vec[0] + vec[1], vec[2] + vec[3], vec[4] + vec[5], vec[6] + vec[7]);
}
