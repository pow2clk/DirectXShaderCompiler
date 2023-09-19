; RUN: %dxv %s | FileCheck %s

; Test that all valid entry functions with valid numthreads are accepted

; CHECK: Validation succeeded.

target datalayout = "e-m:e-p:32:32-i1:32-i8:32-i16:32-i32:32-i64:64-f16:32-f32:32-f64:64-n8:16:32:64"
target triple = "dxil-ms-dx"

%dx.types.Handle = type { i8* }
%dx.types.ResourceProperties = type { i32, i32 }
%dx.types.CBufRet.f32 = type { float, float, float, float }
%struct.payload_t = type { i32 }
%dx.types.NodeRecordHandle = type { i8* }
%dx.types.NodeRecordInfo = type { i32, i32 }
%struct.RECORD = type { i32 }
%"class.RWStructuredBuffer<vector<float, 4> >" = type { <4 x float> }
%"$Globals" = type { <4 x float> }

@"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A" = external constant %dx.types.Handle, align 4
@"$Globals" = external constant %dx.types.Handle

define void @CSMain() {
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"$Globals", align 4
  %3 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)  ; CreateHandleForLib(Resource)
  %4 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %5 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %6 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %4, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %7 = extractvalue %dx.types.CBufRet.f32 %6, 0
  %8 = extractvalue %dx.types.CBufRet.f32 %6, 1
  %9 = extractvalue %dx.types.CBufRet.f32 %6, 2
  %10 = extractvalue %dx.types.CBufRet.f32 %6, 3
  %11 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)  ; CreateHandleForLib(Resource)
  %12 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %11, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %12, i32 %5, i32 0, float %7, float %8, float %9, float %10, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

define void @ASMain() {
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"$Globals", align 4
  %3 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)  ; CreateHandleForLib(Resource)
  %4 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %5 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %6 = alloca %struct.payload_t, align 4
  %7 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %4, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %8 = extractvalue %dx.types.CBufRet.f32 %7, 0
  %9 = extractvalue %dx.types.CBufRet.f32 %7, 1
  %10 = extractvalue %dx.types.CBufRet.f32 %7, 2
  %11 = extractvalue %dx.types.CBufRet.f32 %7, 3
  %12 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)  ; CreateHandleForLib(Resource)
  %13 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %12, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %13, i32 %5, i32 0, float %8, float %9, float %10, float %11, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  %14 = bitcast %struct.payload_t* %6 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %14) #0
  %15 = getelementptr inbounds %struct.payload_t, %struct.payload_t* %6, i32 0, i32 0
  store i32 0, i32* %15, align 4, !tbaa !34
  call void @dx.op.dispatchMesh.struct.payload_t(i32 173, i32 1, i32 1, i32 1, %struct.payload_t* nonnull %6)  ; DispatchMesh(threadGroupCountX,threadGroupCountY,threadGroupCountZ,payload)
  call void @llvm.lifetime.end(i64 4, i8* %14) #0
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #0

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #0

define void @MSMain() {
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"$Globals", align 4
  %3 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)  ; CreateHandleForLib(Resource)
  %4 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %5 = call i32 @dx.op.flattenedThreadIdInGroup.i32(i32 96)  ; FlattenedThreadIdInGroup()
  %6 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %4, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %7 = extractvalue %dx.types.CBufRet.f32 %6, 0
  %8 = extractvalue %dx.types.CBufRet.f32 %6, 1
  %9 = extractvalue %dx.types.CBufRet.f32 %6, 2
  %10 = extractvalue %dx.types.CBufRet.f32 %6, 3
  %11 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)  ; CreateHandleForLib(Resource)
  %12 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %11, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %12, i32 %5, i32 0, float %7, float %8, float %9, float %10, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

