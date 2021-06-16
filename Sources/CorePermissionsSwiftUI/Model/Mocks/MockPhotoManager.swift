//
//  MockPhotoManager.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import Foundation
#if PERMISSIONSWIFTUI_PHOTO
import Photos

final class MockPhotoManager: PHPhotoLibrary{
    static override func requestAuthorization(_ handler: @escaping (PHAuthorizationStatus) -> Void) {
        handler(PHAuthorizationStatus.authorized)
    }
}
#endif
