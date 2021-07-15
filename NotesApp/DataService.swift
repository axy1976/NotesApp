//
//  dataService.swift
//  NotesApp
//
//  Created by Akshay Jangir on 11/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import Foundation

class DataService
{
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc directory url is \(paths[0])")
        return paths[0]
    }
}
