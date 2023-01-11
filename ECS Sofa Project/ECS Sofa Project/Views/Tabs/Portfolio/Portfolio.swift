//
//  Portfolio.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct Portfolio: View {
    
    let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack{
            VStack {
                LazyVGrid(columns: columns){
                    ForEach(projectArray){ project in
                        NavigationLink(destination: {
                            
                        }, label: {
                            ProjectPreview(project: project)
                        })
                    }
                    .navigationTitle("Portfolio")
                }
                .padding()
                Spacer()
            }
        }
        
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio()
            .preferredColorScheme(.dark)
    }
}
