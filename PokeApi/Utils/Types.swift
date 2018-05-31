//
//  SELTypes.swift
//  listUps
//
//  Created by Sergii Lyahovchuk on 14.12.2017.
//  Copyright © 2017 Selecto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias void_block = () -> Void
typealias bool_block = (Bool) -> Void
typealias int_block = (Int) -> Void
typealias int64_block = (Int64) -> Void
typealias float_block = (CGFloat) -> Void
typealias object_block = (AnyObject) -> Void
typealias image_block = (UIImage) -> Void
typealias error_block = (Error) -> Void
typealias managed_arr_block = ([NSManagedObject]) -> Void
typealias managed_block = (NSManagedObject) -> Void
typealias completion_block = (_ errMsg: String?, _ data: AnyObject?) -> Void
typealias string_block = (String?) -> Void
typealias dictionary_block = ([String: Any?]) -> Void
