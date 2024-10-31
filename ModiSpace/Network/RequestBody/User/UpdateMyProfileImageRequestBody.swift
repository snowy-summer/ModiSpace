//
//  UpdateMyProfileImageRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/31/24.
//

import Foundation

struct UpdateMyProfileImageRequestBody: MutipartEncodable {
    
    let uuid = UUID()
    let image: Data
    
    func toMultipartFormData() -> [MultipartFormData] {
        var multipartData = [MultipartFormData]()
        
        multipartData.append(
            MultipartFormData(
                name: "image",
                fileName: "\(uuid).jpeg",
                mimeType: "image/jpeg",
                data: image
            )
        )
        
        return multipartData
    }
}
