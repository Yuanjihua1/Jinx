//
//  main.swift
//  Jinx
//
//  Created by ZhangJing on 2017/5/16.
//  Copyright © 2017年 xiuye. All rights reserved.
//

import Foundation

enum Operation: String {
    case create  = "c"
    case extract = "x"
    case list    = "l"
    case verify  = "v"
}


let cli = CommandLine()

let filePath = StringOption(shortFlag: "f", longFlag: "file", helpMessage: "Path to the output file.")
let compress = BoolOption(shortFlag: "c", longFlag: "compress",
                          helpMessage: "Use data compression.")
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")
let verbosity = CounterOption(shortFlag: "v", longFlag: "verbose",
                              helpMessage: "Print verbose messages. Specify multiple times to increase verbosity.")

let op = EnumOption<Operation>.init("o", nil, false, "File operation - c for create, x for extract, l for list, or v for verify.")

cli.addOptions(filePath, compress, help, verbosity , op)



cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.blue
    default:
        str = s
    }
    return cli.defaultFormat(s: str, type: type)
}


do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

func main(){
    
    var arguments = cli.unparsedArguments
    
    guard arguments.count >= 2 else { return }
    
    guard let ClassStr = arguments.first?.longString else { return }

    guard let Class = objc_getClass("Jinx.\(ClassStr)") as? NSObject.Type else { return }
    
    let obj = Class.init()
    
    let SelectorStr = arguments[1] + ":"
    
    let sel = NSSelectorFromString(SelectorStr)
    
    let arrSlice = arguments[2..<arguments.count]
    
    if obj.responds(to: sel) {
        obj.perform(sel, with: Array(arrSlice))
    }else{
        print("argument error")
    }
    
    
    
}

main()


