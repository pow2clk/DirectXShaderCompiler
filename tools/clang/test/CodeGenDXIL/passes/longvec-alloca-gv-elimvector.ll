target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

@dyglob2 = internal global <2 x float> zeroinitializer, align 4
@stglob2 = internal global <2 x float> zeroinitializer, align 4
@dygar2 = internal global [3 x <2 x float>] zeroinitializer, align 4
@stgar2 = internal global [3 x <2 x float>] zeroinitializer, align 4
@dygrec2.0 = internal global <2 x float> zeroinitializer, align 4
@stgrec2.0 = internal global <2 x float> zeroinitializer, align 4
@stgar1.0 = internal global [2 x float] zeroinitializer, align 4
@stglob1.0 = internal global float 0.000000e+00, align 4
@stgrec1.0.0 = internal global float 0.000000e+00, align 4
@dyglob1.v = internal global [1 x float] zeroinitializer, align 4
@dygar1.v = internal global [2 x [1 x float]] zeroinitializer, align 4
@dygrec1.0.v = internal global [1 x float] zeroinitializer, align 4

; Function Attrs: nounwind
define <4 x float> @"\01?tester@@YA?AV?$vector@M$03@@HY0M@M@Z"(i32 %ix, [12 x float]* %vals) #0 {
  %1 = alloca [1 x float]
  %dylorc2.0 = alloca <2 x float>
  %2 = alloca [1 x float], align 4
  %dyloc2 = alloca <2 x float>, align 4
  %3 = alloca [3 x [1 x float]], align 4
  %dylar2 = alloca [4 x <2 x float>], align 4
  %4 = bitcast [1 x float]* %2 to i8*, !dbg !3
  call void @llvm.lifetime.start(i64 4, i8* %4) #0, !dbg !3
  %5 = bitcast <2 x float>* %dyloc2 to i8*, !dbg !8
  call void @llvm.lifetime.start(i64 8, i8* %5) #0, !dbg !8
  %6 = bitcast [3 x [1 x float]]* %3 to i8*, !dbg !9
  call void @llvm.lifetime.start(i64 12, i8* %6) #0, !dbg !9
  %7 = bitcast [4 x <2 x float>]* %dylar2 to i8*, !dbg !10
  call void @llvm.lifetime.start(i64 32, i8* %7) #0, !dbg !10
  %8 = bitcast [1 x float]* %1 to i8*, !dbg !11
  call void @llvm.lifetime.start(i64 4, i8* %8) #0, !dbg !11
  %9 = bitcast <2 x float>* %dylorc2.0 to i8*, !dbg !12
  call void @llvm.lifetime.start(i64 8, i8* %9) #0, !dbg !12
  %10 = icmp sgt i32 %ix, 0, !dbg !13
  br i1 %10, label %11, label %51, !dbg !14

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 0, !dbg !15
  %13 = load float, float* %12, align 4, !dbg !15, !tbaa !16
  %14 = getelementptr [1 x float], [1 x float]* %2, i32 0, i32 %ix, !dbg !20
  store float %13, float* %14, !dbg !21, !tbaa !16
  %15 = insertelement <1 x float> undef, float %13, i32 0, !dbg !22
  %16 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 1, !dbg !23
  %17 = load float, float* %16, align 4, !dbg !23, !tbaa !16
  %18 = getelementptr <2 x float>, <2 x float>* %dyloc2, i32 0, i32 %ix, !dbg !24
  store float %17, float* %18, !dbg !25, !tbaa !16
  %19 = insertelement <2 x float> undef, float %17, i32 1, !dbg !26
  %20 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 2, !dbg !27
  %21 = load float, float* %20, align 4, !dbg !27, !tbaa !16
  %22 = getelementptr [3 x [1 x float]], [3 x [1 x float]]* %3, i32 0, i32 %ix, i32 %ix, !dbg !28
  store float %21, float* %22, !dbg !29, !tbaa !16
  %23 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 3, !dbg !30
  %24 = load float, float* %23, align 4, !dbg !30, !tbaa !16
  %25 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %dylar2, i32 0, i32 %ix, i32 %ix, !dbg !31
  store float %24, float* %25, !dbg !32, !tbaa !16
  %26 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 4, !dbg !33
  %27 = load float, float* %26, align 4, !dbg !33, !tbaa !16
  %28 = getelementptr [1 x float], [1 x float]* %1, i32 0, i32 %ix, !dbg !34
  store float %27, float* %28, !dbg !35, !tbaa !16
  %29 = insertelement <1 x float> undef, float %27, i32 0, !dbg !36
  %30 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 5, !dbg !37
  %31 = load float, float* %30, align 4, !dbg !37, !tbaa !16
  %32 = getelementptr inbounds <2 x float>, <2 x float>* %dylorc2.0, i32 0, i32 %ix, !dbg !38
  store float %31, float* %32, !dbg !39, !tbaa !16
  %33 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 6, !dbg !40
  %34 = load float, float* %33, align 4, !dbg !40, !tbaa !16
  %35 = getelementptr [1 x float], [1 x float]* @dyglob1.v, i32 0, i32 %ix, !dbg !41
  store float %34, float* %35, !dbg !42, !tbaa !16
  store float %34, float* @stglob1.0, !dbg !43, !tbaa !16
  %36 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 7, !dbg !44
  %37 = load float, float* %36, align 4, !dbg !44, !tbaa !16
  %38 = getelementptr <2 x float>, <2 x float>* @dyglob2, i32 0, i32 %ix, !dbg !45
  store float %37, float* %38, !dbg !46, !tbaa !16
  store float %37, float* getelementptr inbounds (<2 x float>, <2 x float>* @stglob2, i32 0, i32 1), !dbg !47, !tbaa !16
  %39 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 8, !dbg !48
  %40 = load float, float* %39, align 4, !dbg !48, !tbaa !16
  %41 = getelementptr [2 x [1 x float]], [2 x [1 x float]]* @dygar1.v, i32 0, i32 %ix, i32 %ix, !dbg !49
  store float %40, float* %41, !dbg !50, !tbaa !16
  store float %40, float* getelementptr inbounds ([2 x float], [2 x float]* @stgar1.0, i32 0, i32 1), !dbg !51, !tbaa !16
  %42 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 9, !dbg !52
  %43 = load float, float* %42, align 4, !dbg !52, !tbaa !16
  %44 = getelementptr inbounds [3 x <2 x float>], [3 x <2 x float>]* @dygar2, i32 0, i32 %ix, i32 %ix, !dbg !53
  store float %43, float* %44, !dbg !54, !tbaa !16
  store float %43, float* getelementptr inbounds ([3 x <2 x float>], [3 x <2 x float>]* @stgar2, i32 0, i32 1, i32 1), !dbg !55, !tbaa !16
  %45 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 10, !dbg !56
  %46 = load float, float* %45, align 4, !dbg !56, !tbaa !16
  %47 = getelementptr [1 x float], [1 x float]* @dygrec1.0.v, i32 0, i32 %ix, !dbg !57
  store float %46, float* %47, !dbg !58, !tbaa !16
  store float %46, float* @stgrec1.0.0, !dbg !59, !tbaa !16
  %48 = getelementptr inbounds [12 x float], [12 x float]* %vals, i32 0, i32 11, !dbg !60
  %49 = load float, float* %48, align 4, !dbg !60, !tbaa !16
  %50 = getelementptr inbounds <2 x float>, <2 x float>* @dygrec2.0, i32 0, i32 %ix, !dbg !61
  store float %49, float* %50, !dbg !62, !tbaa !16
  store float %49, float* getelementptr inbounds (<2 x float>, <2 x float>* @stgrec2.0, i32 0, i32 1), !dbg !63, !tbaa !16
  br label %51, !dbg !64

