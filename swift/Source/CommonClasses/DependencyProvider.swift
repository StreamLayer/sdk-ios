//
//  DependencyProvider.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol DependencyProvider {
  var authService: AuthServiceProvider { get set }
}

class Dependency: DependencyProvider {
  var authService: AuthServiceProvider
  
  init(authService: AuthServiceProvider) {
    self.authService = authService
  }
}
