//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Josh Smith on 5/8/15.
//  Copyright (c) 2015 Square One Nation, LLC. All rights reserved.
//

import Foundation

class RecordedAudio
{
    var filePathUrl : NSURL
    var title : String
    
    init(filePathUrl: NSURL, title: String)
    {
        self.filePathUrl = filePathUrl
        self.title = title
    }

}