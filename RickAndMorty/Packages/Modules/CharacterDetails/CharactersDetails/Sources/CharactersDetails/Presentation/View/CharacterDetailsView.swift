//
//  CharacterDetailsView.swift
//  CharactersDetails
//
//  Created by Shorouk Mohamed on 13/01/2025.
//

import SwiftUI
import Utilities
import CommonModels
import CommonUI
import SwiftUI

struct CharacterDetailsView: View {
    var character: Character
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                imageWithBackButton(geometry: geometry)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    nameView()
                    
                    characterInfoView()
                    
                    locationView()
                 
                }
                .padding(.top, 10)
                .padding(.horizontal, 15)
                
              
            }.edgesIgnoringSafeArea(.top)
        }
    }
    
    private func imageWithBackButton(geometry: GeometryProxy) -> some View {
        ZStack(alignment: .topLeading) {
            RemoteImage(urlString: character.image)
                .scaledToFill()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height / 2
                )
                .cornerRadius(50)
                
            
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.top, 60)
            .padding(.leading, 20)
        }
    }
    private func nameView() -> some View {
        Text(character.name)
            .font(.system(size: 25,weight: .bold))
    }
    private func characterInfoView() -> some View {
        HStack {
            Text(character.species)
                .font(.system(size: 15,weight: .medium))
                .foregroundStyle(.black.opacity(0.8))
            Image(systemName: "circle.fill")
                .font(.system(size: 5))
                .foregroundColor(.black)
            Text(character.gender)
                .font(.system(size: 15,weight: .medium))
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(character.status)
                .font(.system(size: 18,weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical,5)
                .padding(.horizontal,20)
                .background(
                    Capsule()
                        .fill(Color.blue.opacity(0.7))
                )
        }
    }
    private func locationView() -> some View {
        HStack {
            Text("Location: ")
                .font(.system(size: 15,weight: .medium))
                .foregroundStyle(.black.opacity(0.8))
            Text(character.locationName)
                .font(.system(size: 15,weight: .medium))
                .foregroundStyle(.gray)
                .lineLimit(nil)
        }
    }
    
}
#Preview {
    CharacterDetailsView(character: Character(id: 0, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", image: "", locationName: "Earth"))
}

