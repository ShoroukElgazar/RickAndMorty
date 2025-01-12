//
//  DependencyContainerRegistrationType.swift
//  DependencyContainer
//
//  Created by Shorouk Mohamed on 12/01/2025.
//


public enum DependencyContainerRegistrationType {
    case singleInstance(AnyObject)
    case closureBased(() -> Any)
    
}