; <label>:51                                      ; preds = %11, %0
  %stloc2.0 = phi <2 x float> [ %19, %11 ], [ undef, %0 ]
  %stlorc2.0.sroa.2.0 = phi float [ %31, %11 ], [ undef, %0 ]
  %stloc1.0.i0 = phi float [ %13, %11 ], [ undef, %0 ]
  %stlorc1.0.0.i0 = phi float [ %27, %11 ], [ undef, %0 ]
  %stlorc1.0.0 = insertelement <1 x float> undef, float %stlorc1.0.0.i0, i32 0, !dbg !65
  %stloc1.0 = insertelement <1 x float> undef, float %stloc1.0.i0, i32 0, !dbg !65
  %52 = getelementptr inbounds [1 x float], [1 x float]* %2, i32 0, i32 0, !dbg !65
  %53 = load float, float* %52, align 4, !dbg !65
  %54 = load <2 x float>, <2 x float>* %dyloc2, align 4, !dbg !66
  %55 = extractelement <2 x float> %54, i32 1, !dbg !66
  %56 = extractelement <2 x float> %stloc2.0, i32 1, !dbg !67
  %57 = insertelement <4 x float> undef, float %53, i64 0, !dbg !68
  %58 = insertelement <4 x float> %57, float %55, i64 1, !dbg !68
  %59 = insertelement <4 x float> %58, float %stloc1.0.i0, i64 2, !dbg !68
  %60 = insertelement <4 x float> %59, float %56, i64 3, !dbg !68
  %61 = getelementptr [3 x [1 x float]], [3 x [1 x float]]* %3, i32 0, i32 %ix, i32 %ix, !dbg !69
  %62 = load float, float* %61, !dbg !69, !tbaa !16
  %63 = getelementptr inbounds [4 x <2 x float>], [4 x <2 x float>]* %dylar2, i32 0, i32 %ix, i32 %ix, !dbg !70
  %64 = load float, float* %63, !dbg !70, !tbaa !16
  %65 = insertelement <4 x float> undef, float %62, i64 0, !dbg !71
  %66 = insertelement <4 x float> %65, float %64, i64 1, !dbg !71
  %67 = insertelement <4 x float> %66, float undef, i64 2, !dbg !71
  %68 = insertelement <4 x float> %67, float undef, i64 3, !dbg !71
  %69 = fadd fast <4 x float> %60, %68, !dbg !72
  %70 = load float, float* getelementptr inbounds ([1 x float], [1 x float]* @dyglob1.v, i32 0, i32 0), align 4, !dbg !73
  %71 = load <2 x float>, <2 x float>* @dyglob2, align 4, !dbg !74
  %72 = extractelement <2 x float> %71, i32 1, !dbg !74
  %load3 = load float, float* @stglob1.0, !dbg !75
  %73 = load <2 x float>, <2 x float>* @stglob2, align 4, !dbg !76
  %74 = extractelement <2 x float> %73, i32 1, !dbg !76
  %75 = insertelement <4 x float> undef, float %70, i64 0, !dbg !77
  %76 = insertelement <4 x float> %75, float %72, i64 1, !dbg !77
  %77 = insertelement <4 x float> %76, float %load3, i64 2, !dbg !77
  %78 = insertelement <4 x float> %77, float %74, i64 3, !dbg !77
  %79 = fadd fast <4 x float> %69, %78, !dbg !78
  %80 = getelementptr [2 x [1 x float]], [2 x [1 x float]]* @dygar1.v, i32 0, i32 %ix, i32 %ix, !dbg !79
  %81 = load float, float* %80, !dbg !79, !tbaa !16
  %82 = getelementptr inbounds [3 x <2 x float>], [3 x <2 x float>]* @dygar2, i32 0, i32 %ix, i32 %ix, !dbg !80
  %83 = load float, float* %82, !dbg !80, !tbaa !16
  %load1 = load float, float* getelementptr inbounds ([2 x float], [2 x float]* @stgar1.0, i32 0, i32 0), !dbg !81
  %84 = load <2 x float>, <2 x float>* getelementptr inbounds ([3 x <2 x float>], [3 x <2 x float>]* @stgar2, i32 0, i32 0), align 4, !dbg !82
  %85 = extractelement <2 x float> %84, i32 1, !dbg !82
  %86 = insertelement <4 x float> undef, float %81, i64 0, !dbg !83
  %87 = insertelement <4 x float> %86, float %83, i64 1, !dbg !83
  %88 = insertelement <4 x float> %87, float %load1, i64 2, !dbg !83
  %89 = insertelement <4 x float> %88, float %85, i64 3, !dbg !83
  %90 = fadd fast <4 x float> %79, %89, !dbg !84
  %91 = getelementptr inbounds [1 x float], [1 x float]* %1, i32 0, i32 0, !dbg !85
  %92 = load float, float* %91, align 4, !dbg !85
  %93 = getelementptr inbounds <2 x float>, <2 x float>* %dylorc2.0, i32 0, i32 %ix, !dbg !86
  %94 = load float, float* %93, !dbg !86, !tbaa !16
  %95 = insertelement <4 x float> undef, float %stlorc1.0.0.i0, i64 0, !dbg !87
  %96 = insertelement <4 x float> %95, float %stlorc2.0.sroa.2.0, i64 1, !dbg !87
  %97 = insertelement <4 x float> %96, float %92, i64 2, !dbg !87
  %98 = insertelement <4 x float> %97, float %94, i64 3, !dbg !87
  %99 = fadd fast <4 x float> %90, %98, !dbg !88
  %load5 = load float, float* @stgrec1.0.0, !dbg !89
  %100 = load float, float* getelementptr inbounds (<2 x float>, <2 x float>* @stgrec2.0, i32 0, i32 1), !dbg !90, !tbaa !16
  %101 = load float, float* getelementptr inbounds ([1 x float], [1 x float]* @dygrec1.0.v, i32 0, i32 0), align 4, !dbg !91
  %102 = getelementptr inbounds <2 x float>, <2 x float>* @dygrec2.0, i32 0, i32 %ix, !dbg !92
  %103 = load float, float* %102, !dbg !92, !tbaa !16
  %104 = insertelement <4 x float> undef, float %load5, i64 0, !dbg !93
  %105 = insertelement <4 x float> %104, float %100, i64 1, !dbg !93
  %106 = insertelement <4 x float> %105, float %101, i64 2, !dbg !93
  %107 = insertelement <4 x float> %106, float %103, i64 3, !dbg !93
  %108 = fadd fast <4 x float> %99, %107, !dbg !94
  %109 = bitcast <2 x float>* %dylorc2.0 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 8, i8* %109) #0, !dbg !95
  %110 = bitcast [1 x float]* %1 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 4, i8* %110) #0, !dbg !95
  %111 = bitcast [4 x <2 x float>]* %dylar2 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 32, i8* %111) #0, !dbg !95
  %112 = bitcast [3 x [1 x float]]* %3 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 12, i8* %112) #0, !dbg !95
  %113 = bitcast <2 x float>* %dyloc2 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 8, i8* %113) #0, !dbg !95
  %114 = bitcast [1 x float]* %2 to i8*, !dbg !95
  call void @llvm.lifetime.end(i64 4, i8* %114) #0, !dbg !95
  ret <4 x float> %108, !dbg !96
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #0

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #0

