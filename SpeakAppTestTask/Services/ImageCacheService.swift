//
//  ImageCacheService.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Kingfisher
import Foundation

protocol ImageCacheService: AnyObject {
    func clearCacheIfNeeded(maxMegabytesInMemory: Double)
}

final class ImageCacheDefaultService: ImageCacheService {
    private let cache = KingfisherManager.shared.cache
    
    func clearCacheIfNeeded(maxMegabytesInMemory: Double) {
        let usedMemoryMB = getUsedMemory()
        
        if usedMemoryMB > maxMegabytesInMemory {
            cache.clearMemoryCache()
            print("[ImageCacheService] Memory cache cleared due to high RAM usage.")
        }
    }
    
    private func getUsedMemory() -> Double {
        var taskInfo = task_vm_info()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        
        if result == KERN_SUCCESS {
            let usedMemory = Double(taskInfo.phys_footprint) / 1024.0 / 1024.0
            return usedMemory
        } else {
            print("[ImageCacheService] Failed to fetch RAM usage.")
            return 0
        }
    }
}
