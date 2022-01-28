//
//  ContentView.swift
//  Homework 2 Subtraction Cancellation two
//
//  Created by Matthew Malaker on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @State var N = 1
    @State var NString = ""
    @State var series1String = ""
    @State var series2String = ""
    @State var series3String = ""
    @ObservedObject var series = CancellationSeries()
    var body: some View {
        VStack{
            HStack{
                Text("Input N")
                    .padding(.horizontal)
                    .frame(width: 150)
                    .padding(.top, 30)
                    .padding(.bottom, 0)
                TextField("",text:$NString, onCommit: {N =  self.setN(NString1: NString)})
                    .padding(.horizontal)
                    .frame(width: 150)
                    .padding(.top, 30)
                    .padding(.bottom, 0)
            }
              HStack{
                  Text("Series 1")
                      .padding(.horizontal)
                      .frame(width: 150)
                      .padding(.top, 30)
                      .padding(.bottom, 0)
                  TextField("",text:$series1String)
                      .padding(.horizontal)
                      .frame(width: 150)
                      .padding(.top, 30)
                      .padding(.bottom, 0)
              }
                HStack{
                    Text("Series 2")
                        .padding(.horizontal)
                        .frame(width: 150)
                        .padding(.top, 30)
                        .padding(.bottom, 0)
                    TextField("",text:$series2String)
                        .padding(.horizontal)
                        .frame(width: 150)
                        .padding(.top, 30)
                        .padding(.bottom, 0)
                }
                HStack{
                    Text("Series 3")
                        .padding(.horizontal)
                        .frame(width: 150)
                        .padding(.top, 30)
                        .padding(.bottom, 0)
                    TextField("",text:$series3String)
                        .padding(.horizontal)
                        .frame(width: 150)
                        .padding(.top, 30)
                        .padding(.bottom, 0)
                }
            //Calculate Button
            Button("Calculate", action: {self.calculateAll(N: N)})
                .padding(.bottom)
                .padding()
        }
    }
    func calculateAll(N: Int){
        series1String = String(series.series1(N: N))
        series2String = String(series.series2(N: N))
        series3String = String(series.series3(N: N))
    }
    func setN(NString1: String)-> Int{
        N = Int(NString1) ?? 1
        return N
    }
}
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
