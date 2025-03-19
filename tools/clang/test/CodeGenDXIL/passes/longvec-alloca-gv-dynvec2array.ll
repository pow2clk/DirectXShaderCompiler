; ModuleID = '/home/grroth/dxc/numdynvec.ll'
target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%struct.VectRec1 = type { <1 x float> }
%struct.VectRec2 = type { <2 x float> }

; Vec2s should be preserved.
; CHECK-DAG: @dyglob2 = internal global <2 x float> zeroinitializer, align 4
; CHECK-DAG: @dygar2 = internal global [3 x <2 x float>] zeroinitializer, align 4
; CHECK-DAG: @dygrec2.0 = internal global <2 x float> zeroinitializer, align 4

; CHECK-DAG: @stgrec2.0 = internal global <2 x float> zeroinitializer, align 4
; CHECK-DAG: @stglob2 = internal global <2 x float> zeroinitializer, align 4
; CHECK-DAG: @stgar2 = internal global [3 x <2 x float>] zeroinitializer, align 4

; Dynamic Vec1s should be reduced.
; CHECK-DAG: @dygar1.v = internal global [2 x [1 x float]] zeroinitializer, align 4
; CHECK-DAG: @dygrec1.0.v = internal global [1 x float] zeroinitializer, align 4
; CHECK-DAG: @dyglob1.v = internal global [1 x float] zeroinitializer, align 4

; These static accessed Vec1s were already reduced by SROA
; CHECK-DAG: @stgar1.0 = internal global [2 x float] zeroinitializer, align 4
; CHECK-DAG: @stglob1.0 = internal global float 0.000000e+00, align 4
; CHECK-DAG: @stgrec1.0.0 = internal global float 0.000000e+00, align 4

@dyglob1 = internal global <1 x float> zeroinitializer, align 4
@dyglob2 = internal global <2 x float> zeroinitializer, align 4
@stglob2 = internal global <2 x float> zeroinitializer, align 4
@dygar1 = internal global [2 x <1 x float>] zeroinitializer, align 4
@dygar2 = internal global [3 x <2 x float>] zeroinitializer, align 4
@stgar2 = internal global [3 x <2 x float>] zeroinitializer, align 4
@dygrec2.0 = internal global <2 x float> zeroinitializer, align 4
@stgrec2.0 = internal global <2 x float> zeroinitializer, align 4
@stgar1.0 = internal global [2 x float] zeroinitializer, align 4
@dygrec1.0 = internal global <1 x float> zeroinitializer, align 4
@stglob1.0 = internal global float 0.000000e+00, align 4
@stgrec1.0.0 = internal global float 0.000000e+00, align 4

; Function Attrs: nounwind
define <4 x float> @"\01?tester@@YA?AV?$vector@M$03@@HY0M@M@Z"(i32 %ix, [12 x float]* %vals) #0 {
bb:
  %dylorc1.0 = alloca <1 x float>
  %stlorc1.0 = alloca <1 x float>
  %dylorc2.0 = alloca <2 x float>
  %stlorc2.0 = alloca <2 x float>
  %stlar1.0 = alloca [3 x float]
  %tmp = alloca i32, align 4, !dx.temp !14
  %dyloc1 = alloca <1 x float>, align 4
  %dyloc2 = alloca <2 x float>, align 4
  %dylar1 = alloca [3 x <1 x float>], align 4
  %dylar2 = alloca [4 x <2 x float>], align 4
  %stloc1 = alloca <1 x float>, align 4
  %stloc2 = alloca <2 x float>, align 4
  %stlar2 = alloca [4 x <2 x float>], align 4
  store i32 %ix, i32* %tmp, align 4, !tbaa !22
  %tmp1 = bitcast <1 x float>* %dyloc1 to i8*, !dbg !26 ; line:39 col:3
  call void @llvm.lifetime.start(i64 4, i8* %tmp1) #0, !dbg !26 ; line:39 col:3
  %tmp2 = bitcast <2 x float>* %dyloc2 to i8*, !dbg !30 ; line:40 col:3
  call void @llvm.lifetime.start(i64 8, i8* %tmp2) #0, !dbg !30 ; line:40 col:3
  %tmp3 = bitcast [3 x <1 x float>]* %dylar1 to i8*, !dbg !31 ; line:41 col:3
  call void @llvm.lifetime.start(i64 12, i8* %tmp3) #0, !dbg !31 ; line:41 col:3
  %tmp4 = bitcast [4 x <2 x float>]* %dylar2 to i8*, !dbg !32 ; line:42 col:3
  call void @llvm.lifetime.start(i64 32, i8* %tmp4) #0, !dbg !32 ; line:42 col:3
  %tmp5 = bitcast <1 x float>* %dylorc1.0 to i8*, !dbg !33 ; line:43 col:3
  call void @llvm.lifetime.start(i64 4, i8* %tmp5) #0, !dbg !33 ; line:43 col:3
  %tmp6 = bitcast <2 x float>* %dylorc2.0 to i8*, !dbg !34 ; line:44 col:3
  call void @llvm.lifetime.start(i64 8, i8* %tmp6) #0, !dbg !34 ; line:44 col:3
  %tmp7 = bitcast <1 x float>* %stloc1 to i8*, !dbg !35 ; line:46 col:3
  call void @llvm.lifetime.start(i64 4, i8* %tmp7) #0, !dbg !35 ; line:46 col:3
  %tmp8 = bitcast <2 x float>* %stloc2 to i8*, !dbg !36 ; line:47 col:3
  call void @llvm.lifetime.start(i64 8, i8* %tmp8) #0, !dbg !36 ; line:47 col:3
  %tmp9 = bitcast [3 x float]* %stlar1.0 to i8*, !dbg !37 ; line:48 col:3
  call void @llvm.lifetime.start(i64 12, i8* %tmp9) #0, !dbg !37 ; line:48 col:3
  %tmp10 = bitcast [4 x <2 x float>]* %stlar2 to i8*, !dbg !38 ; line:49 col:3
  call void @llvm.lifetime.start(i64 32, i8* %tmp10) #0, !dbg !38 ; line:49 col:3
  %tmp11 = bitcast <1 x float>* %stlorc1.0 to i8*, !dbg !39 ; line:50 col:3
  call void @llvm.lifetime.start(i64 4, i8* %tmp11) #0, !dbg !39 ; line:50 col:3
  %tmp12 = bitcast <2 x float>* %stlorc2.0 to i8*, !dbg !40 ; line:51 col:3
  call void @llvm.lifetime.start(i64 8, i8* %tmp12) #0, !dbg !40 ; line:51 col:3
  %tmp13 = load i32, i32* %tmp, align 4, !dbg !41, !tbaa !22 ; line:53 col:7
  %tmp14 = icmp sgt i32 %tmp13, 0, !dbg !42 ; line:53 col:10
  %tmp15 = icmp ne i1 %tmp14, false, !dbg !42 ; line:53 col:10
  %tmp16 = icmp ne i1 %tmp15, false, !dbg !42 ; line:53 col:10
  br i1 %tmp16, label %bb17, label %bb76, !dbg !41 ; line:53 col:7

