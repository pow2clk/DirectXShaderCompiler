// RUN: %dxc -DFUNC=acos -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=asin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=atan2 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=cos -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=cosh -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=degrees -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=radians -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sinh -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=tan -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=abs -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ceil -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=clamp -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=exp2 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=floor -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=fmod -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=frac -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=frexp -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ldexp -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=lerp -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=log10 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=log2 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=mad -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=pow -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=rcp -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=round -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=rsqrt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sign -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=smoothstep -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=sqrt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=trunc -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=f16tof32 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=f32tof16 -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isfinite -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isinf -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=isnan -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=modf -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=saturate -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=reversebits -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=countbits -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=firstbithigh -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=firstbitlow -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=and -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=or -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=select -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=all -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=any -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=dot -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx_coarse -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddx_fine -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy_coarse -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=ddy_fine -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=fwidth -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadLaneAt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadLaneAcrossX -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadLaneAcrossY -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=QuadReadLaneAcrossDiagonal -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitAnd -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitOr -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveBitXor -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveProduct -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveSum -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveMin -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveMax -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMultiPrefixBitAnd -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMultiPrefixBitOr -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMultiPrefixBitXor -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMultiPrefixProduct -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMultiPrefixSum -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WavePrefixSum -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WavePrefixProduct -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveReadLaneAt -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveReadLaneFirst -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveActiveAllEqual -T ps_6_9 %s | Filecheck %s
// RUN: %dxc -DFUNC=WaveMatch -T ps_6_9 %s | Filecheck %s


StructuredBuffer< vector<uint, 8> > buf;
ByteAddressBuffer rbuf;

float4 main(uint i : SV_PrimitiveID) : SV_Target {
  vector<uint, 8> vec = FUNC(rbuf.Load< vector<uint, 8> >(i*32));;
  return float4(vec[0] + vec[1], vec[2] + vec[3], vec[4] + vec[5], vec[6] + vec[7]);
}
