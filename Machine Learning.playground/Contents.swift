//: Machine Learning - really complex maths to do cool stuff with computers.
//: https://brilliant.org/practice/linear-regression-introduction/?chapter=linear-regression

import Cocoa

func meanValue(_ values: [Double]) -> Double
{
    let n : Double = Double(values.count)
    return Double(values.reduce(0, +)) / n
}

func standardDeviation(_ values: [Double]) -> Double
{
    let n : Double = Double(values.count)
    let valuesMean: Double = meanValue(values)
    let Σ : Double = values.map { pow(Double($0 - valuesMean), 2) }.reduce(0, +)
    
    return sqrt((1 / (n - 1)) * Σ)
}

func normalizedValues(_ values: [Double]) -> [Double]
{
    let xMean = meanValue(values)
    let xStandardDeviation = standardDeviation(values)
    return values.map { ($0 - xMean) / xStandardDeviation }
}

func correlation(xValues: [Double], yValues: [Double]) -> Double
{
    precondition(xValues.count == yValues.count)
    
    let normalizedX: [Double] = normalizedValues(xValues)
    let normalizedY: [Double] = normalizedValues(yValues)
    let n = Double(xValues.count)
    
    let Σ: Double = zip(normalizedX, normalizedY).map(*).reduce(0, +)

    return (1 / n) * Σ
}

let test1: [Double] = [15, 40, 10, 18, 31]
let test2: [Double] = [90, 90, 90, 90, 90]
let test3: [Double] = [1, 4, 3, 5, 1]

print(standardDeviation(test1))
print(standardDeviation(test2))
print(standardDeviation(test3))

print(correlation(xValues: test1, yValues: test3))

let xValues: [Double] = [1.544048,  2.255081,  3.160680,  4.032433,  5.559544,  6.440138,  7.029856,  8.980277,  9.782634, 10.427791]
let yValues: [Double] = [4.004488,  5.815719, 10.101832,  9.365451, 13.870741, 15.913436, 16.094514, 18.735606, 22.107042, 23.596895]

func printLinearRegression(xValues: [Double], yValues: [Double])
{
    let yMean = meanValue(yValues)
    let xMean = meanValue(xValues)
    let correlationCoefficient = correlation(xValues: xValues, yValues: yValues)
    
    let xStandardDeviation = standardDeviation(xValues)
    let yStandardDeviation = standardDeviation(yValues)
    
    let Δ = (correlationCoefficient * yStandardDeviation) / xStandardDeviation
    
    print("y - \(yMean) = \(Δ) * (x - \(xMean))")
}

printLinearRegression(xValues: xValues, yValues: yValues)

