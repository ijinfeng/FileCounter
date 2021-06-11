//
//  File.swift
//  proj_file_counter
//
//  Created by jinfeng on 2021/6/10.
//

import Foundation

extension String {
    
    /// 判断是否是文件夹
    /// - Returns: bool
    func isDirectory() -> Bool {
        do {
            let att = try FileManager.default.attributesOfItem(atPath: self) as NSDictionary
            if att.fileType() == FileAttributeType.typeDirectory.rawValue {
                return true
            }
        } catch {
            
        }
        return false
//        if self.count == 0 {return false}
//        let isdir = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
//        isdir.pointee = false
//        FileManager.default.fileExists(atPath: self, isDirectory: isdir)
//        return isdir.pointee.boolValue
    }
    
    /// 给定路径，获取当前路径下的文件名或目录名
    /// - Returns: 名字
    func name() -> String {
        guard let url = URL(string: self) else {
            return ""
        }
        return url.lastPathComponent
    }
    
    /// 获取文件的后缀
    /// - Returns: 后缀
    func extname() -> String {
        let url = URL(string: self)
        return url?.pathExtension ?? ""
    }
}

enum ItemType {
    ///Objective-C .h/.m/.mm
    case oc
    /// swift .swift
    case swift
    /// C/C++ .c/.cpp/.hpp
    case c
    /// ruby .rb
    case ruby
    /// shell .sh
    case shell
    ///java .java
    case java
    case other
}

postfix operator +=

struct CodeLanguage {
    var itemType: ItemType = .other
    var name: String {
        switch itemType {
        case .oc:
            return "Objective-C"
        case .swift:
            return "Swift"
        case .c:
            return "C/C++"
        case .ruby:
            return "Ruby"
        case .shell:
            return "Shell"
        case .java:
            return "Java"
        default:
            return "Other"
        }
    }
    var count: Int = 0

    static func +=( lhs: inout CodeLanguage, rhs: Int) {
        lhs.count = lhs.count + rhs
    }
}

struct FileItem {
    var name: String
    var absolutePath: String
    var itemType: ItemType = .other
}

func currentPath() -> String {
    FileManager.default.currentDirectoryPath
}

/// 列出当前目录下的所有文件和目录
/// - Parameter path: 目录地址
/// - Returns: [name]
func list(path: String) throws -> [FileItem] {
    let l = try FileManager.default.subpathsOfDirectory(atPath: path)
    var items = [FileItem]()
    for p in l {
        if p.isDirectory() {
            continue
        }
        
        let url = URL(string: path)?.appendingPathComponent(p)
        let absolutePath = url?.path ?? "\(path)\\\(p)"
        var item = FileItem(name: p.name(), absolutePath: absolutePath)
        
        let extname = absolutePath.extname()
        switch extname {
        case "h","m", "mm":
            item.itemType = .oc
        case "swift":
            item.itemType = .swift
        case "c", "hpp", "cpp":
            item.itemType = .c
        case "rb":
            item.itemType = .ruby
        case "sh":
            item.itemType = .shell
        case "java":
            item.itemType = .java
        default:
            item.itemType = .other
        }
        
        items.append(item)
    }
    return items
}
