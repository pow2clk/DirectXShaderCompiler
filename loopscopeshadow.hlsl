// Test warnings for shadowed variables as a result of loop scope

float4 main(float f: F) : SV_Target {
#if 1
       uint i = 7;
       for (uint i = 0; i < 3; i++) {
         //uint i = 3;
         f += i;
       }
       return f + i;
#else
       return 0.0;
#endif
}
