//
//  EditProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
final class EditProfileViewModel {
    var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    var progileImage: Image?
    
    @ObservationIgnored
    private var uiImage: UIImage?
    
    func updateUserData() async throws {
        try await updateProfileImage()
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        progileImage = Image(uiImage: uiImage)
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
}
