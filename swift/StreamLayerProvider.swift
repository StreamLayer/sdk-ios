//
//  StreamLayerProvider.swift
//  Demo
//
//  Created by Kirill Kunst on 20.07.2023.
//

import Foundation
import StreamLayerSDK
import UIKit

enum TestError: Error {
  case defaultError
}

public class StreamLayerProvider: SLRAuthFlowProvider, SLRAuthFlowProfileProvider {

  public func requestOTP(phoneNumber: String) async throws {
    throw TestError.defaultError
  }

  public func authenticate(phoneNumber: String, code: String) async throws -> AuthUser {
    throw TestError.defaultError
  }

  public func setUserName(_ name: String) async throws {
    try await StreamLayer.Auth.setUserName(name)
  }

  public func updateAvatar(to image: UIImage) async throws -> String {
    try await StreamLayer.Auth.uploadAvatar(image)
  }

  public func deleteAvatar() {
    StreamLayer.Auth.deleteAvatar()
  }

  public func logout() {
    StreamLayer.logout()
  }

  public func user() -> AuthUser? {
    guard let user = StreamLayer.Auth.authenticatedUser() else {
      return nil
    }

    return AuthUser(id: user.id,
                        username: user.username,
                        name: user.name,
                        avatar: user.avatar,
                        alias: user.alias)
  }

}

