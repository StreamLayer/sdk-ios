//
//  DemoStreamsFixture.swift
//  Demo
//
//  Created by Alexander Kremenets on 29.12.2020.
//

import Foundation

public struct SLRStreamsHostAppModel: Decodable {
  public internal(set) var eventId: Int = 0
  public internal(set) var eventImageUrlString: String = ""
  public internal(set) var isLive: Bool = true
  public internal(set) var titleText: String = "Chelsea vs Man City"
  public internal(set) var subTitleText: String = "ESPN+ • Premier League"
  public internal(set) var timeText: String = "7:00 PM"
  public internal(set) var streamURL: String = ""
}


let JSONStremsFixture = """
      [
         {
            "streamURL":"330694222",
            "titleText":"Kansas City Chiefs vs Houston Texans",
            "subTitleText":"ESPN+ • EPL",
            "isLive":false,
            "eventId":4,
            "eventImageUrlString":"https://cdn.streamlayer.io/demo/HoustonTexans.png",
            "timeText":"11:45"
         },
         {
            "streamURL":"367065937",
            "titleText":"Real Madrid vs Barcelona",
            "subTitleText":"",
            "isLive":true,
            "eventId":2,
            "eventImageUrlString":"https://cdn.streamlayer.io/demo/ElClassico.png",
            "timeText":"12:00"
         },
         {
            "streamURL":"367692942",
            "titleText":"Los Angeles Dodgers vs Los Angeles Angels",
            "subTitleText":"",
            "isLive":true,
            "eventId":5,
            "eventImageUrlString":"https://cdn.streamlayer.io/demo/dodgers.png",
            "timeText":"12:40"
         },
         {
            "streamURL":"dp8PhLsUcFE",
            "titleText":"Chelsea vs Manchester City",
            "subTitleText":"",
            "isLive":false,
            "eventId":1,
            "eventImageUrlString":"https://cdn.streamlayer.io/demo/chelsea.png",
            "timeText":"13:35"
         },
         {
            "streamURL":"HDbjgMJUjls",
            "titleText":"Los Angeles Rams vs Dallas Cowboys",
            "subTitleText":"ESPN+ • EPL",
            "isLive":true,
            "eventId":3,
            "eventImageUrlString":"https://cdn.streamlayer.io/demo/rams.png",
            "timeText":"17:00"
         }
      ]
"""
let jsonData = JSONStremsFixture.data(using: .utf8)!

let DemoStreams: [SLRStreamsHostAppModel] = try! JSONDecoder().decode([SLRStreamsHostAppModel].self, from: jsonData)
