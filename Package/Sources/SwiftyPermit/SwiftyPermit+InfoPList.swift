//
//  PermissiomManager+InfoPList.swift
//  
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    func infoPList(contains entry: SwiftyPermitPListEntry) -> Bool {
        return infoPListValue(entry) != nil
    }
    
    func infoPListValue(_ entry: SwiftyPermitPListEntry) -> String? {
        
        switch entry {
            
        case .keyValue(let key):
            return infoPListValueFor(key: key)
            
        case .arrayValue(let array, let value):
            if infoPListContains(array: array, value: value) {
                return value
            } else {
                return nil
            }
            
        case .dictionaryKey(let dictionary, let key):
            return infoPListValue(dictionary: dictionary, key: key)
            
        }
        
    }
    
    private func infoPListValueFor(key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }
        
        guard value.isEmpty == false else {
            return nil
        }
        
        return value
    }
    
    private func infoPListContains(array arrayKey: String, value valueKey: String) -> Bool {
        guard let array = Bundle.main.object(forInfoDictionaryKey: arrayKey) as? [String] else {
            return false
        }
        
        return array.contains(valueKey)
    }
    
    private func infoPListValue(dictionary dictionaryKey: String, key: String) -> String? {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: dictionaryKey) as? [String: String] else {
            return nil
        }
        
        guard let value = dictionary[key] else {
            return nil
        }
        
        guard value.isEmpty == false else {
            return nil
        }
        
        return value
    }
    
}
