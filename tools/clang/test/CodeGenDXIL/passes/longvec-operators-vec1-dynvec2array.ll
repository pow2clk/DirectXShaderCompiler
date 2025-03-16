; RUN: %dxopt %s -hlsl-passes-resume -dynamic-vector-to-array,ReplaceAllVectors=0 -S

target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%"class.RWStructuredBuffer<vector<float, 1> >" = type { <1 x float> }
%dx.types.Handle = type { i8* }
%dx.types.ResourceProperties = type { i32, i32 }

@"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A" = external global %"class.RWStructuredBuffer<vector<float, 1> >", align 4

; Function Attrs: nounwind
define void @"\01?assignments@@YAXY09$$CAV?$vector@M$00@@@Z"([10 x <1 x float>]* noalias %things) #0 {
bb:
  %tmp = load %"class.RWStructuredBuffer<vector<float, 1> >", %"class.RWStructuredBuffer<vector<float, 1> >"* @"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A"
  %tmp1 = call %dx.types.Handle @"dx.hl.createhandle..%dx.types.Handle (i32, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32 0, %"class.RWStructuredBuffer<vector<float, 1> >" %tmp)
  %tmp2 = call %dx.types.Handle @"dx.hl.annotatehandle..%dx.types.Handle (i32, %dx.types.Handle, %dx.types.ResourceProperties, %\22class.RWStructuredBuffer<vector<float, 1> >\22)"(i32 14, %dx.types.Handle %tmp1, %dx.types.ResourceProperties { i32 4108, i32 4 }, %"class.RWStructuredBuffer<vector<float, 1> >" undef)
  %tmp3 = call <1 x float> @"dx.hl.op.ro.<1 x float> (i32, %dx.types.Handle, i32)"(i32 231, %dx.types.Handle %tmp2, i32 1)
  %tmp4 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 0
  store <1 x float> %tmp3, <1 x float>* %tmp4, align 4
  %tmp5 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  %tmp6 = load <1 x float>, <1 x float>* %tmp5, align 4
  %tmp7 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 1
  %tmp8 = load <1 x float>, <1 x float>* %tmp7, align 4
  %tmp9 = fadd <1 x float> %tmp8, %tmp6
  store <1 x float> %tmp9, <1 x float>* %tmp7, align 4
  %tmp10 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 6
  %tmp11 = load <1 x float>, <1 x float>* %tmp10, align 4
  %tmp12 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  %tmp13 = load <1 x float>, <1 x float>* %tmp12, align 4
  %tmp14 = fsub <1 x float> %tmp13, %tmp11
  store <1 x float> %tmp14, <1 x float>* %tmp12, align 4
  %tmp15 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 7
  %tmp16 = load <1 x float>, <1 x float>* %tmp15, align 4
  %tmp17 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 3
  %tmp18 = load <1 x float>, <1 x float>* %tmp17, align 4
  %tmp19 = fmul <1 x float> %tmp18, %tmp16
  store <1 x float> %tmp19, <1 x float>* %tmp17, align 4
  %tmp20 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 8
  %tmp21 = load <1 x float>, <1 x float>* %tmp20, align 4
  %tmp22 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 4
  %tmp23 = load <1 x float>, <1 x float>* %tmp22, align 4
  %tmp24 = fdiv <1 x float> %tmp23, %tmp21
  store <1 x float> %tmp24, <1 x float>* %tmp22, align 4
  %tmp25 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 9
  %tmp26 = load <1 x float>, <1 x float>* %tmp25, align 4
  %tmp27 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 5
  %tmp28 = load <1 x float>, <1 x float>* %tmp27, align 4
  %tmp29 = frem <1 x float> %tmp28, %tmp26
  store <1 x float> %tmp29, <1 x float>* %tmp27, align 4
  ret void
}

