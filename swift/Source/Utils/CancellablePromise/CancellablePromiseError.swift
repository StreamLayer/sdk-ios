//
//  CancellablePromiseError.swift
//  CancellablePromiseKit
//
//  Created by Johannes Dörr on 18.05.18.
//

import PromiseKit

internal enum CancellablePromiseError: Swift.Error, CancellableError {
  case cancelled
}

internal extension CancellablePromiseError {

  var isCancelled: Bool {
    switch self {
    case .cancelled:
      return true
    }
  }

}
