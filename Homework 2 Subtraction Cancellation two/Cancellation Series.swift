//
//  Cancellation Series.swift
//  Homework 2 Subtraction Cancellation two
//
//  Created by Matthew Malaker on 1/28/22.
//

import Foundation
import SwiftUI


class CancellationSeries: NSObject, ObservableObject{

    
    
    
    func series1(N: Int) -> Double{
        var sum = 0.0
        for n in stride(from: 1, through: 2*N, by: 1){
            
            let num = Double(n)
            sum += pow(-1.0,num)*(num/(num+1))
        }
        return(sum)
    }
    
    func series2(N: Int) -> Double{
        var sum1 = 0.0
        var sum2 = 0.0
        
        for n in stride(from: 1, through: 2*N, by: 1){
            let num = Double(n)
            sum1 += (2*num-1)/(2*num)
        }
        for n in stride(from: 1, through: 2*N, by: 1){
            let num = Double(n)
            sum2 += (2*num)/(2*num+1)
        }
        return((-1*sum1)+sum2)
    }
    
    func series3(N: Int) -> Double{
        var sum = 0.0
        for n in stride(from: 1, through: N, by: 1){
            let num = Double(n)
            sum += 1/((2*num)*(2*num+1))
        }
        return(sum)
    }
}

