//===--- InfoStructures.hpp - Information across translation -------------===//
//
// This source file is part of the SWAN open source project
//
// Copyright (c) 2019 Maple @ University of Alberta
// All rights reserved. This program and the accompanying materials (unless
// otherwise specified by a license inside of the accompanying material)
// are made available under the terms of the Eclipse Public License v2.0
// which accompanies this distribution, and is available at
// http://www.eclipse.org/legal/epl-v20.html
//
//===---------------------------------------------------------------------===//
///
/// This file defines various Info structures used by the translator and
/// WALAInstance to keep track of information across functions, blocks, etc.
///
//===---------------------------------------------------------------------===//

#ifndef SWAN_INFOSTRUCTURES_HPP
#define SWAN_INFOSTRUCTURES_HPP

#include "swift/SIL/ApplySite.h"
#include "swift/SIL/SILVisitor.h"
#include <jni.h>

using namespace swift;

namespace swift_wala {

/// ModuleInfo is used for storing source information into the CAst.
struct ModuleInfo {
    explicit ModuleInfo(llvm::StringRef sourcefile) : sourcefile(sourcefile) {};
    llvm::StringRef sourcefile;
};

/// FunctionInfo is used for storing source information into the CAst.
struct FunctionInfo {
  FunctionInfo(llvm::StringRef name, llvm::StringRef demangled) : name(name), demangled(demangled) {};
  llvm::StringRef name;
  llvm::StringRef demangled;
};

/// InstrInfo is used for storing source information into the CAst.
struct InstrInfo {
  unsigned num;
  swift::SILPrintContext::ID id;
  swift::SILInstructionKind instrKind;

  swift::SILInstruction::MemoryBehavior memBehavior;
  swift::SILInstruction::ReleasingBehavior relBehavior;

  short srcType;
  std::string Filename;
  unsigned startLine;
  unsigned startCol;
  unsigned endLine;
  unsigned endCol;

  llvm::ArrayRef<swift::SILValue> ops;
  ModuleInfo *modInfo;
  FunctionInfo *funcInfo;
};

/// CAstEntityInfo is used to later build the CAstEntities. The translator populates this struct to avoid
/// traversing the whole AST later to build the scopedEntities map and create the CAstControlFlowMap.
struct CAstEntityInfo {
  std::string functionName; // This should be "main" for the SCRIPT_ENTITY.
  std::vector<jobject> basicBlocks; // Every basic block belonging to this entity.
  std::vector<jobject> callNodes; // Instructions that call other functions (entities).
  std::vector<jobject> cfNodes; // Instructions that impact intra-function control flow.

  void print() {
    llvm::outs() << "-*- CAST ENTITY INFO -*-" << "\n";
    llvm::outs() << "\tFUNCTION NAME: " << functionName << "\n";
    // If we print the blocks using CAstWrapper, they won't print where expected to the terminal.
    // There is probably a way to solve this but is not necessary for now.
    llvm::outs() << "\t# OF BASIC BLOCKS: " << basicBlocks.size() << "\n";
    llvm::outs() << "\t# OF CALL NODES: " << callNodes.size() << "\n";
    llvm::outs() << "\t# OF CONTROL FLOW NODES: " << cfNodes.size() << "\n";
  }
};

} // end swift_wala namespace

#endif // SWAN_INFOSTRUCTURES_HPP