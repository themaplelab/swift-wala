//===--- ProgramContext.java ---------------------------------------------===//
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

package ca.maple.swan.swift.translator.silir.context;

import ca.maple.swan.swift.translator.raw.InstructionNode;
import ca.maple.swan.swift.translator.silir.BasicBlock;
import ca.maple.swan.swift.translator.silir.Function;
import ca.maple.swan.swift.translator.silir.values.ValueTable;

import java.util.ArrayList;
import java.util.HashMap;

/*
 * Holds anything a program would need for translation.
 */

public class ProgramContext {

    private HashMap<String, Function> allFunctions;
    public HashMap<BasicBlock, ArrayList<InstructionNode>> toTranslate;

    public ValueTable globalValues = new ValueTable();

    public ProgramContext(HashMap<BasicBlock, ArrayList<InstructionNode>> toTranslate) {
        this.allFunctions = new HashMap<>();
        this.toTranslate = toTranslate;
    }

    public void addFunction(String s, Function f) {
        allFunctions.put(s, f);
    }

    public Function getFunction(String s) {
        if (allFunctions.containsKey(s)) {
            return allFunctions.get(s);
        }
        return null;
    }

    public ArrayList<Function> getFunctions() {
        ArrayList<Function> functions = new ArrayList<>();
        for (String s : allFunctions.keySet()) {
            functions.add(allFunctions.get(s));
        }
        return functions;
    }

    public void printFunctions() {
        System.out.println("/=======================SILIR=============================");
        for (Function f : getFunctions()) {
            System.out.println(f);
        }
        System.out.println("=========================================================\\");

    }
}