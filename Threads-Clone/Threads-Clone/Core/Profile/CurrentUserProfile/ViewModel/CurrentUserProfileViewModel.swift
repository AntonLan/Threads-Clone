//
//  CurrentProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Observation
import Combine
import PhotosUI
import SwiftUI

@Observable
final class CurrentUserProfileViewModel {
    var currentUser: User?
    var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    var progileImage: Image?
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellable)
    }
    
    private func loadImage() async {
        guard let item = selectedItem else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        
        progileImage = Image(uiImage: uiImage)
    }
}

struct CurrentUserProfileViewModelKey: EnvironmentKey {
    static var defaultValue: CurrentUserProfileViewModel = CurrentUserProfileViewModel()
}

extension EnvironmentValues {
    var currentUserProfileViewModel: CurrentUserProfileViewModel {
        get { self[CurrentUserProfileViewModelKey.self] }
        set { self[CurrentUserProfileViewModelKey.self] = newValue }
    }
}
