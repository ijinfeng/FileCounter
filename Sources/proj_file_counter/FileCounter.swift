//
//  FileCounter.swift
//  proj_file_counter
//
//  Created by jinfeng on 2021/6/10.
//

import Foundation
import ArgumentParser


struct FileCounter: ParsableCommand {
    /// 列出所有的文件占比
    @Argument(help: "List all files")
    var file: String?
    
    func run() throws {
        let root = currentPath()
        
        print(root)
        var total = 0
        var oc = CodeLanguage(itemType: .oc)
        var swift = CodeLanguage(itemType: .swift)
        var c = CodeLanguage(itemType: .c)
        var ruby = CodeLanguage(itemType: .ruby)
        var sh = CodeLanguage(itemType: .shell)
        var java = CodeLanguage(itemType: .java)
        var other = CodeLanguage(itemType: .other)
        
        do {
            let _l = try list(path: root)
            for item in _l {
                total += 1
                switch item.itemType {
                case .oc:
                    oc += 1
                case .swift:
                    swift += 1
                case .c:
                    c += 1
                case .ruby:
                    ruby += 1
                case .shell:
                    sh += 1
                case .java:
                    java += 1
                default:
                    other += 1
                }
            }
            
            print("Total \(total) files percentile：")
            let inputc = true
            let filter = file != nil

            var sorts = [oc, swift, c, ruby, java,sh, other]
            sorts.sort { (c1, c2) -> Bool in
                c1.count > c2.count
            }
            for c in sorts {
                let p = Float(c.count) / Float(total)
                
                if p == 0 {
                    continue
                }
                
                var pstr = "\(p * 100)"
                
                if pstr.contains(".") {
                    let parr = pstr.components(separatedBy: ".")
                    let last = parr.last ?? ""
                    if Int(last) != 0 {
                        var pindex = 1
                        for c in last {
                            if c == "0" {
                                pindex += 1
                            } else {
                                break
                            }
                        }
                        pstr = String(format: "%.\(pindex)f", p * 100)
                    } else {
                        pstr = parr.first ?? ""
                    }
                }
                
                var output = "\(c.name)"

                if filter {
                    if file!.lowercased() != c.name.lowercased() {
                        continue
                    }
                }

                if inputc {
                    output += " \(c.count)"
                }
                output += " "
                output += pstr
                output += "%"
                print(output)
            }
        }
    }
}


