
class RVInst16<dag outs, dag ins, string opcodestr, string argstr,
               list<dag> pattern, InstFormat format>
    : Instruction {
  field bits<16> Inst;
  field bits<16> SoftFail = 0;
  let Size = 2;
  bits<2> Opcode = 0;
  let Namespace = "RISCV";
  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString = opcodestr # "\t" # argstr;
  let Pattern = pattern;
  let TSFlags{4-0} = format.Value;
}

// CR: Register. 
class RVInst16CR<bits<4> funct4, bits<2> op, dag outs, dag ins, string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCR> {
  bits<5> rs1;
  bits<5> rs2;

  let Inst{15-12} = funct4;
  let Inst{11-7} = rs1;
  let Inst{6-2} = rs2;
  let Inst{1-0} = op;
}

// CI: Immediate
class RVInst16CI<bits<3> funct3, bits<2> op, dag outs, dag ins,string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCI> {
  bits<10> imm;
  bits<5> rd;
  bits<5> rs1;

  let Inst{15-13} = funct3;
  let Inst{12} = imm{5};
  let Inst{11-7} = rd;
  let Inst{1-0} = op;
}

// CSS: Stack-relative Store
class RVInst16CSS<bits<3> funct3, bits<2> op, dag outs, dag ins, string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCSS> {
  bits<10> imm;
  bits<5> rs2;
  bits<5> rs1;

  let Inst{15-13} = funct3;
  // let Inst {12-7} = imm; 
  let Inst{6-2} = rs2;
  let Inst{1-0} = op;
}

// CIW: Wide Immediate
class RVInst16CIW<bits<3> funct3, bits<2> op, dag outs, dag ins, string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCIW> {
  bits<10> imm;
  bits<3> rd;

  let Inst{15-13} = funct3;
  let Inst{4-2} = rd;
  let Inst{1-0} = op;
}


// CL: Load
class RVInst16CL<bits<3> funct3, bits<2> op, dag outs, dag ins,string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCL> {
  bits<3> rd;
  bits<3> rs1;

  let Inst{15-13} = funct3;
  // let Inst{12-10} = imm;
  let Inst{9-7} = rs1;
  // let Inst{6-5} = imm;
  let Inst{4-2} = rd;
  let Inst{1-0} = op;
}

// CS: Store
class RVInst16CS<bits<3> funct3, bits<2> op, dag outs, dag ins,string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCS> {
  bits<3> rs2;
  bits<3> rs1;

  let Inst{15-13} = funct3;
  // let Inst{12-10} = imm;
  let Inst{9-7} = rs1;
  // let Inst{5-6} = imm;
  let Inst{4-2} = rs2;
  let Inst{1-0} = op;
}

// CB: Branch 
class RVInst16CB<bits<3> funct3, bits<2> op, dag outs, dag ins,string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCB> {
  bits<9> imm;
  bits<3> rs1;

  let Inst{15-13} = funct3;
  // let Inst{12-10} = offset;
  let Inst{9-7} = rs1;
  // let Inst{12-10} = offset;
  let Inst{1-0} = op;
}

// CJ: Jump
class RVInst16CJ<bits<3> funct3, bits<2> op, dag outs, dag ins,string opcodestr, string argstr> : RVInst16<outs, ins, opcodestr, argstr, [], InstFormatCJ> {
  bits<11> jumptgt;

  let Inst{15-13} = funct3;
  let Inst{12-2} = jumptgt;
  let Inst{1-0} = op;
}
