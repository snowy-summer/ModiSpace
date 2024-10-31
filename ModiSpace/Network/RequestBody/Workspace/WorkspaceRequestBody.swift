//
//  WorkspaceRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct WorkspaceRequestBody: MutipartEncodable {
    
    let name: String
    let description: String?
    let image: Data
    
    func toMultipartFormData() -> [MultipartFormData] {
        var multipartData: [MultipartFormData] = []
        
        if let nameData = name.data(using: .utf8) {
            multipartData.append(
                MultipartFormData(
                    name: "name",
                    fileName: "",
                    mimeType: "text/plain",
                    data: nameData
                )
            )
        }
        
        if let description = description, let descriptionData = description.data(using: .utf8) {
            multipartData.append(
                MultipartFormData(
                    name: "description",
                    fileName: "",
                    mimeType: "text/plain",
                    data: descriptionData
                )
            )
        }
        
        multipartData.append(
            MultipartFormData(
                name: "image",
                fileName: "\(name).jpeg",
                mimeType: "image/jpeg",
                data: image
            )
        )
    
        return multipartData
    }
    
}
