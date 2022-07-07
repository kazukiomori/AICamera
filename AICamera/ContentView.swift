//
//  ContentView.swift
//  AICamera
//
//  Created by Kazuki Omori on 2022/07/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Button(action: {}, label: {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
            })
            Button(action: {}, label: {
                Text("AIの解析")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
