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
    
    //Swift demanded a synchronous function inside the button, so this is synchronous
    func calculateAll(N: Int){
        series1String = String(series.series1(N: N))
        series2String = String(series.series2(N: N))
        series3String = String(series.series3(N: N))
    }
    func setN(NString1: String)-> Int{
        N = Int(NString1) ?? 1
        return N
    }

    
    //This part requires the calculation of a large number of data points
    //Each data point is three series and a base-10 logarithm, but each point
    //is independent of the others, so this is perfect for threading
    //I use a taskgroup here because that's what I was able to figure out and the fact that this method
    //can be uesd in all sorts of cases, so it's good to get used to
    func calculateErrorPlot(N: Int) async->Array<Double>{
        //initialize taskgroup
        let errorArray = await withTaskGroup(of: (Int, Double).self, returning: [Double].self, body: {taskGroup in
            //Initialize each task in desired plot range
            for i in stride(from: 1, through: N, by: 1){
                taskGroup.addTask {
                    //Create return value. This is a complex computation, hence the threading
                    let value = await log10((series.series1(N: i)-series.series2(N: i))/series.series3(N:i))
                    
                    return (i,value)
                }
            }
            //Take results as they come in and assign them to their proper place
            //We do not know the order these tasks will finish in, so we use a tuple to assign each result its value
            var interimResults = [0.0]
            //reordering results as they come in
            for await result in taskGroup{
                interimResults[result.0]=result.1
            }
            
            return interimResults
        })
        
        return(errorArray)
        }
}
//The next major task is to add the plotting component, but Dr. Terry has not sent us a working template
//
//
//
//
//


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
