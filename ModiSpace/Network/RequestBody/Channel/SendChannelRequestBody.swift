//
//  SendChannelRequestBody.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct SendChannelRequestBody: MutipartEncodable {
    
    let content: String
    let files: [Data]
    
    func toMultipartFormData() -> [MultipartFormData] {
        var multipartData: [MultipartFormData] = []
        
        if let nameData = content.data(using: .utf8) {
            multipartData.append(
                MultipartFormData(
                    name: "name",
                    fileName: "",
                    mimeType: "text/plain",
                    data: nameData
                )
            )
        }
        
        for (index, fileData) in files.enumerated() {
            multipartData.append(
                MultipartFormData(
                    name: "file\(index)",
                    fileName: "file\(index).jpeg",
                    mimeType: "image/jpeg",
                    data: fileData
                )
            )
        }
        
        return multipartData
    }
    
}
