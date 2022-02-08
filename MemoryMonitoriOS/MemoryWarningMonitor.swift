//
//  MemoryWarningMonitor.swift
//  MemoryMonitoriOS
//
//  Created by Jay GSDC on 2/9/22.
//

import Foundation

//Singleton class
class MemoryWarningMonitor{
    
    static let Instance = MemoryWarningMonitor()
    //var typesOfWarningsToMonitor : DispatchSource.MemoryPressureEvent = [.warning, .critical]
    
    private let memoryD = DispatchSource.makeMemoryPressureSource(eventMask: [.warning, .critical]);
    
    private init()
    {
        memoryD.setEventHandler{ [weak self] in
            if var event = self?.memoryD.data,
               self?.memoryD.isCancelled == false{
                switch event {
                case .warning:
                    print("WARNING : Low memory. Please clean up unnessary caches or other data that can be restored later")
                case .critical:
                    print("WARNING : Critical memory. Please clean up unnessary caches or other data that can be restored later")
                default:
                    print("No actions required")
                }
            }
        }
        
        memoryD.activate()
    }
    
    deinit {
        memoryD.cancel()
    }
}