bb17:                                             ; preds = %bb
  %tmp18 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 0, !dbg !43 ; line:54 col:30
  %tmp19 = load float, float* %tmp18, align 4, !dbg !43, !tbaa !44 ; line:54 col:30
  %tmp20 = load i32, i32* %tmp, align 4, !dbg !46, !tbaa !22 ; line:54 col:24
  %tmp21 = getelementptr <1 x float>, <1 x float>* %dyloc1, i32 0, i32 %tmp20, !dbg !47 ; line:54 col:17
  store float %tmp19, float* %tmp21, !dbg !48, !tbaa !44 ; line:54 col:28
  %tmp22 = getelementptr <1 x float>, <1 x float>* %stloc1, i32 0, i32 0, !dbg !49 ; line:54 col:5
  store float %tmp19, float* %tmp22, !dbg !50, !tbaa !44 ; line:54 col:15
  %tmp23 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 1, !dbg !51 ; line:55 col:30
  %tmp24 = load float, float* %tmp23, align 4, !dbg !51, !tbaa !44 ; line:55 col:30
  %tmp25 = load i32, i32* %tmp, align 4, !dbg !52, !tbaa !22 ; line:55 col:24
  %tmp26 = getelementptr <2 x float>, <2 x float>* %dyloc2, i32 0, i32 %tmp25, !dbg !53 ; line:55 col:17
  store float %tmp24, float* %tmp26, !dbg !54, !tbaa !44 ; line:55 col:28
  %tmp27 = getelementptr <2 x float>, <2 x float>* %stloc2, i32 0, i32 1, !dbg !55 ; line:55 col:5
  store float %tmp24, float* %tmp27, !dbg !56, !tbaa !44 ; line:55 col:15
  %tmp28 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 2, !dbg !57 ; line:56 col:37
  %tmp29 = load float, float* %tmp28, align 4, !dbg !57, !tbaa !44 ; line:56 col:37
  %tmp30 = load i32, i32* %tmp, align 4, !dbg !58, !tbaa !22 ; line:56 col:27
  %tmp31 = load i32, i32* %tmp, align 4, !dbg !59, !tbaa !22 ; line:56 col:31
  %tmp32 = getelementptr inbounds [3 x <1 x float>], [3 x <1 x float>]* %dylar1, i32 0, i32 %tmp30, i32 %tmp31, !dbg !60 ; line:56 col:20
  store float %tmp29, float* %tmp32, !dbg !61, !tbaa !44 ; line:56 col:35
  %tmp33 = getelementptr inbounds [3 x float], [3 x float]* %stlar1.0, i32 0, i32 1, !dbg !62 ; line:56 col:5
  store float %tmp29, float* %tmp33, !dbg !63, !tbaa !44 ; line:56 col:18
  %tmp34 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 3, !dbg !64 ; line:57 col:37
  %tmp35 = load float, float* %tmp34, align 4, !dbg !64, !tbaa !44 ; line:57 col:37
  %tmp36 = load i32, i32* %tmp, align 4, !dbg !65, !tbaa !22 ; line:57 col:27
  %tmp37 = load i32, i32* %tmp, align 4, !dbg !66, !tbaa !22 ; line:57 col:31
  %tmp38 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %dylar2, i32 0, i32 %tmp36, i32 %tmp37, !dbg !67 ; line:57 col:20
  store float %tmp35, float* %tmp38, !dbg !68, !tbaa !44 ; line:57 col:35
  %tmp39 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %stlar2, i32 0, i32 1, i32 0, !dbg !69 ; line:57 col:5
  store float %tmp35, float* %tmp39, !dbg !70, !tbaa !44 ; line:57 col:18
  %tmp40 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 4, !dbg !71 ; line:58 col:36
  %tmp41 = load float, float* %tmp40, align 4, !dbg !71, !tbaa !44 ; line:58 col:36
  %tmp42 = load i32, i32* %tmp, align 4, !dbg !72, !tbaa !22 ; line:58 col:30
  %tmp43 = getelementptr inbounds <1 x float>, <1 x float>* %dylorc1.0, i32 0, i32 %tmp42, !dbg !73 ; line:58 col:20
  store float %tmp41, float* %tmp43, !dbg !74, !tbaa !44 ; line:58 col:34
  %tmp44 = getelementptr inbounds <1 x float>, <1 x float>* %stlorc1.0, i32 0, i32 0, !dbg !75 ; line:58 col:5
  store float %tmp41, float* %tmp44, !dbg !76, !tbaa !44 ; line:58 col:18
  %tmp45 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 5, !dbg !77 ; line:59 col:36
  %tmp46 = load float, float* %tmp45, align 4, !dbg !77, !tbaa !44 ; line:59 col:36
  %tmp47 = load i32, i32* %tmp, align 4, !dbg !78, !tbaa !22 ; line:59 col:30
  %tmp48 = getelementptr inbounds <2 x float>, <2 x float>* %dylorc2.0, i32 0, i32 %tmp47, !dbg !79 ; line:59 col:20
  store float %tmp46, float* %tmp48, !dbg !80, !tbaa !44 ; line:59 col:34
  %tmp49 = getelementptr inbounds <2 x float>, <2 x float>* %stlorc2.0, i32 0, i32 1, !dbg !81 ; line:59 col:5
  store float %tmp46, float* %tmp49, !dbg !82, !tbaa !44 ; line:59 col:18
  %tmp50 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 6, !dbg !83 ; line:61 col:32
  %tmp51 = load float, float* %tmp50, align 4, !dbg !83, !tbaa !44 ; line:61 col:32
  %tmp52 = load i32, i32* %tmp, align 4, !dbg !84, !tbaa !22 ; line:61 col:26
  %tmp53 = getelementptr <1 x float>, <1 x float>* @dyglob1, i32 0, i32 %tmp52, !dbg !85 ; line:61 col:18
  store float %tmp51, float* %tmp53, !dbg !86, !tbaa !44 ; line:61 col:30
  store float %tmp51, float* @stglob1.0, !dbg !87, !tbaa !44 ; line:61 col:16
  %tmp54 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 7, !dbg !88 ; line:62 col:32
  %tmp55 = load float, float* %tmp54, align 4, !dbg !88, !tbaa !44 ; line:62 col:32
  %tmp56 = load i32, i32* %tmp, align 4, !dbg !89, !tbaa !22 ; line:62 col:26
  %tmp57 = getelementptr <2 x float>, <2 x float>* @dyglob2, i32 0, i32 %tmp56, !dbg !90 ; line:62 col:18
  store float %tmp55, float* %tmp57, !dbg !91, !tbaa !44 ; line:62 col:30
  store float %tmp55, float* getelementptr inbounds (<2 x float>, <2 x float>* @stglob2, i32 0, i32 1), !dbg !92, !tbaa !44 ; line:62 col:16
  %tmp58 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 8, !dbg !93 ; line:63 col:37
  %tmp59 = load float, float* %tmp58, align 4, !dbg !93, !tbaa !44 ; line:63 col:37
  %tmp60 = load i32, i32* %tmp, align 4, !dbg !94, !tbaa !22 ; line:63 col:27
  %tmp61 = load i32, i32* %tmp, align 4, !dbg !95, !tbaa !22 ; line:63 col:31
  %tmp62 = getelementptr inbounds [2 x <1 x float>], [2 x <1 x float>]* @dygar1, i32 0, i32 %tmp60, i32 %tmp61, !dbg !96 ; line:63 col:20
  store float %tmp59, float* %tmp62, !dbg !97, !tbaa !44 ; line:63 col:35
  store float %tmp59, float* getelementptr inbounds ([2 x float], [2 x float]* @stgar1.0, i32 0, i32 1), !dbg !98, !tbaa !44 ; line:63 col:18
  %tmp63 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 9, !dbg !99 ; line:64 col:37
  %tmp64 = load float, float* %tmp63, align 4, !dbg !99, !tbaa !44 ; line:64 col:37
  %tmp65 = load i32, i32* %tmp, align 4, !dbg !100, !tbaa !22 ; line:64 col:27
  %tmp66 = load i32, i32* %tmp, align 4, !dbg !101, !tbaa !22 ; line:64 col:31
  %tmp67 = getelementptr inbounds [3 x <2 x float>], [3 x <2 x float>]* @dygar2, i32 0, i32 %tmp65, i32 %tmp66, !dbg !102 ; line:64 col:20
  store float %tmp64, float* %tmp67, !dbg !103, !tbaa !44 ; line:64 col:35
  store float %tmp64, float* getelementptr inbounds ([3 x <2 x float>], [3 x <2 x float>]* @stgar2, i32 0, i32 1, i32 1), !dbg !104, !tbaa !44 ; line:64 col:18
  %tmp68 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 10, !dbg !105 ; line:65 col:36
  %tmp69 = load float, float* %tmp68, align 4, !dbg !105, !tbaa !44 ; line:65 col:36
  %tmp70 = load i32, i32* %tmp, align 4, !dbg !106, !tbaa !22 ; line:65 col:30
  %tmp71 = getelementptr inbounds <1 x float>, <1 x float>* @dygrec1.0, i32 0, i32 %tmp70, !dbg !107 ; line:65 col:20
  store float %tmp69, float* %tmp71, !dbg !108, !tbaa !44 ; line:65 col:34
  store float %tmp69, float* @stgrec1.0.0, !dbg !109, !tbaa !44 ; line:65 col:18
  %tmp72 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 11, !dbg !110 ; line:66 col:36
  %tmp73 = load float, float* %tmp72, align 4, !dbg !110, !tbaa !44 ; line:66 col:36
  %tmp74 = load i32, i32* %tmp, align 4, !dbg !111, !tbaa !22 ; line:66 col:30
  %tmp75 = getelementptr inbounds <2 x float>, <2 x float>* @dygrec2.0, i32 0, i32 %tmp74, !dbg !112 ; line:66 col:20
  store float %tmp73, float* %tmp75, !dbg !113, !tbaa !44 ; line:66 col:34
  store float %tmp73, float* getelementptr inbounds (<2 x float>, <2 x float>* @stgrec2.0, i32 0, i32 1), !dbg !114, !tbaa !44 ; line:66 col:18
  br label %bb76, !dbg !115 ; line:67 col:3