; Function Attrs: nounwind
define void @"\01?arithmetic@@YA$$BY0L@V?$vector@M$00@@Y0L@$$CAV1@@Z"([11 x <1 x float>]* noalias sret %agg.result, [11 x <1 x float>]* noalias %things) #0 {
bb:
  %res.0 = alloca [11 x float]
  %tmp1 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  %tmp2 = load <1 x float>, <1 x float>* %tmp1, align 4
  %tmp3 = fsub <1 x float> <float -0.000000e+00>, %tmp2
  %tmp4 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 0
  %tmp5 = extractelement <1 x float> %tmp3, i64 0
  store float %tmp5, float* %tmp4
  %tmp6 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 0
  %tmp7 = load <1 x float>, <1 x float>* %tmp6, align 4
  %tmp8 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 1
  %tmp9 = extractelement <1 x float> %tmp7, i64 0
  store float %tmp9, float* %tmp8
  %tmp10 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 1
  %tmp11 = load <1 x float>, <1 x float>* %tmp10, align 4
  %tmp12 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  %tmp13 = load <1 x float>, <1 x float>* %tmp12, align 4
  %tmp14 = fadd <1 x float> %tmp11, %tmp13
  %tmp15 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 2
  %tmp16 = extractelement <1 x float> %tmp14, i64 0
  store float %tmp16, float* %tmp15
  %tmp17 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 2
  %tmp18 = load <1 x float>, <1 x float>* %tmp17, align 4
  %tmp19 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  %tmp20 = load <1 x float>, <1 x float>* %tmp19, align 4
  %tmp21 = fsub <1 x float> %tmp18, %tmp20
  %tmp22 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 3
  %tmp23 = extractelement <1 x float> %tmp21, i64 0
  store float %tmp23, float* %tmp22
  %tmp24 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 3
  %tmp25 = load <1 x float>, <1 x float>* %tmp24, align 4
  %tmp26 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  %tmp27 = load <1 x float>, <1 x float>* %tmp26, align 4
  %tmp28 = fmul <1 x float> %tmp25, %tmp27
  %tmp29 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 4
  %tmp30 = extractelement <1 x float> %tmp28, i64 0
  store float %tmp30, float* %tmp29
  %tmp31 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 4
  %tmp32 = load <1 x float>, <1 x float>* %tmp31, align 4
  %tmp33 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  %tmp34 = load <1 x float>, <1 x float>* %tmp33, align 4
  %tmp35 = fdiv <1 x float> %tmp32, %tmp34
  %tmp36 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 5
  %tmp37 = extractelement <1 x float> %tmp35, i64 0
  store float %tmp37, float* %tmp36
  %tmp38 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 5
  %tmp39 = load <1 x float>, <1 x float>* %tmp38, align 4
  %tmp40 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 6
  %tmp41 = load <1 x float>, <1 x float>* %tmp40, align 4
  %tmp42 = frem <1 x float> %tmp39, %tmp41
  %tmp43 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 6
  %tmp44 = extractelement <1 x float> %tmp42, i64 0
  store float %tmp44, float* %tmp43
  %tmp45 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 7
  %tmp46 = load <1 x float>, <1 x float>* %tmp45, align 4
  %tmp47 = fadd <1 x float> %tmp46, <float 1.000000e+00>
  store <1 x float> %tmp47, <1 x float>* %tmp45, align 4
  %tmp48 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 7
  %tmp49 = extractelement <1 x float> %tmp46, i64 0
  store float %tmp49, float* %tmp48
  %tmp50 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 8
  %tmp51 = load <1 x float>, <1 x float>* %tmp50, align 4
  %tmp52 = fadd <1 x float> %tmp51, <float -1.000000e+00>
  store <1 x float> %tmp52, <1 x float>* %tmp50, align 4
  %tmp53 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 8
  %tmp54 = extractelement <1 x float> %tmp51, i64 0
  store float %tmp54, float* %tmp53
  %tmp55 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 9
  %tmp56 = load <1 x float>, <1 x float>* %tmp55, align 4
  %tmp57 = fadd <1 x float> %tmp56, <float 1.000000e+00>
  store <1 x float> %tmp57, <1 x float>* %tmp55, align 4
  %tmp58 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 9
  %tmp59 = extractelement <1 x float> %tmp57, i64 0
  store float %tmp59, float* %tmp58
  %tmp60 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %things, i32 0, i32 10
  %tmp61 = load <1 x float>, <1 x float>* %tmp60, align 4
  %tmp62 = fadd <1 x float> %tmp61, <float -1.000000e+00>
  store <1 x float> %tmp62, <1 x float>* %tmp60, align 4
  %tmp63 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 10
  %tmp64 = extractelement <1 x float> %tmp62, i64 0
  store float %tmp64, float* %tmp63
  %tmp65 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 0
  %tmp66 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 0
  %load19 = load float, float* %tmp66
  %insert20 = insertelement <1 x float> undef, float %load19, i64 0
  store <1 x float> %insert20, <1 x float>* %tmp65
  %tmp67 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 1
  %tmp68 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 1
  %load17 = load float, float* %tmp68
  %insert18 = insertelement <1 x float> undef, float %load17, i64 0
  store <1 x float> %insert18, <1 x float>* %tmp67
  %tmp69 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 2
  %tmp70 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 2
  %load15 = load float, float* %tmp70
  %insert16 = insertelement <1 x float> undef, float %load15, i64 0
  store <1 x float> %insert16, <1 x float>* %tmp69
  %tmp71 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 3
  %tmp72 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 3
  %load13 = load float, float* %tmp72
  %insert14 = insertelement <1 x float> undef, float %load13, i64 0
  store <1 x float> %insert14, <1 x float>* %tmp71
  %tmp73 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 4
  %tmp74 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 4
  %load11 = load float, float* %tmp74
  %insert12 = insertelement <1 x float> undef, float %load11, i64 0
  store <1 x float> %insert12, <1 x float>* %tmp73
  %tmp75 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 5
  %tmp76 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 5
  %load9 = load float, float* %tmp76
  %insert10 = insertelement <1 x float> undef, float %load9, i64 0
  store <1 x float> %insert10, <1 x float>* %tmp75
  %tmp77 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 6
  %tmp78 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 6
  %load7 = load float, float* %tmp78
  %insert8 = insertelement <1 x float> undef, float %load7, i64 0
  store <1 x float> %insert8, <1 x float>* %tmp77
  %tmp79 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 7
  %tmp80 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 7
  %load5 = load float, float* %tmp80
  %insert6 = insertelement <1 x float> undef, float %load5, i64 0
  store <1 x float> %insert6, <1 x float>* %tmp79
  %tmp81 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 8
  %tmp82 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 8
  %load3 = load float, float* %tmp82
  %insert4 = insertelement <1 x float> undef, float %load3, i64 0
  store <1 x float> %insert4, <1 x float>* %tmp81
  %tmp83 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 9
  %tmp84 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 9
  %load1 = load float, float* %tmp84
  %insert2 = insertelement <1 x float> undef, float %load1, i64 0
  store <1 x float> %insert2, <1 x float>* %tmp83
  %tmp85 = getelementptr inbounds [11 x <1 x float>], [11 x <1 x float>]* %agg.result, i32 0, i32 10
  %tmp86 = getelementptr [11 x float], [11 x float]* %res.0, i32 0, i32 10
  %load = load float, float* %tmp86
  %insert = insertelement <1 x float> undef, float %load, i64 0
  store <1 x float> %insert, <1 x float>* %tmp85
  ret void
}

