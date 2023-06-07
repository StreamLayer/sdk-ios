//
//  Promise+CancellablePromise.swift
//  CancellablePromiseKit
//
//  Created by Johannes Dörr on 18.05.18.
//
import PromiseKit

extension Promise {
  /**
   Returns a CancellablePromise.
   */
  func asCancellable() -> CancellablePromise<T> {
    return CancellablePromise(wrapper: { cancelPromise in
      return when(self, while: cancelPromise)
    })
  }
}

extension Guarantee {
  /**
   Returns a CancellablePromise.
   */
  func asCancellable() -> CancellablePromise<T> {
    return Promise(self).asCancellable()
  }
}
