//===-- RISCVInstrInfoXopu.td - RISC-V 'Xopu' instructions -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// This file describes the RISC-V instructions from the 'Xopu' extension,
/// version 0.4-draft.
///
//===----------------------------------------------------------------------===//

include "RISCVInstrFormatsXopu.td"


let 
  Predicates = [HasExtXopu], 
  hasSideEffects = 0
in {

let mayLoad = 0,  mayStore = 0 in {

def MSETTYPE  : RVInstMSetType<0, (outs GPR:$rd), (ins GPR:$rs1), "msettype", "$rd, $rs1">;
def MSETTYPEH : RVInstMSetType<1, (outs GPR:$rd), (ins GPR:$rs1), "msettypeh", "$rd, $rs1">;

def MSETDIMM : RVInstMDim<0b01, MDIMM, (outs GPR:$rd), (ins GPR:$rs1), "msetdimm", "$rd, $rs1">;
def MSETDIMK : RVInstMDim<0b01, MDIMK, (outs GPR:$rd), (ins GPR:$rs1), "msetdimk", "$rd, $rs1">;
def MSETDIMN : RVInstMDim<0b01, MDIMN, (outs GPR:$rd), (ins GPR:$rs1), "msetdimn", "$rd, $rs1">;

def MMULDIMM : RVInstMDim<0b10, MDIMM, (outs GPR:$rd), (ins GPR:$rs1), "mmuldimm", "$rd, $rs1">;
def MMULDIMK : RVInstMDim<0b10, MDIMK, (outs GPR:$rd), (ins GPR:$rs1), "mmuldimk", "$rd, $rs1">;
def MMULDIMN : RVInstMDim<0b10, MDIMN, (outs GPR:$rd), (ins GPR:$rs1), "mmuldimn", "$rd, $rs1">;

def MM_CAB : RVInstMM<0, (outs MR:$md), (ins MR:$ms1, MR:$ms2), "mm.cab", "$md, $ms1, $ms2">;
def MMACC_CAB : RVInstMM<1, (outs MR:$md), (ins MR:$ms1, MR:$ms2), "mmacc.cab", "$md, $ms1, $ms2">;

def MMV_A : RVInstMMV<MKINDA, (outs MR:$md), (ins MR:$ms1), "mmv.a", "$md, $ms1">;
def MMV_B : RVInstMMV<MKINDB, (outs MR:$md), (ins MR:$ms1), "mmv.b", "$md, $ms1">;
def MMV_C : RVInstMMV<MKINDC, (outs MR:$md), (ins MR:$ms1), "mmv.c", "$md, $ms1">;

def MSLIDEFORWARD_AV : RVInstMSlideMV<0, MKINDA, (outs MR:$md), (ins VR:$vs1), "mslideforward.av", "$md, $vs1">;
def MSLIDEFORWARD_BV : RVInstMSlideMV<0, MKINDB, (outs MR:$md), (ins VR:$vs1), "mslideforward.bv", "$md, $vs1">;
def MSLIDEFORWARD_CV : RVInstMSlideMV<0, MKINDC, (outs MR:$md), (ins VR:$vs1), "mslideforward.cv", "$md, $vs1">;
def MSLIDEBACKWARD_AV : RVInstMSlideMV<1, MKINDA, (outs MR:$md), (ins VR:$vs1), "mslidebackward.av", "$md, $vs1">;
def MSLIDEBACKWARD_BV : RVInstMSlideMV<1, MKINDB, (outs MR:$md), (ins VR:$vs1), "mslidebackward.bv", "$md, $vs1">;
def MSLIDEBACKWARD_CV : RVInstMSlideMV<1, MKINDC, (outs MR:$md), (ins VR:$vs1), "mslidebackward.cv", "$md, $vs1">;

def MSLIDEFORWARD_VA : RVInstMSlideVM<0, MKINDA, (outs MR:$md, VR:$vd), (ins), "mslideforward.va", "$vd, $md">;
def MSLIDEFORWARD_VB : RVInstMSlideVM<0, MKINDB, (outs MR:$md, VR:$vd), (ins), "mslideforward.vb", "$vd, $md">;
def MSLIDEFORWARD_VC : RVInstMSlideVM<0, MKINDC, (outs MR:$md, VR:$vd), (ins), "mslideforward.vc", "$vd, $md">;
def MSLIDEBACKWARD_VA : RVInstMSlideVM<1, MKINDA, (outs MR:$md, VR:$vd), (ins), "mslidebackward.va", "$vd, $md">;
def MSLIDEBACKWARD_VB : RVInstMSlideVM<1, MKINDB, (outs MR:$md, VR:$vd), (ins), "mslidebackward.vb", "$vd, $md">;
def MSLIDEBACKWARD_VC : RVInstMSlideVM<1, MKINDC, (outs MR:$md, VR:$vd), (ins), "mslidebackward.vc", "$vd, $md">;

} // mayLoad = 0, mayStore = 0

let mayLoad = 1, mayStore = 0 in {

def MLP_A : RVInstMLP<MKINDA, (outs MR:$md), (ins GPR:$rs1), "mlp.a", "$md, (${rs1})">;
def MLP_B : RVInstMLP<MKINDB, (outs MR:$md), (ins GPR:$rs1), "mlp.b", "$md, (${rs1})">;
def MLP_C : RVInstMLP<MKINDC, (outs MR:$md), (ins GPR:$rs1), "mlp.c", "$md, (${rs1})">;

def MLSP_A : RVInstMLS<MOPSP, MKINDA, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsp.a", "$md, (${rs1}), $rs2">;
def MLSP_B : RVInstMLS<MOPSP, MKINDB, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsp.b", "$md, (${rs1}), $rs2">;
def MLSP_C : RVInstMLS<MOPSP, MKINDC, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsp.c", "$md, (${rs1}), $rs2">;

def MLSC_A : RVInstMLS<MOPSC, MKINDA, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsc.a", "$md, (${rs1}), $rs2">;
def MLSC_B : RVInstMLS<MOPSC, MKINDB, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsc.b", "$md, (${rs1}), $rs2">;
def MLSC_C : RVInstMLS<MOPSC, MKINDC, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsc.c", "$md, (${rs1}), $rs2">;

def MLSR_A : RVInstMLS<MOPSR, MKINDA, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsr.a", "$md, (${rs1}), $rs2">;
def MLSR_B : RVInstMLS<MOPSR, MKINDB, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsr.b", "$md, (${rs1}), $rs2">;
def MLSR_C : RVInstMLS<MOPSR, MKINDC, (outs MR:$md), (ins GPR:$rs1, GPR:$rs2), "mlsr.c", "$md, (${rs1}), $rs2">;

} // mayLoad = 1, mayStore = 0

let mayLoad = 0, mayStore = 1 in {

def MSP_A : RVInstMSP<MKINDA, (outs), (ins MR:$ms3, GPR:$rs1), "msp.a", "$ms3, (${rs1})">;
def MSP_B : RVInstMSP<MKINDB, (outs), (ins MR:$ms3, GPR:$rs1), "msp.b", "$ms3, (${rs1})">;
def MSP_C : RVInstMSP<MKINDC, (outs), (ins MR:$ms3, GPR:$rs1), "msp.c", "$ms3, (${rs1})">;

def MSSP_A : RVInstMSS<MOPSP, MKINDA, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssp.a", "$ms3, (${rs1}), $rs2">;
def MSSP_B : RVInstMSS<MOPSP, MKINDB, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssp.b", "$ms3, (${rs1}), $rs2">;
def MSSP_C : RVInstMSS<MOPSP, MKINDC, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssp.c", "$ms3, (${rs1}), $rs2">;

def MSSC_A : RVInstMSS<MOPSC, MKINDA, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssc.a", "$ms3, (${rs1}), $rs2">;
def MSSC_B : RVInstMSS<MOPSC, MKINDB, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssc.b", "$ms3, (${rs1}), $rs2">;
def MSSC_C : RVInstMSS<MOPSC, MKINDC, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssc.c", "$ms3, (${rs1}), $rs2">;

def MSSR_A : RVInstMSS<MOPSR, MKINDA, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssr.a", "$ms3, (${rs1}), $rs2">;
def MSSR_B : RVInstMSS<MOPSR, MKINDB, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssr.b", "$ms3, (${rs1}), $rs2">;
def MSSR_C : RVInstMSS<MOPSR, MKINDC, (outs), (ins MR:$ms3, GPR:$rs1, GPR:$rs2), "mssr.c", "$ms3, (${rs1}), $rs2">;

} // mayLoad = 0, mayStore = 1

}
