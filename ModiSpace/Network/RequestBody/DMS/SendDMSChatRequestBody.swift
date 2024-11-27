//
//  SendDMSChatRequestBody.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct SendDMSChatRequestBody: MutipartEncodable {
    
    let content: String
    let files: [Data]
    
    func toMultipartFormData() -> [MultipartFormData] {
        var multipartData: [MultipartFormData] = []
        
        if let nameData = content.data(using: .utf8) {
            multipartData.append(
                MultipartFormData(
                    name: "content",
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
