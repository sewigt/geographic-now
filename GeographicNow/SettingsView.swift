//
//  SettingsView.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI

struct SettingsView: View {
    @FocusState private var isFocused: Bool
    
    @AppStorage("StorageEnableDistance") var storageEnableDistance: Bool = true
    @AppStorage("StorageEnableMapURL") var storageEnableMapURL: Bool = true
    @AppStorage("StoragePrefix") var storagePrefix: String = String(localized: "HintPrefix")
    @AppStorage("StorageSuffix") var storageSuffix: String = String(localized: "HintSuffix")
    @AppStorage("StorageShareCount") var storageShareCount: Int = 0
    @AppStorage("StorageTotalDistance") var storageTotalDistance: Int = 0
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Toggle("EnableDistance", isOn: $storageEnableDistance)
                    Toggle("EnableMapURL", isOn: $storageEnableMapURL)
                }
                
                Section {
                    LabeledContent("Prefix") {
                        TextField("HintPrefix", text: $storagePrefix)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($isFocused)
                    }
                    LabeledContent("Suffix") {
                        TextField("HintSuffix", text: $storageSuffix)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($isFocused)
                    }
                }
                
                Section {
                    LabeledContent("ShareCount") {
                        Text(String(storageShareCount) + " " + String(localized: "UnitCount"))
                    }
                    LabeledContent("TotalDistance") {
                        Text(String(storageTotalDistance) + " " + String(localized: "UnitDistance"))
                    }
                }
            }
            .formStyle(.grouped)
            
        }
        .onTapGesture {
            isFocused = false
        }
    }
}
