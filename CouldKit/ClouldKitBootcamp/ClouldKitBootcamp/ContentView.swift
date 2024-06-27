//
//  ContentView.swift
//  ClouldKitBootcamp
//
//  Created by Thiago Pereira de Menezes on 31/05/24.
//

import SwiftUI
import CloudKit

class ClouldKitUserBootcampViewModel: ObservableObject {
    
    @Published var isSignedInToiClould: Bool = false
    @Published var error: String = ""
    @Published var userName = ""
    @Published var permissionStatus = false
    
    init() {
        getiCloudStatus()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            switch returnedStatus {
            case .couldNotDetermine:
                self?.error = ClouldKitError.iClouldAccountNotDetermined.localizedDescription
            case .available:
                self?.isSignedInToiClould = true
            case .restricted:
                self?.error = ClouldKitError.iCloudAccountRestricted.localizedDescription
            case .noAccount:
                self?.error = ClouldKitError.iClouldAccountNotFound.localizedDescription
            case .temporarilyUnavailable:
                self?.error = ClouldKitError.iCloudAccountTemporarilyUnavailable.localizedDescription
            @unknown default:
                self?.error = ClouldKitError.iCloudAccountUnknown.localizedDescription
            }
        }
    }
    
    enum ClouldKitError: LocalizedError {
        case iClouldAccountNotFound
        case iClouldAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        case iCloudAccountTemporarilyUnavailable
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    //obs: Só pode ser executado se o usuário já estiver logado no iCloud
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUserName(id: id)
            }
        }
    }
    
    func discoveriCloudUserName(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            if let name = returnedIdentity?.nameComponents?.givenName {
                self?.userName = name
            } else {
                print("the username is nil")
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var vm = ClouldKitUserBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("Is signed in: \(vm.isSignedInToiClould.description.uppercased())")
            Text(vm.error)
            Text("Name: \(vm.userName)")
            
    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
