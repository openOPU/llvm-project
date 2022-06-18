//===-- RISCVInstrFormatsXopu.td - RISCV Xopu Instruction Formats --*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//  This file describes the RISC-V Xopu extension instruction formats.
//
//===----------------------------------------------------------------------===//


class RISCVXopuMKind<bits<2> val> {
  bits<2> Value = val;
} 
def MKINDC : RISCVXopuMKind<0b01>;
def MKINDB : RISCVXopuMKind<0b10>;
def MKINDA : RISCVXopuMKind<0b11>;

class RISCVXopuMDim<bits<2> val> {
  bits<2> Value = val;
}
def MDIMM : RISCVXopuMDim<0b00>;
def MDIMK : RISCVXopuMDim<0b01>;
def MDIMN : RISCVXopuMDim<0b10>;

class RISCVXopuMOp<bits<2> val> {
  bits<2> Value = val;
}
def MOPP : RISCVXopuMOp<0b00>; 
def MOPSP : RISCVXopuMOp<0b01>; 
def MOPSR : RISCVXopuMOp<0b10>; 
def MOPSC : RISCVXopuMOp<0b11>; 


class RVInstMSetType<bit half, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> rd;
  bits<5> rs1;

  let Inst{31-29} = 0b111;
  let Inst{28-26} = 0b000;
  let Inst{25} = half;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = rd;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMDim<bits<2> f2, RISCVXopuMDim dim, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> rd;
  bits<5> rs1;

  let Inst{31-29} = 0b111;
  let Inst{28-27} = f2;
  let Inst{26-25} = dim.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = rd;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMLP<RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> rs1;

  let Inst{31-29} = 0b000;
  let Inst{28-27} = MOPP.Value;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMLS<RISCVXopuMOp mop, RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> rs1;
  bits<5> rs2;

  let Inst{31-29} = 0b000;
  let Inst{28-27} = mop.Value;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}


class RVInstMSP<RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> ms3;
  bits<5> rs1;

  let Inst{31-29} = 0b001;
  let Inst{28-27} = MOPP.Value;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = ms3;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMSS<RISCVXopuMOp mop, RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> ms3;
  bits<5> rs1;
  bits<5> rs2;

  let Inst{31-29} = 0b001;
  let Inst{28-27} = mop.Value;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = ms3;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMM<bit acc, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> ms1;
  bits<5> ms2;

  let Inst{31-29} = 0b010;
  let Inst{28-26} = 0b000;
  let Inst{25} = acc;
  let Inst{24-20} = ms2;
  let Inst{19-15} = ms1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMMV<RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> ms1;

  let Inst{31-29} = 0b011;
  let Inst{28-27} = 0b00;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = ms1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMSlideMV<bit dir, RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> vs1;

  let Inst{31-29} = 0b100;
  let Inst{28} = 0;
  let Inst{27} = dir;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = vs1;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}

class RVInstMSlideVM<bit dir, RISCVXopuMKind mkind, dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> md;
  bits<5> vd;

  let Inst{31-29} = 0b100;
  let Inst{28} = 1;
  let Inst{27} = dir;
  let Inst{26-25} = mkind.Value;
  let Inst{24-20} = 0b00000;
  let Inst{19-15} = vd;
  let Inst{14-12} = 0b000;
  let Inst{11-7} = md;
  let Opcode = OPC_XOPU.Value;
}

