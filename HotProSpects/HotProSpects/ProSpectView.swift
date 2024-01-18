//
//  ProSpectView.swift
//  HotProSpects
//
//  Created by M Sapphire on 2024/1/15.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProSpectView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowscaner = false
    @State private var isShowRank = false
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    var filterProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(filterProspects) { item in
                    HStack(spacing: 20) {
                        if !item.isContacted {
                            Image(systemName: "person.crop.circle.badge.xmark")
                                .foregroundStyle(.blue)
                                .scaleEffect(1.5)
                        } else {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .foregroundStyle(.green)
                                .scaleEffect(1.5)
                        }
                        VStack(alignment: .leading){
                            Text(item.name)
                            Text(item.emailAddress)
                        }
                    }
                    .font(.headline)
                    .swipeActions {
                        if item.isContacted {
                            Button {
                                prospects.toggle(item)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(item)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(item)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("rank", systemImage: "arrow.up.arrow.down") {
                    isShowRank.toggle()
                }
                Button {
                    isShowscaner.toggle()
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowscaner, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Sapphire\nSapphire@gamil.com",completion: handleScan)
            })
            .confirmationDialog("Rank by", isPresented: $isShowRank, titleVisibility: .visible) {
                Button("By name") {
                    prospects.rankByName()
                }
                Button("By most Recent") {
                    prospects.rankByEmail()
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowscaner = false
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure(let failure):
            print("scan error: \(failure.localizedDescription)")
        }
    }
    
    func addNotification(_ prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.body = "Content \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("error")
                    }
                }
            }
        }
    }
}

#Preview {
    ProSpectView(filter: .none)
        .environmentObject(Prospects())
}
