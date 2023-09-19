// File for generating numthreads_shadermodels.ll to test pairing shader model tags with numthreads tags

RWStructuredBuffer<float4> output;
float4 foo;

[shader("compute")]
[NumThreads(32, 32, 1)]
void CSMain(uint ix : SV_GroupIndex) {
  output[ix] = foo;
}

struct payload_t { int nothing; };


[shader("amplification")]
[NumThreads(8, 8, 2)]
void ASMain(uint ix : SV_GroupIndex) {
  output[ix] = foo;
  payload_t p = {0};
  DispatchMesh(1, 1, 1, p);
}

[shader("mesh")]
[NumThreads(8, 8, 2)]
[OutputTopology("triangle")]
void MSMain(uint ix : SV_GroupIndex) {
  output[ix] = foo;
}

struct RECORD {
  uint ix;
};

[Shader("node")]
[NumThreads(1024,1,1)]
[NodeLaunch("Broadcasting")]
[NodeDispatchGrid(16,1,1)]
void NDMain(DispatchNodeInputRecord<RECORD> input)
{
  output[input.Get().ix] = foo;
}

