//
//  ExtAVCaptureDevice.swift
//  listUps
//
//  Created by Mykhailo Zabarin on 1/10/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import AVFoundation

extension AVCaptureDevice{
    
    var isLocked: Bool {
        do {
            try lockForConfiguration()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func setTorch(torchModeOption: Int) {
        guard hasTorch && isLocked else { return }
        defer { unlockForConfiguration() }
        switch torchModeOption {
        case 0: torchMode = .off
        case 1: torchMode = .on
        case 2: torchMode = .auto
        default: return
        }
    }
}
