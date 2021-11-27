import Foundation
/// Library for perfroming matrix and vector math

public struct Matrix{
    public enum types{
        case identityMatrix
        case zeroMatrix
        case custMatrix
    }
    
    
    let rows : Int
    let columns : Int
    var data : [Double]  = []
    
    public init(rows : Int, columns : Int, type : types, data : [Double]? = nil ){
        self.rows = rows
        self.columns = columns
        switch type{
        case .zeroMatrix:
            self.data = Array(repeating: 0, count: rows*columns)
        case .identityMatrix:
            for i in 0..<self.rows
            {
                for j in 0..<self.columns
                {
                    if ( i == j){
                        self.data.append(1)
                    }else{
                        self.data.append(0)
                    }
                }
            }
        case .custMatrix:
            self.data = data!
        }
    }
    
    func indexisvalid(row : Int, column : Int) -> Bool{
        row >= 0 && row <= self.rows && column >= 0 && column <= self.columns
    }
    
    subscript(row : Int, column : Int) -> Double{
        get{
            assert(indexisvalid(row: row, column: column), "Index out of range")
            return self.data[(row*self.columns) + column]
        }
        set{
            assert(indexisvalid(row: row, column: column), "Index out of range")
            self.data[(row*self.columns) + column] = newValue
        }
    }
    
    //    matrix operations
    /// Multiply two matrices together using a naive multiplication algorithm
    /// - Parameters:
    ///   - matA: rows : M         columns : K
    ///   - matB: rows : K         columns : P
    /// - Returns: Outputs matrix with dimensions M by P
    public func multiply(matA : Matrix,matB : Matrix) -> Matrix{
        var result = Matrix(rows: matA.rows,columns: matB.columns,type: .zeroMatrix)
        if(matA.columns == matB.rows){
        for i in 0..<matA.rows{
            for j in 0..<matB.columns{
                var sum : Double = 0
                for k in 1..<matA.columns{
                    sum += matA[i,k] * matB[k,j]
                }
                result[i,j] = sum
            }
        }
        }else{
            print("dimension error")
        }
        return result
    }
    
}