; Function Attrs: nounwind
define void @"\01?logic@@YA$$BY09_NY09_NY09V?$vector@M$00@@@Z"([10 x i32]* noalias sret %agg.result, [10 x i32]* %truth, [10 x <1 x float>]* %consequences) #0 {
bb:
  %res = alloca [10 x i32], align 4
  %tmp1 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 0
  %tmp2 = load i32, i32* %tmp1, align 4
  %tmp3 = icmp ne i32 %tmp2, 0
  %tmp4 = xor i1 %tmp3, true
  %tmp5 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 0
  %tmp6 = zext i1 %tmp4 to i32
  store i32 %tmp6, i32* %tmp5, align 4
  %tmp7 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 1
  %tmp8 = load i32, i32* %tmp7, align 4
  %tmp9 = icmp ne i32 %tmp8, 0
  br i1 %tmp9, label %bb14, label %bb10

bb10:                                             ; preds = %bb
  %tmp11 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  %tmp12 = load i32, i32* %tmp11, align 4
  %tmp13 = icmp ne i32 %tmp12, 0
  br label %bb14

bb14:                                             ; preds = %bb10, %bb
  %tmp15 = phi i1 [ true, %bb ], [ %tmp13, %bb10 ]
  %tmp16 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 1
  %tmp17 = zext i1 %tmp15 to i32
  store i32 %tmp17, i32* %tmp16, align 4
  %tmp18 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 2
  %tmp19 = load i32, i32* %tmp18, align 4
  %tmp20 = icmp ne i32 %tmp19, 0
  br i1 %tmp20, label %bb21, label %bb25

bb21:                                             ; preds = %bb14
  %tmp22 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  %tmp23 = load i32, i32* %tmp22, align 4
  %tmp24 = icmp ne i32 %tmp23, 0
  br label %bb25