define void @NDMain() {
  %1 = load %dx.types.Handle, %dx.types.Handle* @"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A", align 4
  %2 = load %dx.types.Handle, %dx.types.Handle* @"$Globals", align 4
  %3 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %2)  ; CreateHandleForLib(Resource)
  %4 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %3, %dx.types.ResourceProperties { i32 13, i32 16 })  ; AnnotateHandle(res,props)  resource: CBuffer
  %5 = call %dx.types.NodeRecordHandle @dx.op.createNodeInputRecordHandle(i32 250, i32 0)  ; CreateNodeInputRecordHandle(MetadataIdx)
  %6 = call %dx.types.NodeRecordHandle @dx.op.annotateNodeRecordHandle(i32 251, %dx.types.NodeRecordHandle %5, %dx.types.NodeRecordInfo { i32 97, i32 4 })  ; AnnotateNodeRecordHandle(noderecord,props)
  %7 = call %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32 59, %dx.types.Handle %4, i32 0)  ; CBufferLoadLegacy(handle,regIndex)
  %8 = extractvalue %dx.types.CBufRet.f32 %7, 0
  %9 = extractvalue %dx.types.CBufRet.f32 %7, 1
  %10 = extractvalue %dx.types.CBufRet.f32 %7, 2
  %11 = extractvalue %dx.types.CBufRet.f32 %7, 3
  %12 = call %struct.RECORD addrspace(6)* @dx.op.getNodeRecordPtr.struct.RECORD(i32 239, %dx.types.NodeRecordHandle %6, i32 0)  ; GetNodeRecordPtr(recordhandle,arrayIndex)
  %13 = getelementptr %struct.RECORD, %struct.RECORD addrspace(6)* %12, i32 0, i32 0
  %14 = load i32, i32 addrspace(6)* %13, align 4
  %15 = call %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32 160, %dx.types.Handle %1)  ; CreateHandleForLib(Resource)
  %16 = call %dx.types.Handle @dx.op.annotateHandle(i32 216, %dx.types.Handle %15, %dx.types.ResourceProperties { i32 4108, i32 16 })  ; AnnotateHandle(res,props)  resource: RWStructuredBuffer<stride=16>
  call void @dx.op.rawBufferStore.f32(i32 140, %dx.types.Handle %16, i32 %14, i32 0, float %8, float %9, float %10, float %11, i8 15, i32 4)  ; RawBufferStore(uav,index,elementOffset,value0,value1,value2,value3,mask,alignment)
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @dx.op.flattenedThreadIdInGroup.i32(i32) #1

; Function Attrs: nounwind readnone
declare %struct.RECORD addrspace(6)* @dx.op.getNodeRecordPtr.struct.RECORD(i32, %dx.types.NodeRecordHandle, i32) #1

; Function Attrs: nounwind
declare void @dx.op.rawBufferStore.f32(i32, %dx.types.Handle, i32, i32, float, float, float, float, i8, i32) #0

; Function Attrs: nounwind
declare void @dx.op.dispatchMesh.struct.payload_t(i32, i32, i32, i32, %struct.payload_t*) #0

; Function Attrs: nounwind readonly
declare %dx.types.CBufRet.f32 @dx.op.cbufferLoadLegacy.f32(i32, %dx.types.Handle, i32) #2

; Function Attrs: nounwind readnone
declare %dx.types.Handle @dx.op.annotateHandle(i32, %dx.types.Handle, %dx.types.ResourceProperties) #1

; Function Attrs: nounwind readnone
declare %dx.types.NodeRecordHandle @dx.op.createNodeInputRecordHandle(i32, i32) #1

; Function Attrs: nounwind readnone
declare %dx.types.NodeRecordHandle @dx.op.annotateNodeRecordHandle(i32, %dx.types.NodeRecordHandle, %dx.types.NodeRecordInfo) #1

; Function Attrs: nounwind readonly
declare %dx.types.Handle @dx.op.createHandleForLib.dx.types.Handle(i32, %dx.types.Handle) #2

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }

!llvm.ident = !{!0}
!dx.version = !{!1}
!dx.valver = !{!1}
!dx.shaderModel = !{!2}
!dx.resources = !{!3}
!dx.typeAnnotations = !{!9}
!dx.entryPoints = !{!13, !15, !20, !23, !26}