bb76:                                             ; preds = %bb17, %bb
  %tmp77 = load <1 x float>, <1 x float>* %dyloc1, align 4, !dbg !116 ; line:68 col:17
  %tmp78 = extractelement <1 x float> %tmp77, i32 0, !dbg !116 ; line:68 col:17
  %tmp79 = load <2 x float>, <2 x float>* %dyloc2, align 4, !dbg !117 ; line:68 col:27
  %tmp80 = extractelement <2 x float> %tmp79, i32 1, !dbg !117 ; line:68 col:27
  %tmp81 = load <1 x float>, <1 x float>* %stloc1, align 4, !dbg !118 ; line:68 col:37
  %tmp82 = extractelement <1 x float> %tmp81, i32 0, !dbg !118 ; line:68 col:37
  %tmp83 = load <2 x float>, <2 x float>* %stloc2, align 4, !dbg !119 ; line:68 col:47
  %tmp84 = extractelement <2 x float> %tmp83, i32 1, !dbg !119 ; line:68 col:47
  %tmp85 = insertelement <4 x float> undef, float %tmp78, i64 0, !dbg !120 ; line:68 col:16
  %tmp86 = insertelement <4 x float> %tmp85, float %tmp80, i64 1, !dbg !120 ; line:68 col:16
  %tmp87 = insertelement <4 x float> %tmp86, float %tmp82, i64 2, !dbg !120 ; line:68 col:16
  %tmp88 = insertelement <4 x float> %tmp87, float %tmp84, i64 3, !dbg !120 ; line:68 col:16
  %tmp89 = load i32, i32* %tmp, align 4, !dbg !121, !tbaa !22 ; line:68 col:73
  %tmp90 = load i32, i32* %tmp, align 4, !dbg !122, !tbaa !22 ; line:68 col:77
  %tmp91 = getelementptr inbounds [3 x <1 x float>], [3 x <1 x float>]* %dylar1, i32 0, i32 %tmp89, i32 %tmp90, !dbg !123 ; line:68 col:66
  %tmp92 = load float, float* %tmp91, !dbg !123, !tbaa !44 ; line:68 col:66
  %tmp93 = load i32, i32* %tmp, align 4, !dbg !124, !tbaa !22 ; line:68 col:89
  %tmp94 = load i32, i32* %tmp, align 4, !dbg !125, !tbaa !22 ; line:68 col:93
  %tmp95 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %dylar2, i32 0, i32 %tmp93, i32 %tmp94, !dbg !126 ; line:68 col:82
  %tmp96 = load float, float* %tmp95, !dbg !126, !tbaa !44 ; line:68 col:82
  %tmp97 = getelementptr [3 x float], [3 x float]* %stlar1.0, i32 0, i32 0, !dbg !127 ; line:68 col:98
  %load = load float, float* %tmp97, !dbg !127 ; line:68 col:98
  %insert = insertelement <1 x float> undef, float %load, i64 0, !dbg !127 ; line:68 col:98
  %tmp98 = extractelement <1 x float> %insert, i32 0, !dbg !127 ; line:68 col:98
  %tmp99 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %stlar2, i32 0, i32 0, !dbg !128 ; line:68 col:111
  %tmp100 = load <2 x float>, <2 x float>* %tmp99, align 4, !dbg !128 ; line:68 col:111
  %tmp101 = extractelement <2 x float> %tmp100, i32 1, !dbg !128 ; line:68 col:111
  %tmp102 = insertelement <4 x float> undef, float %tmp92, i64 0, !dbg !129 ; line:68 col:65
  %tmp103 = insertelement <4 x float> %tmp102, float %tmp96, i64 1, !dbg !129 ; line:68 col:65
  %tmp104 = insertelement <4 x float> %tmp103, float %tmp98, i64 2, !dbg !129 ; line:68 col:65
  %tmp105 = insertelement <4 x float> %tmp104, float %tmp101, i64 3, !dbg !129 ; line:68 col:65
  %tmp106 = fadd <4 x float> %tmp88, %tmp105, !dbg !130 ; line:68 col:57
  %tmp107 = load <1 x float>, <1 x float>* @dyglob1, align 4, !dbg !131 ; line:69 col:10
  %tmp108 = extractelement <1 x float> %tmp107, i32 0, !dbg !131 ; line:69 col:10
  %tmp109 = load <2 x float>, <2 x float>* @dyglob2, align 4, !dbg !132 ; line:69 col:21
  %tmp110 = extractelement <2 x float> %tmp109, i32 1, !dbg !132 ; line:69 col:21
  %load3 = load float, float* @stglob1.0, !dbg !133 ; line:69 col:32
  %insert4 = insertelement <1 x float> undef, float %load3, i64 0, !dbg !133 ; line:69 col:32
  %tmp111 = extractelement <1 x float> %insert4, i32 0, !dbg !133 ; line:69 col:32
  %tmp112 = load <2 x float>, <2 x float>* @stglob2, align 4, !dbg !134 ; line:69 col:43
  %tmp113 = extractelement <2 x float> %tmp112, i32 1, !dbg !134 ; line:69 col:43
  %tmp114 = insertelement <4 x float> undef, float %tmp108, i64 0, !dbg !135 ; line:69 col:9
  %tmp115 = insertelement <4 x float> %tmp114, float %tmp110, i64 1, !dbg !135 ; line:69 col:9
  %tmp116 = insertelement <4 x float> %tmp115, float %tmp111, i64 2, !dbg !135 ; line:69 col:9
  %tmp117 = insertelement <4 x float> %tmp116, float %tmp113, i64 3, !dbg !135 ; line:69 col:9
  %tmp118 = fadd <4 x float> %tmp106, %tmp117, !dbg !136 ; line:68 col:124
  %tmp119 = load i32, i32* %tmp, align 4, !dbg !137, !tbaa !22 ; line:69 col:70
  %tmp120 = load i32, i32* %tmp, align 4, !dbg !138, !tbaa !22 ; line:69 col:74
  %tmp121 = getelementptr inbounds [2 x <1 x float>], [2 x <1 x float>]* @dygar1, i32 0, i32 %tmp119, i32 %tmp120, !dbg !139 ; line:69 col:63
  %tmp122 = load float, float* %tmp121, !dbg !139, !tbaa !44 ; line:69 col:63
  %tmp123 = load i32, i32* %tmp, align 4, !dbg !140, !tbaa !22 ; line:69 col:86
  %tmp124 = load i32, i32* %tmp, align 4, !dbg !141, !tbaa !22 ; line:69 col:90
  %tmp125 = getelementptr inbounds [3 x <2 x float>], [3 x <2 x float>]* @dygar2, i32 0, i32 %tmp123, i32 %tmp124, !dbg !142 ; line:69 col:79
  %tmp126 = load float, float* %tmp125, !dbg !142, !tbaa !44 ; line:69 col:79
  %load1 = load float, float* getelementptr inbounds ([2 x float], [2 x float]* @stgar1.0, i32 0, i32 0), !dbg !143 ; line:69 col:95
  %insert2 = insertelement <1 x float> undef, float %load1, i64 0, !dbg !143 ; line:69 col:95
  %tmp127 = extractelement <1 x float> %insert2, i32 0, !dbg !143 ; line:69 col:95
  %tmp128 = load <2 x float>, <2 x float>* getelementptr inbounds ([3 x <2 x float>], [3 x <2 x float>]* @stgar2, i32 0, i32 0), align 4, !dbg !144 ; line:69 col:108
  %tmp129 = extractelement <2 x float> %tmp128, i32 1, !dbg !144 ; line:69 col:108
  %tmp130 = insertelement <4 x float> undef, float %tmp122, i64 0, !dbg !145 ; line:69 col:62
  %tmp131 = insertelement <4 x float> %tmp130, float %tmp126, i64 1, !dbg !145 ; line:69 col:62
  %tmp132 = insertelement <4 x float> %tmp131, float %tmp127, i64 2, !dbg !145 ; line:69 col:62
  %tmp133 = insertelement <4 x float> %tmp132, float %tmp129, i64 3, !dbg !145 ; line:69 col:62
  %tmp134 = fadd <4 x float> %tmp118, %tmp133, !dbg !146 ; line:69 col:54
  %tmp135 = load <1 x float>, <1 x float>* %stlorc1.0, align 4, !dbg !147, !tbaa !148 ; line:70 col:20
  %tmp136 = extractelement <1 x float> %tmp135, i64 0, !dbg !149 ; line:70 col:11
  %tmp137 = getelementptr inbounds <2 x float>, <2 x float>* %stlorc2.0, i32 0, i32 1, !dbg !150 ; line:70 col:23
  %tmp138 = load float, float* %tmp137, !dbg !150, !tbaa !44 ; line:70 col:23
  %tmp139 = load <1 x float>, <1 x float>* %dylorc1.0, align 4, !dbg !151, !tbaa !148 ; line:70 col:45
  %tmp140 = extractelement <1 x float> %tmp139, i64 0, !dbg !149 ; line:70 col:11
  %tmp141 = load i32, i32* %tmp, align 4, !dbg !152, !tbaa !22 ; line:70 col:58
  %tmp142 = getelementptr inbounds <2 x float>, <2 x float>* %dylorc2.0, i32 0, i32 %tmp141, !dbg !153 ; line:70 col:48
  %tmp143 = load float, float* %tmp142, !dbg !153, !tbaa !44 ; line:70 col:48
  %tmp144 = insertelement <4 x float> undef, float %tmp136, i64 0, !dbg !149 ; line:70 col:11
  %tmp145 = insertelement <4 x float> %tmp144, float %tmp138, i64 1, !dbg !149 ; line:70 col:11
  %tmp146 = insertelement <4 x float> %tmp145, float %tmp140, i64 2, !dbg !149 ; line:70 col:11
  %tmp147 = insertelement <4 x float> %tmp146, float %tmp143, i64 3, !dbg !149 ; line:70 col:11
  %tmp148 = fadd <4 x float> %tmp134, %tmp147, !dbg !154 ; line:69 col:121
  %load5 = load float, float* @stgrec1.0.0, !dbg !155 ; line:70 col:80
  %insert6 = insertelement <1 x float> undef, float %load5, i64 0, !dbg !155 ; line:70 col:80
  %tmp149 = extractelement <1 x float> %insert6, i64 0, !dbg !156 ; line:70 col:71
  %tmp150 = load float, float* getelementptr inbounds (<2 x float>, <2 x float>* @stgrec2.0, i32 0, i32 1), !dbg !157, !tbaa !44 ; line:70 col:83
  %tmp151 = load <1 x float>, <1 x float>* @dygrec1.0, align 4, !dbg !158, !tbaa !148 ; line:70 col:105
  %tmp152 = extractelement <1 x float> %tmp151, i64 0, !dbg !156 ; line:70 col:71
  %tmp153 = load i32, i32* %tmp, align 4, !dbg !159, !tbaa !22 ; line:70 col:118
  %tmp154 = getelementptr inbounds <2 x float>, <2 x float>* @dygrec2.0, i32 0, i32 %tmp153, !dbg !160 ; line:70 col:108
  %tmp155 = load float, float* %tmp154, !dbg !160, !tbaa !44 ; line:70 col:108
  %tmp156 = insertelement <4 x float> undef, float %tmp149, i64 0, !dbg !156 ; line:70 col:71
  %tmp157 = insertelement <4 x float> %tmp156, float %tmp150, i64 1, !dbg !156 ; line:70 col:71
  %tmp158 = insertelement <4 x float> %tmp157, float %tmp152, i64 2, !dbg !156 ; line:70 col:71
  %tmp159 = insertelement <4 x float> %tmp158, float %tmp155, i64 3, !dbg !156 ; line:70 col:71
  %tmp160 = fadd <4 x float> %tmp148, %tmp159, !dbg !161 ; line:70 col:63
  %tmp161 = bitcast <2 x float>* %stlorc2.0 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 8, i8* %tmp161) #0, !dbg !162 ; line:71 col:1
  %tmp162 = bitcast <1 x float>* %stlorc1.0 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 4, i8* %tmp162) #0, !dbg !162 ; line:71 col:1
  %tmp163 = bitcast [4 x <2 x float>]* %stlar2 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 32, i8* %tmp163) #0, !dbg !162 ; line:71 col:1
  %tmp164 = bitcast [3 x float]* %stlar1.0 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 12, i8* %tmp164) #0, !dbg !162 ; line:71 col:1
  %tmp165 = bitcast <2 x float>* %stloc2 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 8, i8* %tmp165) #0, !dbg !162 ; line:71 col:1
  %tmp166 = bitcast <1 x float>* %stloc1 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 4, i8* %tmp166) #0, !dbg !162 ; line:71 col:1
  %tmp167 = bitcast <2 x float>* %dylorc2.0 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 8, i8* %tmp167) #0, !dbg !162 ; line:71 col:1
  %tmp168 = bitcast <1 x float>* %dylorc1.0 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 4, i8* %tmp168) #0, !dbg !162 ; line:71 col:1
  %tmp169 = bitcast [4 x <2 x float>]* %dylar2 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 32, i8* %tmp169) #0, !dbg !162 ; line:71 col:1
  %tmp170 = bitcast [3 x <1 x float>]* %dylar1 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 12, i8* %tmp170) #0, !dbg !162 ; line:71 col:1
  %tmp171 = bitcast <2 x float>* %dyloc2 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 8, i8* %tmp171) #0, !dbg !162 ; line:71 col:1
  %tmp172 = bitcast <1 x float>* %dyloc1 to i8*, !dbg !162 ; line:71 col:1
  call void @llvm.lifetime.end(i64 4, i8* %tmp172) #0, !dbg !162 ; line:71 col:1
  ret <4 x float> %tmp160, !dbg !163 ; line:68 col:3
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #0

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #0