bb25:                                             ; preds = %bb21, %bb14
  %tmp26 = phi i1 [ false, %bb14 ], [ %tmp24, %bb21 ]
  %tmp27 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 2
  %tmp28 = zext i1 %tmp26 to i32
  store i32 %tmp28, i32* %tmp27, align 4
  %tmp29 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 3
  %tmp30 = load i32, i32* %tmp29, align 4
  %tmp31 = icmp ne i32 %tmp30, 0
  br i1 %tmp31, label %bb32, label %bb35

bb32:                                             ; preds = %bb25
  %tmp33 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 4
  %tmp34 = load i32, i32* %tmp33, align 4
  br label %bb38

bb35:                                             ; preds = %bb25
  %tmp36 = getelementptr inbounds [10 x i32], [10 x i32]* %truth, i32 0, i32 5
  %tmp37 = load i32, i32* %tmp36, align 4
  br label %bb38

bb38:                                             ; preds = %bb35, %bb32
  %.sink = phi i32 [ %tmp34, %bb32 ], [ %tmp37, %bb35 ]
  %tmp39 = icmp ne i32 %.sink, 0
  %tmp40 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 3
  %tmp41 = zext i1 %tmp39 to i32
  store i32 %tmp41, i32* %tmp40, align 4
  %tmp42 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 0
  %tmp43 = load <1 x float>, <1 x float>* %tmp42, align 4
  %tmp44 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  %tmp45 = load <1 x float>, <1 x float>* %tmp44, align 4
  %tmp46 = fcmp oeq <1 x float> %tmp43, %tmp45
  %tmp47 = extractelement <1 x i1> %tmp46, i64 0
  %tmp48 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 4
  %tmp49 = zext i1 %tmp47 to i32
  store i32 %tmp49, i32* %tmp48, align 4
  %tmp50 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 1
  %tmp51 = load <1 x float>, <1 x float>* %tmp50, align 4
  %tmp52 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  %tmp53 = load <1 x float>, <1 x float>* %tmp52, align 4
  %tmp54 = fcmp une <1 x float> %tmp51, %tmp53
  %tmp55 = extractelement <1 x i1> %tmp54, i64 0
  %tmp56 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 5
  %tmp57 = zext i1 %tmp55 to i32
  store i32 %tmp57, i32* %tmp56, align 4
  %tmp58 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 2
  %tmp59 = load <1 x float>, <1 x float>* %tmp58, align 4
  %tmp60 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  %tmp61 = load <1 x float>, <1 x float>* %tmp60, align 4
  %tmp62 = fcmp olt <1 x float> %tmp59, %tmp61
  %tmp63 = extractelement <1 x i1> %tmp62, i64 0
  %tmp64 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 6
  %tmp65 = zext i1 %tmp63 to i32
  store i32 %tmp65, i32* %tmp64, align 4
  %tmp66 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 3
  %tmp67 = load <1 x float>, <1 x float>* %tmp66, align 4
  %tmp68 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  %tmp69 = load <1 x float>, <1 x float>* %tmp68, align 4
  %tmp70 = fcmp ogt <1 x float> %tmp67, %tmp69
  %tmp71 = extractelement <1 x i1> %tmp70, i64 0
  %tmp72 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 7
  %tmp73 = zext i1 %tmp71 to i32
  store i32 %tmp73, i32* %tmp72, align 4
  %tmp74 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 4
  %tmp75 = load <1 x float>, <1 x float>* %tmp74, align 4
  %tmp76 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  %tmp77 = load <1 x float>, <1 x float>* %tmp76, align 4
  %tmp78 = fcmp ole <1 x float> %tmp75, %tmp77
  %tmp79 = extractelement <1 x i1> %tmp78, i64 0
  %tmp80 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 8
  %tmp81 = zext i1 %tmp79 to i32
  store i32 %tmp81, i32* %tmp80, align 4
  %tmp82 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 5
  %tmp83 = load <1 x float>, <1 x float>* %tmp82, align 4
  %tmp84 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %consequences, i32 0, i32 6
  %tmp85 = load <1 x float>, <1 x float>* %tmp84, align 4
  %tmp86 = fcmp oge <1 x float> %tmp83, %tmp85
  %tmp87 = extractelement <1 x i1> %tmp86, i64 0
  %tmp88 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 9
  %tmp89 = zext i1 %tmp87 to i32
  store i32 %tmp89, i32* %tmp88, align 4
  %tmp90 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 0
  %tmp91 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 0
  %tmp92 = load i32, i32* %tmp91
  store i32 %tmp92, i32* %tmp90
  %tmp93 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 1
  %tmp94 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 1
  %tmp95 = load i32, i32* %tmp94
  store i32 %tmp95, i32* %tmp93
  %tmp96 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 2
  %tmp97 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 2
  %tmp98 = load i32, i32* %tmp97
  store i32 %tmp98, i32* %tmp96
  %tmp99 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 3
  %tmp100 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 3
  %tmp101 = load i32, i32* %tmp100
  store i32 %tmp101, i32* %tmp99
  %tmp102 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 4
  %tmp103 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 4
  %tmp104 = load i32, i32* %tmp103
  store i32 %tmp104, i32* %tmp102
  %tmp105 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 5
  %tmp106 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 5
  %tmp107 = load i32, i32* %tmp106
  store i32 %tmp107, i32* %tmp105
  %tmp108 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 6
  %tmp109 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 6
  %tmp110 = load i32, i32* %tmp109
  store i32 %tmp110, i32* %tmp108
  %tmp111 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 7
  %tmp112 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 7
  %tmp113 = load i32, i32* %tmp112
  store i32 %tmp113, i32* %tmp111
  %tmp114 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 8
  %tmp115 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 8
  %tmp116 = load i32, i32* %tmp115
  store i32 %tmp116, i32* %tmp114
  %tmp117 = getelementptr inbounds [10 x i32], [10 x i32]* %agg.result, i32 0, i32 9
  %tmp118 = getelementptr inbounds [10 x i32], [10 x i32]* %res, i32 0, i32 9
  %tmp119 = load i32, i32* %tmp118
  store i32 %tmp119, i32* %tmp117
  ret void
}

