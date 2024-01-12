//
//  ContentView.swift
//  Day77Challenge
//
//  Created by M Sapphire on 2024/1/10.
//
import PhotosUI
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selectedPicture: PhotosPickerItem?
    @Query var pictures: [Picture]
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pictures.sorted(), id: \.pictureID) { photo in
                    NavigationLink(destination: DetailView(picture: photo)) {
                        HStack {
                            Image(uiImage: getImage(photo.pictureData))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 60)
                                .padding(.trailing, 20)
                            
                            Text(photo.humanName)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteItem(indexSet)
                })
                .onChange(of: selectedPicture) {
                }
            }
            .toolbar {
                Button("add", systemImage: "plus") {
                    showAddView.toggle()
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView() { newPicture in
                    modelContext.insert(newPicture)
                }
            }
        }
    }
    
    func getImage(_ data: Data) -> UIImage{
        guard let uiimg = UIImage(data: data) else { fatalError("error") }
        return uiimg
    }
    
    func deleteItem(_ indexset: IndexSet) {
        for index in indexset {
            let item = pictures[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