!0 = !{!"dxc(private) 1.7.0.4084 (merge-staging, e7bbd882e-dirty)"}
!1 = !{i32 1, i32 8}
!2 = !{!"lib", i32 6, i32 8}
!3 = !{null, !4, !7, null}
!4 = !{!5}
!5 = !{i32 0, %"class.RWStructuredBuffer<vector<float, 4> >"* bitcast (%dx.types.Handle* @"\01?output@@3V?$RWStructuredBuffer@V?$vector@M$03@@@@A" to %"class.RWStructuredBuffer<vector<float, 4> >"*), !"output", i32 -1, i32 -1, i32 1, i32 12, i1 false, i1 false, i1 false, !6}
!6 = !{i32 1, i32 16}
!7 = !{!8}
!8 = !{i32 0, %"$Globals"* bitcast (%dx.types.Handle* @"$Globals" to %"$Globals"*), !"$Globals", i32 0, i32 -1, i32 1, i32 16, null}
!9 = !{i32 1, void ()* @CSMain, !10, void ()* @ASMain, !10, void ()* @MSMain, !10, void ()* @NDMain, !10}
!10 = !{!11}
!11 = !{i32 0, !12, !12}
!12 = !{}
!13 = !{null, !"", null, !3, !14}
!14 = !{i32 0, i64 8590000144}
!15 = !{void ()* @ASMain, !"ASMain", null, null, !16}
; arg1 = kDxilShaderKindTag(8)
; arg3 = kDxilASStateTag(10)
!16 = !{i32 8, i32 14, i32 10, !17, i32 5, !19}
; arg1 = kDxilASStateNumThreads node (!18)
; arg2 = kDxilASStatePayloadSizeInBytes (4)
!17 = !{!18, i32 4}
!18 = !{i32 8, i32 8, i32 2}
!19 = !{i32 0}
!20 = !{void ()* @CSMain, !"CSMain", null, null, !21}
; arg1 = kDxilShaderKindTag(8)
; arg3 = kDxilNumThreadsTag(4)
!21 = !{i32 8, i32 5, i32 4, !22, i32 5, !19}
!22 = !{i32 32, i32 32, i32 1}
!23 = !{void ()* @MSMain, !"MSMain", null, null, !24}
; arg1 = kDxilShaderKindTag(8)
; arg3 = kDxilMSStateTag(9)
!24 = !{i32 8, i32 13, i32 9, !25, i32 5, !19}
; arg1 = kDxilMSStateNumThreads node (!18)
; arg2 = kDxilMSStateMaxVertexCount (0)
; arg3 = kDxilMSStateMaxPrimitiveCount(0)
; arg4 = kDxilMSStateOutputTopology(Triangle(2))
; arg5 = kDxilMSStatePayloadSizeInBytes(0)
!25 = !{!18, i32 0, i32 0, i32 2, i32 0}
!26 = !{void ()* @NDMain, !"NDMain", null, null, !27}
; arg1 = kDxilShaderKindTag(8)
; arg3 = kDxilNodeLaunchTypeTag (13)
; arg5 = kDxilNodeIdTag(15)
; arg7 = kDxilNodeLocalRootArgumentsTableIndexTag(16)
; arg9 = kDxilNodeDispatchGridTag(18)
; arg11 = kDxilNodeInputsTag(20)
; arg13 = kDxilNumThreadsTag(4)
!27 = !{i32 8, i32 15, i32 13, i32 1, i32 15, !28, i32 16, i32 -1, i32 18, !29, i32 20, !30, i32 4, !33, i32 5, !19}
!28 = !{!"NDMain", i32 0}
!29 = !{i32 16, i32 1, i32 1}
!30 = !{!31}
!31 = !{i32 1, i32 97, i32 2, !32}
!32 = !{i32 0, i32 4}
!33 = !{i32 1024, i32 1, i32 1}
!34 = !{!35, !35, i64 0}
!35 = !{!"int", !36, i64 0}
!36 = !{!"omnipotent char", !37, i64 0}
!37 = !{!"Simple C/C++ TBAA"}