; Function Attrs: nounwind
define void @"\01?index@@YA$$BY09V?$vector@M$00@@Y09V1@H@Z"([10 x <1 x float>]* noalias sret %agg.result, [10 x <1 x float>]* %things, i32 %i) #0 {
bb:
  %res.0 = alloca [10 x float]
  %tmp = alloca i32, align 4, !dx.temp !11
  store i32 %i, i32* %tmp, align 4, !tbaa !32
  %tmp2 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 0
  store float 0.000000e+00, float* %tmp2
  %tmp3 = load i32, i32* %tmp, align 4
  %tmp4 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 %tmp3
  store float 1.000000e+00, float* %tmp4
  %tmp5 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 2
  store float 2.000000e+00, float* %tmp5
  %tmp6 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 0
  %tmp7 = load <1 x float>, <1 x float>* %tmp6, align 4
  %tmp8 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 3
  %tmp9 = extractelement <1 x float> %tmp7, i64 0
  store float %tmp9, float* %tmp8
  %tmp10 = load i32, i32* %tmp, align 4
  %tmp11 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 %tmp10
  %tmp12 = load <1 x float>, <1 x float>* %tmp11, align 4
  %tmp13 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 4
  %tmp14 = extractelement <1 x float> %tmp12, i64 0
  store float %tmp14, float* %tmp13
  %tmp15 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %things, i32 0, i32 2
  %tmp16 = load <1 x float>, <1 x float>* %tmp15, align 4
  %tmp17 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 5
  %tmp18 = extractelement <1 x float> %tmp16, i64 0
  store float %tmp18, float* %tmp17
  %tmp19 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 0
  %tmp20 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 0
  %load17 = load float, float* %tmp20
  %insert18 = insertelement <1 x float> undef, float %load17, i64 0
  store <1 x float> %insert18, <1 x float>* %tmp19
  %tmp21 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 1
  %tmp22 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 1
  %load15 = load float, float* %tmp22
  %insert16 = insertelement <1 x float> undef, float %load15, i64 0
  store <1 x float> %insert16, <1 x float>* %tmp21
  %tmp23 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 2
  %tmp24 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 2
  %load13 = load float, float* %tmp24
  %insert14 = insertelement <1 x float> undef, float %load13, i64 0
  store <1 x float> %insert14, <1 x float>* %tmp23
  %tmp25 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 3
  %tmp26 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 3
  %load11 = load float, float* %tmp26
  %insert12 = insertelement <1 x float> undef, float %load11, i64 0
  store <1 x float> %insert12, <1 x float>* %tmp25
  %tmp27 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 4
  %tmp28 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 4
  %load9 = load float, float* %tmp28
  %insert10 = insertelement <1 x float> undef, float %load9, i64 0
  store <1 x float> %insert10, <1 x float>* %tmp27
  %tmp29 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 5
  %tmp30 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 5
  %load7 = load float, float* %tmp30
  %insert8 = insertelement <1 x float> undef, float %load7, i64 0
  store <1 x float> %insert8, <1 x float>* %tmp29
  %tmp31 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 6
  %tmp32 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 6
  %load5 = load float, float* %tmp32
  %insert6 = insertelement <1 x float> undef, float %load5, i64 0
  store <1 x float> %insert6, <1 x float>* %tmp31
  %tmp33 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 7
  %tmp34 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 7
  %load3 = load float, float* %tmp34
  %insert4 = insertelement <1 x float> undef, float %load3, i64 0
  store <1 x float> %insert4, <1 x float>* %tmp33
  %tmp35 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 8
  %tmp36 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 8
  %load1 = load float, float* %tmp36
  %insert2 = insertelement <1 x float> undef, float %load1, i64 0
  store <1 x float> %insert2, <1 x float>* %tmp35
  %tmp37 = getelementptr inbounds [10 x <1 x float>], [10 x <1 x float>]* %agg.result, i32 0, i32 9
  %tmp38 = getelementptr [10 x float], [10 x float]* %res.0, i32 0, i32 9
  %load = load float, float* %tmp38
  %insert = insertelement <1 x float> undef, float %load, i64 0
  store <1 x float> %insert, <1 x float>* %tmp37
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

