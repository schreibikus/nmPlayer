;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;@ʹ�þ���˷�ʵ�֣�
;@void IDST4X4(
;@							const short *pSrcData,
;@							const unsigned char *pPerdictionData,
;@							unsigned char *pDstRecoData,
;@							unsigned int uiDstStride)
;@ ������������˳���������飺
;@ short kg_IDST_coef_for_t4_asm[16] = 
;@ {
;@     29,55,74,84,  
;@     74,74,0,-74,    
;@     84,-29,-74,55,    
;@     55,-84,74,-29
;@ };
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		include		h265dec_ASM_config.h
        ;@include h265dec_idct_macro.inc
        area |.text|, code, readonly 
        align 4
        if IDCT_ASM_ENABLED==1   
        import kg_IDST_coef_for_t4_asm
        export IDST4X4ASMV7
      
        
IDST4X4ASMV7   
        
        vld1.16  {d0, d1, d2, d3}, [r0] 		;@ psrcdata:d0,d1,d2,d3??
        
        ldr       r12, = kg_IDST_coef_for_t4_asm
        vld1.16  {d14, d15, d16, d17}, [r12] 		;@ kg_IDST_coef_for_t4_asm
        
        vmull.s16 q4, d14, d0[0] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d1[0] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d2[0] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d3[0] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d4, q4, #7 						;@ ��һ��ѭ���ĵ�һ��
        
        vmull.s16 q4, d14, d0[1] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d1[1] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d2[1] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d3[1] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d5, q4, #7 						;@ ��һ��ѭ���ĵڶ���
        
        vmull.s16 q4, d14, d0[2] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d1[2] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d2[2] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d3[2] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d6, q4, #7 						;@ ��һ��ѭ���ĵ�һ��
        
        vmull.s16 q4, d14, d0[3] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d1[3] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d2[3] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d3[3] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d7, q4, #7 						;@ ��һ��ѭ���ĵ�һ��
        
        ;@ �ڶ���ѭ����Դ����Ϊd10,d11,d12,d13
        vmull.s16 q4, d14, d4[0] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d5[0] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d6[0] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d7[0] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d0, q4, #12 						;@ �任��Ĳв�ĵ�һ��
        
        vmull.s16 q4, d14, d4[1] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d5[1] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d6[1] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d7[1] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d1, q4, #12 						;@ �任��Ĳв�ĵڶ���
        
        vmull.s16 q4, d14, d4[2] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d5[2] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d6[2] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d7[2] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d2, q4, #12 						;@ �任��Ĳв�ĵ�����
        
        vmull.s16 q4, d14, d4[3] 						;@ ��һ�еĳ˷�
        vmlal.s16 q4, d15, d5[3] 						;@ ��һ�м��ϵڶ��еĳ˷�
        vmlal.s16 q4, d16, d6[3] 						;@ ���ϵ����г˷�
        vmlal.s16 q4, d17, d7[3] 						;@ ���ϵ����г˷�
        vqrshrn.s32 d3, q4, #12 						;@ �任��Ĳв�ĵ�����
        
        ;@ mov      r12, #PRED_CACHE_STRIDE 					;@uipredstride = 136
        mov      r12, r1						;@ predStride
        vld1.32  {d14[0]}, [r1], r2 			;@ pperdiction[0]
        vld1.32  {d14[1]}, [r1], r2 			;@ pperdiction[1]
        vld1.32  {d16[0]}, [r1], r2 			;@ pperdiction[2]
        vld1.32  {d16[1]}, [r1] 					;@ pperdiction[3]
        
        vaddw.u8    q12, q0, d14
        vaddw.u8    q13, q1, d16
        
        vqmovun.s16  d0, q12
        vqmovun.s16  d1, q13

        ;@ store the output data
        vst1.32      {d0[0]}, [r12],r2
        vst1.32      {d0[1]}, [r12],r2
        vst1.32      {d1[0]}, [r12],r2
        vst1.32      {d1[1]}, [r12]
        
        ;@ldmia sp!, {r4,r5,r12,pc}      
        mov pc, lr
        
        endif											;if IDCT_ASM_ENABLED==1
        end