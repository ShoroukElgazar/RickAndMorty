//
//  CharacterCardCellView.swift
//  Characters
//
//  Created by Shorouk Mohamed on 13/01/2025.
//


import SwiftUI
import CommonModels
import CommonUI

struct CharacterCardCellView: View {
    var didSelectCharacter: () -> Void
    var character: Character
 
    var body: some View {
        HStack(alignment: .top)  {
            RemoteImage(urlString: character.image)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                        .lineLimit(2)
                    Text(character.species)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }.padding(.leading, 10)
                Spacer()
            }.padding(.horizontal,20)
            .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height/6)
            .cardView(cornerRadius: 12,
                      shadowRadius: 4,
                      borderColor: .gray.opacity(0.3),
                      borderWidth: 0.5)

        .onTapGesture {
            didSelectCharacter()
        }
    }
}
