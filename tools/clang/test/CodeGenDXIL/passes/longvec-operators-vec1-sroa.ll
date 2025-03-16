; RUN: %dxopt %s -hlsl-passes-resume -scalarrepl-param-hlsl -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%"class.RWStructuredBuffer<vector<float, 1> >" = type { <1 x float> }
%ConstantBuffer = type opaque
%dx.types.Handle = type { i8* }
%dx.types.ResourceProperties = type { i32, i32 }

@"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A" = external global %"class.RWStructuredBuffer<vector<float, 1> >", align 4
@Ix = internal constant i32 2, align 4
@"$Globals" = external constant %ConstantBuffer

; Function Attrs: nounwind
; CHECK-LABEL: define void @"\01?assignments
define void @"\01?assignments@@YAXY09$$CAV?$vector@M$00@@@Z"([10 x <1 x float>]* noalias %things) #0 {
bb:
  %tmp = load %"class.RWStructuredBuffer<vector<float, 1> >", %"class.RWStructuredBuffer<vector<float, 1> >"* @"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A"
  %tmp1 = call %dx.types.Handle @"dx.hl.createhandle..%dx.types.Handle (i32, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32 0, %"class.RWStructuredBuffer<vector<float, 1> >" %tmp)
  %tmp2 = call %dx.types.Handle @"dx.hl.annotatehandle..%dx.types.Handle (i32, %dx.types.Handle, %dx.types.ResourceProperties, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32 14, %dx.types.Handle %tmp1, %dx.types.ResourceProperties { i32 4108, i32 4 }, %"class.RWStructuredBuffer<vector<float, 1> >" undef)
  %tmp3 = call <1 x float> @"dx.hl.op.ro.<1 x float> (i32, %dx.types.Handle, i32)"(i32 231, %dx.types.Handle %tmp2, i32 1)
  %tmp4 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 0
  store <1 x float> %tmp3, <1 x float>* %tmp4, align 4

  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]]
  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load <1 x float>, <1 x float>* [[adr1]]
  ; CHECK: [[res1:%.*]] = fadd <1 x float> [[ld1]], [[ld5]]
  ; CHECK: store <1 x float> [[res1]], <1 x float>* [[adr1]], align 4
  %tmp5 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  %tmp6 = load <1 x float>, <1 x float>* %tmp5, align 4
  %tmp7 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 1
  %tmp8 = load <1 x float>, <1 x float>* %tmp7, align 4
  %tmp9 = fadd <1 x float> %tmp8, %tmp6
  store <1 x float> %tmp9, <1 x float>* %tmp7, align 4

  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load <1 x float>, <1 x float>* [[adr6]]
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]]
  ; CHECK: [[res2:%.*]] = fsub <1 x float> [[ld2]], [[ld6]]
  ; CHECK: store <1 x float> [[res2]], <1 x float>* [[adr2]], align 4
  %tmp10 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 6
  %tmp11 = load <1 x float>, <1 x float>* %tmp10, align 4
  %tmp12 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  %tmp13 = load <1 x float>, <1 x float>* %tmp12, align 4
  %tmp14 = fsub <1 x float> %tmp13, %tmp11
  store <1 x float> %tmp14, <1 x float>* %tmp12, align 4

  ; CHECK: [[adr7:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 7
  ; CHECK: [[ld7:%.*]] = load <1 x float>, <1 x float>* [[adr7]]
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load <1 x float>, <1 x float>* [[adr3]]
  ; CHECK: [[res3:%.*]] = fmul <1 x float> [[ld3]], [[ld7]]
  ; CHECK: store <1 x float> [[res3]], <1 x float>* [[adr3]], align 4
  %tmp15 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 7
  %tmp16 = load <1 x float>, <1 x float>* %tmp15, align 4
  %tmp17 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 3
  %tmp18 = load <1 x float>, <1 x float>* %tmp17, align 4
  %tmp19 = fmul <1 x float> %tmp18, %tmp16
  store <1 x float> %tmp19, <1 x float>* %tmp17, align 4

  ; CHECK: [[adr8:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 8
  ; CHECK: [[ld8:%.*]] = load <1 x float>, <1 x float>* [[adr8]]
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load <1 x float>, <1 x float>* [[adr4]]
  ; CHECK: [[res4:%.*]] = fdiv <1 x float> [[ld4]], [[ld8]]
  ; CHECK: store <1 x float> [[res4]], <1 x float>* [[adr4]], align 4
  %tmp20 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 8
  %tmp21 = load <1 x float>, <1 x float>* %tmp20, align 4
  %tmp22 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 4
  %tmp23 = load <1 x float>, <1 x float>* %tmp22, align 4
  %tmp24 = fdiv <1 x float> %tmp23, %tmp21
  store <1 x float> %tmp24, <1 x float>* %tmp22, align 4

  ; CHECK: [[adr9:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 9
  ; CHECK: [[ld9:%.*]] = load <1 x float>, <1 x float>* [[adr9]]
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]]
  ; CHECK: [[res5:%.*]] = frem <1 x float> [[ld5]], [[ld9]]
  ; CHECK: store <1 x float> [[res5]], <1 x float>* [[adr5]], align 4
  %tmp25 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 9
  %tmp26 = load <1 x float>, <1 x float>* %tmp25, align 4
  %tmp27 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  %tmp28 = load <1 x float>, <1 x float>* %tmp27, align 4
  %tmp29 = frem <1 x float> %tmp28, %tmp26
  store <1 x float> %tmp29, <1 x float>* %tmp27, align 4
  ret void
}

; Function Attrs: nounwind
; CHECK-LABEL: define void @"\01?arithmetic
define void @"\01?arithmetic@@YA$$BY0L@V?$vector@M$00@@Y0L@$$CAV1@@Z"([11 x <1 x float>]* noalias sret %agg.result, [11 x <1 x float>]* noalias %things) #0 {
bb:
  ; CHECK: %res.0 = alloca [11 x float]
  %res = alloca [11 x <1 x float>], align 4

  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  ; CHECK: [[ld0:%.*]] = load <1 x float>, <1 x float>* [[adr0]]
  ; CHECK: [[res0:%.*]] = fsub <1 x float> <float -0.000000e+00>, [[ld0]]
  ; CHECK: [[adr0:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 0
  ; CHECK: [[val0:%.*]] = extractelement <1 x float> [[res0]], i64 0
  ; CHECK: store float [[val0]], float* [[adr0]]
  %tmp1 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  %tmp2 = load <1 x float>, <1 x float>* %tmp1, align 4
  %tmp3 = fsub <1 x float> <float -0.000000e+00>, %tmp2
  %tmp4 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 0
  store <1 x float> %tmp3, <1 x float>* %tmp4, align 4

  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  ; CHECK: [[ld0:%.*]] = load <1 x float>, <1 x float>* [[adr0]], align 4
  ; CHECK: [[adr1:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 1
  ; CHECK: [[val1:%.*]] = extractelement <1 x float> [[ld0]], i64 0
  ; CHECK: store float [[val1]], float* [[adr1]]
  %tmp5 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  %tmp6 = load <1 x float>, <1 x float>* %tmp5, align 4
  %tmp7 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 1
  store <1 x float> %tmp6, <1 x float>* %tmp7, align 4

  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load <1 x float>, <1 x float>* [[adr1]], align 4
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]], align 4
  ; CHECK: [[res2:%.*]] = fadd <1 x float> [[ld1]], [[ld2]]
  ; CHECK: [[adr2:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 2
  ; CHECK: [[val2:%.*]] = extractelement <1 x float> [[res2]], i64 0
  ; CHECK: store float [[val2]], float* [[adr2]]
  %tmp8 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 1
  %tmp9 = load <1 x float>, <1 x float>* %tmp8, align 4
  %tmp10 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  %tmp11 = load <1 x float>, <1 x float>* %tmp10, align 4
  %tmp12 = fadd <1 x float> %tmp9, %tmp11
  %tmp13 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 2
  store <1 x float> %tmp12, <1 x float>* %tmp13, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]], align 4
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load <1 x float>, <1 x float>* [[adr3]], align 4
  ; CHECK: [[res3:%.*]] = fsub <1 x float> [[ld2]], [[ld3]]
  ; CHECK: [[adr3:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 3
  ; CHECK: [[val3:%.*]] = extractelement <1 x float> [[res3]], i64 0
  ; CHECK: store float [[val3]], float* [[adr3]]
  %tmp14 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  %tmp15 = load <1 x float>, <1 x float>* %tmp14, align 4
  %tmp16 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  %tmp17 = load <1 x float>, <1 x float>* %tmp16, align 4
  %tmp18 = fsub <1 x float> %tmp15, %tmp17
  %tmp19 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 3
  store <1 x float> %tmp18, <1 x float>* %tmp19, align 4

  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load <1 x float>, <1 x float>* [[adr3]], align 4
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load <1 x float>, <1 x float>* [[adr4]], align 4
  ; CHECK: [[res4:%.*]] = fmul <1 x float> [[ld3]], [[ld4]]
  ; CHECK: [[adr4:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 4
  ; CHECK: [[val4:%.*]] = extractelement <1 x float> [[res4]], i64 0
  ; CHECK: store float [[val4]], float* [[adr4]]
  %tmp20 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  %tmp21 = load <1 x float>, <1 x float>* %tmp20, align 4
  %tmp22 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  %tmp23 = load <1 x float>, <1 x float>* %tmp22, align 4
  %tmp24 = fmul <1 x float> %tmp21, %tmp23
  %tmp25 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 4
  store <1 x float> %tmp24, <1 x float>* %tmp25, align 4

  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load <1 x float>, <1 x float>* [[adr4]], align 4
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]], align 4
  ; CHECK: [[res5:%.*]] = fdiv <1 x float> [[ld4]], [[ld5]]
  ; CHECK: [[adr5:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 5
  ; CHECK: [[val5:%.*]] = extractelement <1 x float> [[res5]], i64 0
  ; CHECK: store float [[val5]], float* [[adr5]]
  %tmp26 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  %tmp27 = load <1 x float>, <1 x float>* %tmp26, align 4
  %tmp28 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  %tmp29 = load <1 x float>, <1 x float>* %tmp28, align 4
  %tmp30 = fdiv <1 x float> %tmp27, %tmp29
  %tmp31 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 5
  store <1 x float> %tmp30, <1 x float>* %tmp31, align 4

  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]], align 4
  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load <1 x float>, <1 x float>* [[adr6]], align 4
  ; CHECK: [[res6:%.*]] = frem <1 x float> [[ld5]], [[ld6]]
  ; CHECK  [[adr6:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 6
  ; CHECK  [[val6:%.*]] = extractelement <1 x float> [[res6]], i64 0
  ; CHECK  store float [[val6]], float* [[adr6]]
  %tmp32 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  %tmp33 = load <1 x float>, <1 x float>* %tmp32, align 4
  %tmp34 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 6
  %tmp35 = load <1 x float>, <1 x float>* %tmp34, align 4
  %tmp36 = frem <1 x float> %tmp33, %tmp35
  %tmp37 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 6
  store <1 x float> %tmp36, <1 x float>* %tmp37, align 4

  ; CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 7
  ; CHECK: [[ld7:%.*]] = load <1 x float>, <1 x float>* [[adr7]], align 4
  ; CHECK: [[res7:%.*]] = fadd <1 x float> [[ld7]], <float 1.000000e+00>
  ; CHECK: store <1 x float> [[res7]], <1 x float>* [[adr7]], align 4
  ; CHECK: [[adr7:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 7
  ; CHECK: [[val7:%.*]] = extractelement <1 x float> [[ld7]], i64 0
  ; CHECK: store float [[val7]], float* [[adr7]]
  %tmp38 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 7
  %tmp39 = load <1 x float>, <1 x float>* %tmp38, align 4
  %tmp40 = fadd <1 x float> %tmp39, <float 1.000000e+00>
  store <1 x float> %tmp40, <1 x float>* %tmp38, align 4
  %tmp41 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 7
  store <1 x float> %tmp39, <1 x float>* %tmp41, align 4

  ; CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 8
  ; CHECK: [[ld8:%.*]] = load <1 x float>, <1 x float>* [[adr8]], align 4
  ; CHECK: [[res8:%.*]] = fadd <1 x float> [[ld8]], <float -1.000000e+00>
  ; CHECK: [[adr8:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 8
  ; CHECK: [[val8:%.*]] = extractelement <1 x float> [[ld8]], i64 0
  ; CHECK: store float [[val8]], float* [[adr8]]
  %tmp42 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 8
  %tmp43 = load <1 x float>, <1 x float>* %tmp42, align 4
  %tmp44 = fadd <1 x float> %tmp43, <float -1.000000e+00>
  store <1 x float> %tmp44, <1 x float>* %tmp42, align 4
  %tmp45 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 8
  store <1 x float> %tmp43, <1 x float>* %tmp45, align 4

  ; CHECK: [[adr9:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 9
  ; CHECK: [[ld9:%.*]] = load <1 x float>, <1 x float>* [[adr9]], align 4
  ; CHECK: [[res9:%.*]] = fadd <1 x float> [[ld9]], <float 1.000000e+00>
  ; CHECK: [[adr9:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 9
  ; CHECK: [[val9:%.*]] = extractelement <1 x float> [[res9]], i64 0
  ; CHECK: store float [[val9]], float* [[adr9]]
  %tmp46 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 9
  %tmp47 = load <1 x float>, <1 x float>* %tmp46, align 4
  %tmp48 = fadd <1 x float> %tmp47, <float 1.000000e+00>
  store <1 x float> %tmp48, <1 x float>* %tmp46, align 4
  %tmp49 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 9
  store <1 x float> %tmp48, <1 x float>* %tmp49, align 4

  ; CHECK: [[adr10:%.*]] = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 10
  ; CHECK: [[ld10:%.*]] = load <1 x float>, <1 x float>* [[adr10]], align 4
  ; CHECK: [[res10:%.*]] = fadd <1 x float> [[ld10]], <float -1.000000e+00>
  ; CHECK: [[adr10:%.*]] = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 10
  ; CHECK: [[val10:%.*]] = extractelement <1 x float> [[res10]], i64 0
  ; CHECK: store float [[val10]], float* [[adr10]]
  %tmp50 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 10
  %tmp51 = load <1 x float>, <1 x float>* %tmp50, align 4
  %tmp52 = fadd <1 x float> %tmp51, <float -1.000000e+00>
  store <1 x float> %tmp52, <1 x float>* %tmp50, align 4
  %tmp53 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %res, i32 0, i32 10
  store <1 x float> %tmp52, <1 x float>* %tmp53, align 4

  %tmp54 = bitcast [11 x <1 x float>]* %agg.result to i8*
  %tmp55 = bitcast [11 x <1 x float>]* %res to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %tmp54, i8* %tmp55, i64 44, i32 1, i1 false)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #0

; Function Attrs: nounwind
; CHECK-LABEL: define void @"\01?logic
define void @"\01?logic@@YA$$BY09_NY09_NY09V?$vector@M$00@@@Z"([10 x i32]* noalias sret %agg.result, [10 x i32]* %truth, [10 x <1 x float>]* %consequences) #0 {
bb:
  %res = alloca [10 x i32], align 4

  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 0
  ; CHECK: [[ld0:%.*]] = load i32, i32* [[adr0]], align 4
  ; CHECK: [[cmp0:%.*]] = icmp ne i32 [[ld0]], 0
  ; CHECK: [[bres0:%.*]] = xor i1 [[cmp0]], true
  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 0
  ; CHECK: [[res0:%.*]] = zext i1 [[bres0]] to i32
  ; CHECK: store i32 [[res0]], i32* [[adr0]], align 4
  %tmp1 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 0
  %tmp2 = load i32, i32* %tmp1, align 4
  %tmp3 = icmp ne i32 %tmp2, 0
  %tmp4 = xor i1 %tmp3, true
  %tmp5 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 0
  %tmp6 = zext i1 %tmp4 to i32
  store i32 %tmp6, i32* %tmp5, align 4

  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load i32, i32* [[adr1]], align 4
  ; CHECK: [[cmp1:%.*]] = icmp ne i32 [[ld1]], 0
  %tmp7 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 1
  %tmp8 = load i32, i32* %tmp7, align 4
  %tmp9 = icmp ne i32 %tmp8, 0
  br i1 %tmp9, label %bb14, label %bb10

bb10:                                             ; preds = %bb
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load i32, i32* [[adr2]], align 4
  ; CHECK: [[cmp2:%.*]] = icmp ne i32 [[ld2]], 0
  %tmp11 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  %tmp12 = load i32, i32* %tmp11, align 4
  %tmp13 = icmp ne i32 %tmp12, 0
  br label %bb14

bb14:                                             ; preds = %bb10, %bb
  ; CHECK: [[bres1:%.*]] = phi i1 [ true, %bb ], [ [[cmp2]], %bb10 ]
  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 1
  ; CHECK: [[res1:%.*]] = zext i1 [[bres1]] to i32
  ; CHECK: store i32 [[res1]], i32* [[adr1]], align 4
  %tmp15 = phi i1 [ true, %bb ], [ %tmp13, %bb10 ]
  %tmp16 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 1
  %tmp17 = zext i1 %tmp15 to i32
  store i32 %tmp17, i32* %tmp16, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load i32, i32* [[adr2]], align 4
  ; CHECK: [[cmp2:%.*]] = icmp ne i32 [[ld2]], 0
  %tmp18 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  %tmp19 = load i32, i32* %tmp18, align 4
  %tmp20 = icmp ne i32 %tmp19, 0
  br i1 %tmp20, label %bb21, label %bb25

bb21:                                             ; preds = %bb14
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load i32, i32* [[adr3]], align 4
  ; CHECK: [[cmp3:%.*]] = icmp ne i32 [[ld3]], 0
  %tmp22 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  %tmp23 = load i32, i32* %tmp22, align 4
  %tmp24 = icmp ne i32 %tmp23, 0
  br label %bb25

bb25:                                             ; preds = %bb21, %bb14
  ; CHECK: [[bres2:%.*]] = phi i1 [ false, %bb14 ], [ [[cmp3]], %bb21 ]
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 2
  ; CHECK: [[res2:%.*]] = zext i1 [[bres2]] to i32
  ; CHECK: store i32 [[res2]], i32* [[adr2]], align 4
  %tmp26 = phi i1 [ false, %bb14 ], [ %tmp24, %bb21 ]
  %tmp27 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 2
  %tmp28 = zext i1 %tmp26 to i32
  store i32 %tmp28, i32* %tmp27, align 4

  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load i32, i32* [[adr3]], align 4
  ; CHECK: [[cmp3:%.*]] = icmp ne i32 [[ld3]], 0
  %tmp29 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  %tmp30 = load i32, i32* %tmp29, align 4
  %tmp31 = icmp ne i32 %tmp30, 0
  br i1 %tmp31, label %bb32, label %bb35

bb32:                                             ; preds = %bb25
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load i32, i32* [[adr4]], align 4
  %tmp33 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 4
  %tmp34 = load i32, i32* %tmp33, align 4
  br label %bb38

bb35:                                             ; preds = %bb25
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load i32, i32* [[adr5]], align 4
  %tmp36 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 5
  %tmp37 = load i32, i32* %tmp36, align 4
  br label %bb38

bb38:                                             ; preds = %bb35, %bb32
  ; CHECK: [[res3:%.*]] = phi i32 [ [[ld4]], %bb32 ], [ [[ld5]], %bb35 ]
  ; CHECK: [[bres3:%.*]] = icmp ne i32 [[res3]], 0
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 3
  ; CHECK: [[res3:%.*]] = zext i1 [[bres3]] to i32
  ; CHECK: store i32 [[res3]], i32* [[adr3]], align 4
  %.sink = phi i32 [ %tmp34, %bb32 ], [ %tmp37, %bb35 ]
  %tmp39 = icmp ne i32 %.sink, 0
  %tmp40 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 3
  %tmp41 = zext i1 %tmp39 to i32
  store i32 %tmp41, i32* %tmp40, align 4

  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 0
  ; CHECK: [[ld0:%.*]] = load <1 x float>, <1 x float>* [[adr0]], align 4
  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load <1 x float>, <1 x float>* [[adr1]], align 4
  ; CHECK: [[bres4:%.*]] = fcmp oeq <1 x float> [[ld0]], [[ld1]]
  ; CHECK: [[val4:%.*]] = extractelement <1 x i1> [[bres4]], i64 0
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 4
  ; CHECK: [[res4:%.*]] = zext i1 [[val4]] to i32
  ; CHECK: store i32 [[res4]], i32* [[adr4]]
  %tmp42 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 0
  %tmp43 = load <1 x float>, <1 x float>* %tmp42, align 4
  %tmp44 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  %tmp45 = load <1 x float>, <1 x float>* %tmp44, align 4
  %tmp46 = fcmp oeq <1 x float> %tmp43, %tmp45
  %tmp47 = extractelement <1 x i1> %tmp46, i64 0
  %tmp48 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 4
  %tmp49 = zext i1 %tmp47 to i32
  store i32 %tmp49, i32* %tmp48, align 4

  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load <1 x float>, <1 x float>* [[adr1]], align 4
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]], align 4
  ; CHECK: [[bres5:%.*]] = fcmp une <1 x float> [[ld1]], [[ld2]]
  ; CHECK: [[val5:%.*]] = extractelement <1 x i1> [[bres5]], i64 0
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 5
  ; CHECK: [[res5:%.*]] = zext i1 [[val5]] to i32
  ; CHECK: store i32 [[res5]], i32* [[adr5]]
  %tmp50 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  %tmp51 = load <1 x float>, <1 x float>* %tmp50, align 4
  %tmp52 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  %tmp53 = load <1 x float>, <1 x float>* %tmp52, align 4
  %tmp54 = fcmp une <1 x float> %tmp51, %tmp53
  %tmp55 = extractelement <1 x i1> %tmp54, i64 0
  %tmp56 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 5
  %tmp57 = zext i1 %tmp55 to i32
  store i32 %tmp57, i32* %tmp56, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]], align 4
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load <1 x float>, <1 x float>* [[adr3]], align 4
  ; CHECK: [[bres6:%.*]] = fcmp olt <1 x float> [[ld2]], [[ld3]]
  ; CHECK: [[val6:%.*]] = extractelement <1 x i1> [[bres6]], i64 0
  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 6
  ; CHECK: [[res6:%.*]] = zext i1 [[val6]] to i32
  ; CHECK: store i32 [[res6]], i32* [[adr6]]
  %tmp58 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  %tmp59 = load <1 x float>, <1 x float>* %tmp58, align 4
  %tmp60 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  %tmp61 = load <1 x float>, <1 x float>* %tmp60, align 4
  %tmp62 = fcmp olt <1 x float> %tmp59, %tmp61
  %tmp63 = extractelement <1 x i1> %tmp62, i64 0
  %tmp64 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 6
  %tmp65 = zext i1 %tmp63 to i32
  store i32 %tmp65, i32* %tmp64, align 4

  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load <1 x float>, <1 x float>* [[adr3]], align 4
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load <1 x float>, <1 x float>* [[adr4]], align 4
  ; CHECK: [[bres7:%.*]] = fcmp ogt <1 x float> [[ld3]], [[ld4]]
  ; CHECK: [[val7:%.*]] = extractelement <1 x i1> [[bres7]], i64 0
  ; CHECK: [[adr7:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 7
  ; CHECK: [[res7:%.*]] = zext i1 [[val7]] to i32
  ; CHECK: store i32 [[res7]], i32* [[adr7]]
  %tmp66 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  %tmp67 = load <1 x float>, <1 x float>* %tmp66, align 4
  %tmp68 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  %tmp69 = load <1 x float>, <1 x float>* %tmp68, align 4
  %tmp70 = fcmp ogt <1 x float> %tmp67, %tmp69
  %tmp71 = extractelement <1 x i1> %tmp70, i64 0
  %tmp72 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 7
  %tmp73 = zext i1 %tmp71 to i32
  store i32 %tmp73, i32* %tmp72, align 4

  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load <1 x float>, <1 x float>* [[adr4]], align 4
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]], align 4
  ; CHECK: [[bres8:%.*]] = fcmp ole <1 x float> [[ld4]], [[ld5]]
  ; CHECK: [[val8:%.*]] = extractelement <1 x i1> [[bres8]], i64 0
  ; CHECK: [[adr8:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 8
  ; CHECK: [[res8:%.*]] = zext i1 [[val8]] to i32
  ; CHECK: store i32 [[res8]], i32* [[adr8]]
  %tmp74 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  %tmp75 = load <1 x float>, <1 x float>* %tmp74, align 4
  %tmp76 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  %tmp77 = load <1 x float>, <1 x float>* %tmp76, align 4
  %tmp78 = fcmp ole <1 x float> %tmp75, %tmp77
  %tmp79 = extractelement <1 x i1> %tmp78, i64 0
  %tmp80 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 8
  %tmp81 = zext i1 %tmp79 to i32
  store i32 %tmp81, i32* %tmp80, align 4

  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load <1 x float>, <1 x float>* [[adr5]], align 4
  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load <1 x float>, <1 x float>* [[adr6]], align 4
  ; CHECK: [[bres9:%.*]] = fcmp oge <1 x float> [[ld5]], [[ld6]]
  ; CHECK: [[val9:%.*]] = extractelement <1 x i1> [[bres9]], i64 0
  ; CHECK: [[adr9:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 9
  ; CHECK: [[res9:%.*]] = zext i1 [[val9]] to i32
  ; CHECK: store i32 [[res9]], i32* [[adr9]]
  %tmp82 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  %tmp83 = load <1 x float>, <1 x float>* %tmp82, align 4
  %tmp84 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 6
  %tmp85 = load <1 x float>, <1 x float>* %tmp84, align 4
  %tmp86 = fcmp oge <1 x float> %tmp83, %tmp85
  %tmp87 = extractelement <1 x i1> %tmp86, i64 0
  %tmp88 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 9
  %tmp89 = zext i1 %tmp87 to i32
  store i32 %tmp89, i32* %tmp88, align 4

  %tmp90 = bitcast [10 x i32]* %agg.result to i8*
  %tmp91 = bitcast [10 x i32]* %res to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %tmp90, i8* %tmp91, i64 40, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind
; CHECK-LABEL: define void @"\01?index
define void @"\01?index@@YA$$BY09V?$vector@M$00@@Y09V1@H@Z"([10 x <1 x float>]* noalias sret %agg.result, [10 x <1 x float>]* %things, i32 %i) #0 {
bb:
  %tmp = alloca i32, align 4, !dx.temp !14

  ; CHECK: %res.0 = alloca [10 x float]  
  ; CHECK: store i32 %i, i32* [[i:%.*]], align 4
  %res = alloca [10 x <1 x float>], align 4
  store i32 %i, i32* %tmp, align 4, !tbaa !40

  ; CHECK: [[adr0:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 0
  ; CHECK: store float 0.000000e+00, float* [[adr0]]
  %tmp2 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 0
  store <1 x float> zeroinitializer, <1 x float>* %tmp2, align 4

  ; CHECK: [[ival:%.*]] = load i32, i32* [[i]]
  ; CHECK: [[adri:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 [[ival]]
  ; CHECK: store float 1.000000e+00, float* [[adri]]
  %tmp3 = load i32, i32* %tmp, align 4
  %tmp4 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 %tmp3
  store <1 x float> <float 1.000000e+00>, <1 x float>* %tmp4, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 2
  ; CHECK: store float 2.000000e+00, float* [[adr2]]
  %tmp5 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 2
  store <1 x float> <float 2.000000e+00>, <1 x float>* %tmp5, align 4

  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 0
  ; CHECK: [[ld0:%.*]] = load <1 x float>, <1 x float>* [[adr0]]
  ; CHECK: [[adr3:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 3
  ; CHECK: [[val0:%.*]] = extractelement <1 x float> [[ld0]], i64 0
  ; CHECK: store float [[val0]], float* [[adr3]]
  %tmp6 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 0
  %tmp7 = load <1 x float>, <1 x float>* %tmp6, align 4
  %tmp8 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 3
  store <1 x float> %tmp7, <1 x float>* %tmp8, align 4

  ; CHECK: [[ival:%.*]] = load i32, i32* [[i]]
  ; CHECK: [[adri:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 [[ival]]
  ; CHECK: [[ldi:%.*]] = load <1 x float>, <1 x float>* [[adri]]
  ; CHECK: [[adr4:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 4
  ; CHECK: [[vali:%.*]] = extractelement <1 x float> [[ldi]], i64 0
  ; CHECK: store float [[vali]], float* [[adr4]]
  %tmp9 = load i32, i32* %tmp, align 4
  %tmp10 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 %tmp9
  %tmp11 = load <1 x float>, <1 x float>* %tmp10, align 4
  %tmp12 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 4
  store <1 x float> %tmp11, <1 x float>* %tmp12, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load <1 x float>, <1 x float>* [[adr2]]
  ; CHECK: [[adr5:%.*]] = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 5
  ; CHECK: [[val2:%.*]] = extractelement <1 x float> [[ld2]], i64 0
  ; CHECK: store float [[val2]], float* [[adr5]]
  %tmp13 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  %tmp14 = load <1 x float>, <1 x float>* %tmp13, align 4
  %tmp15 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %res, i32 0, i32 5
  store <1 x float> %tmp14, <1 x float>* %tmp15, align 4

  %tmp16 = bitcast [10 x <1 x float>]* %agg.result to i8*
  %tmp17 = bitcast [10 x <1 x float>]* %res to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %tmp16, i8* %tmp17, i64 40, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind
; CHECK-LABEL: define void @"\01?bittwiddlers
define void @"\01?bittwiddlers@@YAXY0L@$$CAI@Z"([11 x i32]* noalias %things) #0 {
bb:

  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 1
  ; CHECK: [[ld1:%.*]] = load i32, i32* [[adr1]], align 4
  ; CHECK: [[res0:%.*]] = xor i32 [[ld1]], -1
  ; CHECK: [[adr0:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 0
  ; CHECK: store i32 [[res0]], i32* [[adr0]], align 4
  %tmp = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 1
  %tmp1 = load i32, i32* %tmp, align 4
  %tmp2 = xor i32 %tmp1, -1
  %tmp3 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 0
  store i32 %tmp2, i32* %tmp3, align 4

  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 2
  ; CHECK: [[ld2:%.*]] = load i32, i32* [[adr2]], align 4
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load i32, i32* [[adr3]], align 4
  ; CHECK: [[res1:%.*]] = or i32 [[ld2]], [[ld3]]
  ; CHECK: [[adr1:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 1
  ; CHECK: store i32 [[res1]], i32* [[adr1]], align 4
  %tmp4 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 2
  %tmp5 = load i32, i32* %tmp4, align 4
  %tmp6 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  %tmp7 = load i32, i32* %tmp6, align 4
  %tmp8 = or i32 %tmp5, %tmp7
  %tmp9 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 1
  store i32 %tmp8, i32* %tmp9, align 4

  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  ; CHECK: [[ld3:%.*]] = load i32, i32* [[adr3]], align 4
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load i32, i32* [[adr4]], align 4
  ; CHECK: [[res2:%.*]] = and i32 [[ld3]], [[ld4]]
  ; CHECK: [[adr2:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 2
  ; CHECK: store i32 [[res2]], i32* [[adr2]], align 4
  %tmp10 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  %tmp11 = load i32, i32* %tmp10, align 4
  %tmp12 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  %tmp13 = load i32, i32* %tmp12, align 4
  %tmp14 = and i32 %tmp11, %tmp13
  %tmp15 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 2
  store i32 %tmp14, i32* %tmp15, align 4

  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  ; CHECK: [[ld4:%.*]] = load i32, i32* [[adr4]], align 4
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load i32, i32* [[adr5]], align 4
  ; CHECK: [[res3:%.*]] = xor i32 [[ld4]], [[ld5]]
  ; CHECK: [[adr3:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  ; CHECK: store i32 [[res3]], i32* [[adr3]], align 4
  %tmp16 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  %tmp17 = load i32, i32* %tmp16, align 4
  %tmp18 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  %tmp19 = load i32, i32* %tmp18, align 4
  %tmp20 = xor i32 %tmp17, %tmp19
  %tmp21 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 3
  store i32 %tmp20, i32* %tmp21, align 4

  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  ; CHECK: [[ld5:%.*]] = load i32, i32* [[adr5]], align 4
  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load i32, i32* [[adr6]], align 4
  ; CHECK: [[and4:%.*]] = and i32 [[ld6]], 31
  ; CHECK: [[res4:%.*]] = shl i32 [[ld5]], [[and4]]
  ; CHECK: [[adr4:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  ; CHECK: store i32 [[res4]], i32* [[adr4]], align 4
  %tmp22 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  %tmp23 = load i32, i32* %tmp22, align 4
  %tmp24 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  %tmp25 = load i32, i32* %tmp24, align 4
  %tmp26 = and i32 %tmp25, 31
  %tmp27 = shl i32 %tmp23, %tmp26
  %tmp28 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 4
  store i32 %tmp27, i32* %tmp28, align 4

  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load i32, i32* [[adr6]], align 4
  ; CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 7
  ; CHECK: [[ld7:%.*]] = load i32, i32* [[adr7]], align 4
  ; CHECK: [[and5:%.*]] = and i32 [[ld7]], 31
  ; CHECK: [[res5:%.*]] = lshr i32 [[ld6]], [[and5]]
  ; CHECK: [[adr5:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  ; CHECK: store i32 [[res5]], i32* [[adr5]], align 4
  %tmp29 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  %tmp30 = load i32, i32* %tmp29, align 4
  %tmp31 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 7
  %tmp32 = load i32, i32* %tmp31, align 4
  %tmp33 = and i32 %tmp32, 31
  %tmp34 = lshr i32 %tmp30, %tmp33
  %tmp35 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 5
  store i32 %tmp34, i32* %tmp35, align 4

  ; CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 8
  ; CHECK: [[ld8:%.*]] = load i32, i32* [[adr8]], align 4
  ; CHECK: [[adr6:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  ; CHECK: [[ld6:%.*]] = load i32, i32* [[adr6]], align 4
  ; CHECK: [[res6:%.*]] = or i32 [[ld6]], [[ld8]]
  ; CHECK: store i32 [[res6]], i32* [[adr6]], align 4
  %tmp36 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 8
  %tmp37 = load i32, i32* %tmp36, align 4
  %tmp38 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 6
  %tmp39 = load i32, i32* %tmp38, align 4
  %tmp40 = or i32 %tmp39, %tmp37
  store i32 %tmp40, i32* %tmp38, align 4

  ; CHECK: [[adr9:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 9
  ; CHECK: [[ld9:%.*]] = load i32, i32* [[adr9]], align 4
  ; CHECK: [[adr7:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 7
  ; CHECK: [[ld7:%.*]] = load i32, i32* [[adr7]], align 4
  ; CHECK: [[res7:%.*]] = and i32 [[ld7]], [[ld9]]
  ; CHECK: store i32 [[res7]], i32* [[adr7]], align 4
  %tmp41 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 9
  %tmp42 = load i32, i32* %tmp41, align 4
  %tmp43 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 7
  %tmp44 = load i32, i32* %tmp43, align 4
  %tmp45 = and i32 %tmp44, %tmp42
  store i32 %tmp45, i32* %tmp43, align 4

  ; CHECK: [[adr10:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 10
  ; CHECK: [[ld10:%.*]] = load i32, i32* [[adr10]], align 4
  ; CHECK: [[adr8:%.*]] = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 8
  ; CHECK: [[ld8:%.*]] = load i32, i32* [[adr8]], align 4
  ; CHECK: [[res8:%.*]] = xor i32 [[ld8]], [[ld10]]
  ; CHECK: store i32 [[res8]], i32* [[adr8]], align 4
  %tmp46 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 10
  %tmp47 = load i32, i32* %tmp46, align 4
  %tmp48 = getelementptr inbounds [11 x i32], [11 x i32]* %things, i32 0, i32 8
  %tmp49 = load i32, i32* %tmp48, align 4
  %tmp50 = xor i32 %tmp49, %tmp47
  store i32 %tmp50, i32* %tmp48, align 4

  ret void
}

; Function Attrs: nounwind readonly
declare <1 x float> @"dx.hl.op.ro.<1 x float> (i32, %dx.types.Handle, i32)"(i32, %dx.types.Handle, i32) #1

; Function Attrs: nounwind readnone
declare %dx.types.Handle @"dx.hl.createhandle..%dx.types.Handle (i32, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32, %"class.RWStructuredBuffer<vector<float, 1> >") #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @"dx.hl.annotatehandle..%dx.types.Handle (i32, %dx.types.Handle, %dx.types.ResourceProperties, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32, %dx.types.Handle, %dx.types.ResourceProperties, %"class.RWStructuredBuffer<vector<float, 1> >") #2

attributes #0 = { nounwind }
attributes #1 = { nounwind readonly }
attributes #2 = { nounwind readnone }

!dx.version = !{!3}
!dx.valver = !{!3}
!dx.shaderModel = !{!4}
!dx.typeAnnotations = !{!5, !11}
!dx.entryPoints = !{!31}
!dx.fnprops = !{}
!dx.options = !{!38, !39}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{!"hlsl-hlemit", !"hlsl-hlensure"}
!2 = !{!"dxc(private) 1.8.0.4807 (longvec_bab_ldst, 88cfe61c3-dirty)"}
!3 = !{i32 1, i32 9}
!4 = !{!"lib", i32 6, i32 9}
!5 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 1> >" undef, !6}
!6 = !{i32 4, !7, !8}
!7 = !{i32 6, !"h", i32 3, i32 0, i32 7, i32 9, i32 13, i32 1}
!8 = !{i32 0, !9}
!9 = !{!10}
!10 = !{i32 0, <1 x float> undef}
!11 = !{i32 1, void ([10 x <1 x float>]*)* @"\01?assignments@@YAXY09$$CAV?$vector@M$00@@@Z", !12, void ([11 x <1 x float>]*, [11 x <1 x float>]*)* @"\01?arithmetic@@YA$$BY0L@V?$vector@M$00@@Y0L@$$CAV1@@Z", !17, void ([10 x i32]*, [10 x i32]*, [10 x <1 x float>]*)* @"\01?logic@@YA$$BY09_NY09_NY09V?$vector@M$00@@@Z", !20, void ([10 x <1 x float>]*, [10 x <1 x float>]*, i32)* @"\01?index@@YA$$BY09V?$vector@M$00@@Y09V1@H@Z", !25, void ([11 x i32]*)* @"\01?bittwiddlers@@YAXY0L@$$CAI@Z", !28}
!12 = !{!13, !15}
!13 = !{i32 1, !14, !14}
!14 = !{}
!15 = !{i32 2, !16, !14}
!16 = !{i32 7, i32 9, i32 13, i32 1}
!17 = !{!18, !19, !15}
!18 = !{i32 0, !14, !14}
!19 = !{i32 1, !16, !14}
!20 = !{!18, !21, !23, !24}
!21 = !{i32 1, !22, !14}
!22 = !{i32 7, i32 1}
!23 = !{i32 0, !22, !14}
!24 = !{i32 0, !16, !14}
!25 = !{!18, !19, !24, !26}
!26 = !{i32 0, !27, !14}
!27 = !{i32 7, i32 4}
!28 = !{!13, !29}
!29 = !{i32 2, !30, !14}
!30 = !{i32 7, i32 5}
!31 = !{null, !"", null, !32, null}
!32 = !{null, !33, !36, null}
!33 = !{!34}
!34 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 1> >"* @"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A", !"buf", i32 -1, i32 -1, i32 1, i32 12, i1 false, i1 false, i1 false, !35}
!35 = !{i32 1, i32 4}
!36 = !{!37}
!37 = !{i32 0, %ConstantBuffer* @"$Globals", !"$Globals", i32 0, i32 -1, i32 1, i32 0, null}
!38 = !{i32 64}
!39 = !{i32 -1}
!40 = !{!41, !41, i64 0}
!41 = !{!"int", !42, i64 0}
!42 = !{!"omnipotent char", !43, i64 0}
!43 = !{!"Simple C/C++ TBAA"}