attributes #0 = { nounwind }

!llvm.module.flags = !{!0}
!pauseresume = !{!1}
!llvm.ident = !{!2}
!dx.version = !{!3}
!dx.valver = !{!3}
!dx.shaderModel = !{!4}
!dx.typeAnnotations = !{!5, !10}
!dx.entryPoints = !{!19}
!dx.fnprops = !{}
!dx.options = !{!20, !21}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{!"hlsl-hlemit", !"hlsl-hlensure"}
!2 = !{!"dxc(private) 1.8.0.4845 (disable_disble_spirv, 2514104b9-dirty)"}
!3 = !{i32 1, i32 9}
!4 = !{!"lib", i32 6, i32 9}
!5 = !{i32 0, %struct.VectRec1 undef, !6, %struct.VectRec2 undef, !8}
!6 = !{i32 4, !7}
!7 = !{i32 6, !"f", i32 3, i32 0, i32 4, !"REC1", i32 7, i32 9, i32 13, i32 1}
!8 = !{i32 8, !9}
!9 = !{i32 6, !"f", i32 3, i32 0, i32 4, !"REC2", i32 7, i32 9, i32 13, i32 2}
!10 = !{i32 1, <4 x float> (i32, [12 x float]*)* @"\01?tester@@YA?AV?$vector@M$03@@HY0M@M@Z", !11}
!11 = !{!12, !15, !17}
!12 = !{i32 1, !13, !14}
!13 = !{i32 7, i32 9, i32 13, i32 4}
!14 = !{}
!15 = !{i32 0, !16, !14}
!16 = !{i32 4, !"IX", i32 7, i32 4}
!17 = !{i32 0, !18, !14}
!18 = !{i32 4, !"VAL", i32 7, i32 9}
!19 = !{null, !"", null, null, null}
!20 = !{i32 64}
!21 = !{i32 -1}
!22 = !{!23, !23, i64 0}
!23 = !{!"int", !24, i64 0}
!24 = !{!"omnipotent char", !25, i64 0}
!25 = !{!"Simple C/C++ TBAA"}
!26 = !DILocation(line: 39, column: 3, scope: !27)
!27 = !DISubprogram(name: "tester", scope: !28, file: !28, line: 37, type: !29, isLocal: false, isDefinition: true, scopeLine: 37, flags: DIFlagPrototyped, isOptimized: false, function: <4 x float> (i32, [12 x float]*)* @"\01?tester@@YA?AV?$vector@M$03@@HY0M@M@Z")
!28 = !DIFile(filename: "/home/grroth/dxc/tools/clang/test/CodeGenDXIL/passes/longvec-alloca-gv.hlsl", directory: "")
!29 = !DISubroutineType(types: !14)
!30 = !DILocation(line: 40, column: 3, scope: !27)
!31 = !DILocation(line: 41, column: 3, scope: !27)
!32 = !DILocation(line: 42, column: 3, scope: !27)
!33 = !DILocation(line: 43, column: 3, scope: !27)
!34 = !DILocation(line: 44, column: 3, scope: !27)
!35 = !DILocation(line: 46, column: 3, scope: !27)
!36 = !DILocation(line: 47, column: 3, scope: !27)
!37 = !DILocation(line: 48, column: 3, scope: !27)
!38 = !DILocation(line: 49, column: 3, scope: !27)
!39 = !DILocation(line: 50, column: 3, scope: !27)
!40 = !DILocation(line: 51, column: 3, scope: !27)
!41 = !DILocation(line: 53, column: 7, scope: !27)
!42 = !DILocation(line: 53, column: 10, scope: !27)
!43 = !DILocation(line: 54, column: 30, scope: !27)
!44 = !{!45, !45, i64 0}
!45 = !{!"float", !24, i64 0}
!46 = !DILocation(line: 54, column: 24, scope: !27)
!47 = !DILocation(line: 54, column: 17, scope: !27)
!48 = !DILocation(line: 54, column: 28, scope: !27)
!49 = !DILocation(line: 54, column: 5, scope: !27)
!50 = !DILocation(line: 54, column: 15, scope: !27)
!51 = !DILocation(line: 55, column: 30, scope: !27)
!52 = !DILocation(line: 55, column: 24, scope: !27)
!53 = !DILocation(line: 55, column: 17, scope: !27)
!54 = !DILocation(line: 55, column: 28, scope: !27)
!55 = !DILocation(line: 55, column: 5, scope: !27)
!56 = !DILocation(line: 55, column: 15, scope: !27)
!57 = !DILocation(line: 56, column: 37, scope: !27)
!58 = !DILocation(line: 56, column: 27, scope: !27)
!59 = !DILocation(line: 56, column: 31, scope: !27)
!60 = !DILocation(line: 56, column: 20, scope: !27)
!61 = !DILocation(line: 56, column: 35, scope: !27)
!62 = !DILocation(line: 56, column: 5, scope: !27)
!63 = !DILocation(line: 56, column: 18, scope: !27)
!64 = !DILocation(line: 57, column: 37, scope: !27)
!65 = !DILocation(line: 57, column: 27, scope: !27)
!66 = !DILocation(line: 57, column: 31, scope: !27)
!67 = !DILocation(line: 57, column: 20, scope: !27)
!68 = !DILocation(line: 57, column: 35, scope: !27)
!69 = !DILocation(line: 57, column: 5, scope: !27)
!70 = !DILocation(line: 57, column: 18, scope: !27)
!71 = !DILocation(line: 58, column: 36, scope: !27)
!72 = !DILocation(line: 58, column: 30, scope: !27)
!73 = !DILocation(line: 58, column: 20, scope: !27)
!74 = !DILocation(line: 58, column: 34, scope: !27)
!75 = !DILocation(line: 58, column: 5, scope: !27)
!76 = !DILocation(line: 58, column: 18, scope: !27)
!77 = !DILocation(line: 59, column: 36, scope: !27)
!78 = !DILocation(line: 59, column: 30, scope: !27)
!79 = !DILocation(line: 59, column: 20, scope: !27)
!80 = !DILocation(line: 59, column: 34, scope: !27)
!81 = !DILocation(line: 59, column: 5, scope: !27)
!82 = !DILocation(line: 59, column: 18, scope: !27)
!83 = !DILocation(line: 61, column: 32, scope: !27)
!84 = !DILocation(line: 61, column: 26, scope: !27)
!85 = !DILocation(line: 61, column: 18, scope: !27)
!86 = !DILocation(line: 61, column: 30, scope: !27)
!87 = !DILocation(line: 61, column: 16, scope: !27)
!88 = !DILocation(line: 62, column: 32, scope: !27)
!89 = !DILocation(line: 62, column: 26, scope: !27)
!90 = !DILocation(line: 62, column: 18, scope: !27)
!91 = !DILocation(line: 62, column: 30, scope: !27)
!92 = !DILocation(line: 62, column: 16, scope: !27)
!93 = !DILocation(line: 63, column: 37, scope: !27)
!94 = !DILocation(line: 63, column: 27, scope: !27)
!95 = !DILocation(line: 63, column: 31, scope: !27)
!96 = !DILocation(line: 63, column: 20, scope: !27)
!97 = !DILocation(line: 63, column: 35, scope: !27)
!98 = !DILocation(line: 63, column: 18, scope: !27)
!99 = !DILocation(line: 64, column: 37, scope: !27)
!100 = !DILocation(line: 64, column: 27, scope: !27)
!101 = !DILocation(line: 64, column: 31, scope: !27)
!102 = !DILocation(line: 64, column: 20, scope: !27)
!103 = !DILocation(line: 64, column: 35, scope: !27)
!104 = !DILocation(line: 64, column: 18, scope: !27)
!105 = !DILocation(line: 65, column: 36, scope: !27)
!106 = !DILocation(line: 65, column: 30, scope: !27)
!107 = !DILocation(line: 65, column: 20, scope: !27)
!108 = !DILocation(line: 65, column: 34, scope: !27)
!109 = !DILocation(line: 65, column: 18, scope: !27)
!110 = !DILocation(line: 66, column: 36, scope: !27)
!111 = !DILocation(line: 66, column: 30, scope: !27)
!112 = !DILocation(line: 66, column: 20, scope: !27)
!113 = !DILocation(line: 66, column: 34, scope: !27)
!114 = !DILocation(line: 66, column: 18, scope: !27)
!115 = !DILocation(line: 67, column: 3, scope: !27)
!116 = !DILocation(line: 68, column: 17, scope: !27)
!117 = !DILocation(line: 68, column: 27, scope: !27)
!118 = !DILocation(line: 68, column: 37, scope: !27)
!119 = !DILocation(line: 68, column: 47, scope: !27)
!120 = !DILocation(line: 68, column: 16, scope: !27)
!121 = !DILocation(line: 68, column: 73, scope: !27)
!122 = !DILocation(line: 68, column: 77, scope: !27)
!123 = !DILocation(line: 68, column: 66, scope: !27)
!124 = !DILocation(line: 68, column: 89, scope: !27)
!125 = !DILocation(line: 68, column: 93, scope: !27)
!126 = !DILocation(line: 68, column: 82, scope: !27)
!127 = !DILocation(line: 68, column: 98, scope: !27)
!128 = !DILocation(line: 68, column: 111, scope: !27)
!129 = !DILocation(line: 68, column: 65, scope: !27)
!130 = !DILocation(line: 68, column: 57, scope: !27)
!131 = !DILocation(line: 69, column: 10, scope: !27)
!132 = !DILocation(line: 69, column: 21, scope: !27)
!133 = !DILocation(line: 69, column: 32, scope: !27)
!134 = !DILocation(line: 69, column: 43, scope: !27)
!135 = !DILocation(line: 69, column: 9, scope: !27)
!136 = !DILocation(line: 68, column: 124, scope: !27)
!137 = !DILocation(line: 69, column: 70, scope: !27)
!138 = !DILocation(line: 69, column: 74, scope: !27)
!139 = !DILocation(line: 69, column: 63, scope: !27)
!140 = !DILocation(line: 69, column: 86, scope: !27)
!141 = !DILocation(line: 69, column: 90, scope: !27)
!142 = !DILocation(line: 69, column: 79, scope: !27)
!143 = !DILocation(line: 69, column: 95, scope: !27)
!144 = !DILocation(line: 69, column: 108, scope: !27)
!145 = !DILocation(line: 69, column: 62, scope: !27)
!146 = !DILocation(line: 69, column: 54, scope: !27)
!147 = !DILocation(line: 70, column: 20, scope: !27)
!148 = !{!24, !24, i64 0}
!149 = !DILocation(line: 70, column: 11, scope: !27)
!150 = !DILocation(line: 70, column: 23, scope: !27)
!151 = !DILocation(line: 70, column: 45, scope: !27)
!152 = !DILocation(line: 70, column: 58, scope: !27)
!153 = !DILocation(line: 70, column: 48, scope: !27)
!154 = !DILocation(line: 69, column: 121, scope: !27)
!155 = !DILocation(line: 70, column: 80, scope: !27)
!156 = !DILocation(line: 70, column: 71, scope: !27)
!157 = !DILocation(line: 70, column: 83, scope: !27)
!158 = !DILocation(line: 70, column: 105, scope: !27)
!159 = !DILocation(line: 70, column: 118, scope: !27)
!160 = !DILocation(line: 70, column: 108, scope: !27)
!161 = !DILocation(line: 70, column: 63, scope: !27)
!162 = !DILocation(line: 71, column: 1, scope: !27)
!163 = !DILocation(line: 68, column: 3, scope: !27)
