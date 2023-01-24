//
//  AddProjectModal.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI
import PhotosUI

struct AddProjectModal: View {
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject var dataController: DataController
    @State public var newProject = ProjectModel(title: "", summary: "", tags: [])
    //@State var tagList: [Tags] = [.SwiftUI, .UIKit, .CoreML, .CoreData, .PhotosUI]
    @State var tagViews: [TagView] = []
    @State var isSelectingTag: Bool = false
    
    let columns: [GridItem] = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    Form {
                        Section("") {
                            PickerView(newProject: $newProject)
                                .frame(width: geo.size.width, height: geo.size.height * 0.2)
                        }
                        .listRowBackground(Color.clear)
                        Section("Title") {
                            TextField("Enter project title", text: $newProject.title)
                        }
                        Section("Description") {
                            TextField("Enter project description", text: $newProject.summary)
                        }
                        Section("Tags") {
                            VStack{
                                Button(action: {
                                    isSelectingTag.toggle()
                                }, label: {
                                    HStack{
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(Color(UIColor.systemGreen))
                                        Text("Add a tag")
                                            .foregroundColor(Color(UIColor.label))
                                    }
                                })
                                .offset(x: 0, y: 3)
                                LazyVGrid(columns: columns) {
                                    ForEach(tagViews){ tagView in
                                        tagView
                                    }
                                }
                            }
                            .sheet(isPresented: $isSelectingTag){
                                TagSelectionView(isSelectingTag: $isSelectingTag, tagViews: $tagViews, checks: Array(repeating: false, count: viewModel.tagList.count))
                            }
                        }
                        Spacer()
                            .listRowBackground(Color.clear)
                        Section("") {
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.isAddingFromGit = true
                                } label: {
                                    Text("Retrieve from GitHub")
                                        .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.07)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(16)
                                }
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .formStyle(.grouped)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
//                            var tempTags: [Tags] = []
//                            for tagView in tagViews {
//                                tempTags.append(tagView.name)
//                            }
//                            newProject.tags = tempTags

                            viewModel.isAddingProject = false
                            dataController.addProject(project: newProject)
                        } label: {
                            Text("Add")
                        }
                        
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            viewModel.isAddingProject = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .navigationTitle("Add Project")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $viewModel.isAddingFromGit) {
            AddFromGitModal(newProject: $newProject)
        }
    }
}

struct AddProjectModal_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectModal()
            .environmentObject(PortfolioViewModel())
            .preferredColorScheme(.dark)
    }
}