attributes #0 = { nounwind }

!llvm.module.flags = !{!0}
!pauseresume = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{!"hlsl-dxilemit", !"hlsl-dxilload"}
!2 = !{!"dxc(private) 1.8.0.4820 (longvec_bab_ldst_pr, 243b35785)"}
!3 = !DILocation(line: 39, column: 3, scope: !4)
!4 = !DISubprogram(name: "tester", scope: !5, file: !5, line: 37, type: !6, isLocal: false, isDefinition: true, scopeLine: 37, flags: DIFlagPrototyped, isOptimized: false, function: <4 x float> (i32, [12 x float]*)* @"\01?tester@@YA?AV?$vector@M$03@@HY0M@M@Z")
!5 = !DIFile(filename: "/Users/pow2clk/dxc/tools/clang/test/CodeGenDXIL/passes/longvec-alloca-gv.hlsl", directory: "")
!6 = !DISubroutineType(types: !7)
!7 = !{}
!8 = !DILocation(line: 40, column: 3, scope: !4)
!9 = !DILocation(line: 41, column: 3, scope: !4)
!10 = !DILocation(line: 42, column: 3, scope: !4)
!11 = !DILocation(line: 43, column: 3, scope: !4)
!12 = !DILocation(line: 44, column: 3, scope: !4)
!13 = !DILocation(line: 53, column: 10, scope: !4)
!14 = !DILocation(line: 53, column: 7, scope: !4)
!15 = !DILocation(line: 54, column: 30, scope: !4)
!16 = !{!17, !17, i64 0}
!17 = !{!"float", !18, i64 0}
!18 = !{!"omnipotent char", !19, i64 0}
!19 = !{!"Simple C/C++ TBAA"}
!20 = !DILocation(line: 54, column: 17, scope: !4)
!21 = !DILocation(line: 54, column: 28, scope: !4)
!22 = !DILocation(line: 54, column: 15, scope: !4)
!23 = !DILocation(line: 55, column: 30, scope: !4)
!24 = !DILocation(line: 55, column: 17, scope: !4)
!25 = !DILocation(line: 55, column: 28, scope: !4)
!26 = !DILocation(line: 55, column: 15, scope: !4)
!27 = !DILocation(line: 56, column: 37, scope: !4)
!28 = !DILocation(line: 56, column: 20, scope: !4)
!29 = !DILocation(line: 56, column: 35, scope: !4)
!30 = !DILocation(line: 57, column: 37, scope: !4)
!31 = !DILocation(line: 57, column: 20, scope: !4)
!32 = !DILocation(line: 57, column: 35, scope: !4)
!33 = !DILocation(line: 58, column: 36, scope: !4)
!34 = !DILocation(line: 58, column: 20, scope: !4)
!35 = !DILocation(line: 58, column: 34, scope: !4)
!36 = !DILocation(line: 58, column: 18, scope: !4)
!37 = !DILocation(line: 59, column: 36, scope: !4)
!38 = !DILocation(line: 59, column: 20, scope: !4)
!39 = !DILocation(line: 59, column: 34, scope: !4)
!40 = !DILocation(line: 61, column: 32, scope: !4)
!41 = !DILocation(line: 61, column: 18, scope: !4)
!42 = !DILocation(line: 61, column: 30, scope: !4)
!43 = !DILocation(line: 61, column: 16, scope: !4)
!44 = !DILocation(line: 62, column: 32, scope: !4)
!45 = !DILocation(line: 62, column: 18, scope: !4)
!46 = !DILocation(line: 62, column: 30, scope: !4)
!47 = !DILocation(line: 62, column: 16, scope: !4)
!48 = !DILocation(line: 63, column: 37, scope: !4)
!49 = !DILocation(line: 63, column: 20, scope: !4)
!50 = !DILocation(line: 63, column: 35, scope: !4)
!51 = !DILocation(line: 63, column: 18, scope: !4)
!52 = !DILocation(line: 64, column: 37, scope: !4)
!53 = !DILocation(line: 64, column: 20, scope: !4)
!54 = !DILocation(line: 64, column: 35, scope: !4)
!55 = !DILocation(line: 64, column: 18, scope: !4)
!56 = !DILocation(line: 65, column: 36, scope: !4)
!57 = !DILocation(line: 65, column: 20, scope: !4)
!58 = !DILocation(line: 65, column: 34, scope: !4)
!59 = !DILocation(line: 65, column: 18, scope: !4)
!60 = !DILocation(line: 66, column: 36, scope: !4)
!61 = !DILocation(line: 66, column: 20, scope: !4)
!62 = !DILocation(line: 66, column: 34, scope: !4)
!63 = !DILocation(line: 66, column: 18, scope: !4)
!64 = !DILocation(line: 67, column: 3, scope: !4)
!65 = !DILocation(line: 68, column: 17, scope: !4)
!66 = !DILocation(line: 68, column: 27, scope: !4)
!67 = !DILocation(line: 68, column: 37, scope: !4)
!68 = !DILocation(line: 68, column: 47, scope: !4)
!69 = !DILocation(line: 68, column: 16, scope: !4)
!70 = !DILocation(line: 68, column: 66, scope: !4)
!71 = !DILocation(line: 68, column: 82, scope: !4)
!72 = !DILocation(line: 68, column: 65, scope: !4)
!73 = !DILocation(line: 68, column: 57, scope: !4)
!74 = !DILocation(line: 69, column: 10, scope: !4)
!75 = !DILocation(line: 69, column: 21, scope: !4)
!76 = !DILocation(line: 69, column: 32, scope: !4)
!77 = !DILocation(line: 69, column: 43, scope: !4)
!78 = !DILocation(line: 69, column: 9, scope: !4)
!79 = !DILocation(line: 68, column: 124, scope: !4)
!80 = !DILocation(line: 69, column: 63, scope: !4)
!81 = !DILocation(line: 69, column: 79, scope: !4)
!82 = !DILocation(line: 69, column: 95, scope: !4)
!83 = !DILocation(line: 69, column: 108, scope: !4)
!84 = !DILocation(line: 69, column: 62, scope: !4)
!85 = !DILocation(line: 69, column: 54, scope: !4)
!86 = !DILocation(line: 70, column: 11, scope: !4)
!87 = !DILocation(line: 70, column: 45, scope: !4)
!88 = !DILocation(line: 70, column: 48, scope: !4)
!89 = !DILocation(line: 69, column: 121, scope: !4)
!90 = !DILocation(line: 70, column: 80, scope: !4)
!91 = !DILocation(line: 70, column: 83, scope: !4)
!92 = !DILocation(line: 70, column: 105, scope: !4)
!93 = !DILocation(line: 70, column: 108, scope: !4)
!94 = !DILocation(line: 70, column: 71, scope: !4)
!95 = !DILocation(line: 70, column: 63, scope: !4)
!96 = !DILocation(line: 71, column: 1, scope: !4)
!97 = !DILocation(line: 68, column: 3, scope: !4)
