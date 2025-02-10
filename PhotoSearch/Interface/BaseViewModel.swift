//
//  BaseViewModel.swift
//  PhotoSearch
//
//  Created by youngkyun park on 2/10/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