!dx.version = !{!0}
!dx.valver = !{!0}
!dx.shaderModel = !{!1}
!dx.typeAnnotations = !{!2, !8}
!dx.entryPoints = !{!25}
!dx.fnprops = !{}
!dx.options = !{!30, !31}

!0 = !{i32 1, i32 9}
!1 = !{!"lib", i32 6, i32 9}
!2 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 1> >" undef, !3}
!3 = !{i32 4, !4, !5}
!4 = !{i32 6, !"h", i32 3, i32 0, i32 7, i32 9, i32 13, i32 1}
!5 = !{i32 0, !6}
!6 = !{!7}
!7 = !{i32 0, <1 x float> undef}
!8 = !{i32 1, void ([10 x <1 x float>]*)* @"\01?assignments@@YAXY09$$CAV?$vector@M$00@@@Z", !9, void ([11 x <1 x float>]*, [11 x <1 x float>]*)* @"\01?arithmetic@@YA$$BY0L@V?$vector@M$00@@Y0L@$$CAV1@@Z", !14, void ([10 x i32]*, [10 x i32]*, [10 x <1 x float>]*)* @"\01?logic@@YA$$BY09_NY09_NY09V?$vector@M$00@@@Z", !17, void ([10 x <1 x float>]*, [10 x <1 x float>]*, i32)* @"\01?index@@YA$$BY09V?$vector@M$00@@Y09V1@H@Z", !22}
!9 = !{!10, !12}
!10 = !{i32 1, !11, !11}
!11 = !{}
!12 = !{i32 2, !13, !11}
!13 = !{i32 7, i32 9, i32 13, i32 1}
!14 = !{!15, !16, !12}
!15 = !{i32 0, !11, !11}
!16 = !{i32 1, !13, !11}
!17 = !{!15, !18, !20, !21}
!18 = !{i32 1, !19, !11}
!19 = !{i32 7, i32 1}
!20 = !{i32 0, !19, !11}
!21 = !{i32 0, !13, !11}
!22 = !{!15, !16, !21, !23}
!23 = !{i32 0, !24, !11}
!24 = !{i32 7, i32 4}
!25 = !{null, !"", null, !26, null}
!26 = !{null, !27, null, null}
!27 = !{!28}
!28 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 1> >"* @"\01?buf@@3V?$RWStructuredBuffer@V?$vector@M$00@@@@A", !"buf", i32 -1, i32 -1, i32 1, i32 12, i1 false, i1 false, i1 false, !29}
!29 = !{i32 1, i32 4}
!30 = !{i32 64}
!31 = !{i32 -1}
!32 = !{!33, !33, i64 0}
!33 = !{!"int", !34, i64 0}
!34 = !{!"omnipotent char", !35, i64 0}
!35 = !{!"Simple C/C++ TBAA"}
