import Foundation
/// Library for perfroming matrix and vector math

public protocol matOperations{
    var rows : Int {get}
    var columns : Int{get}
}


public extension matOperations{
    
    /// Multiply two matrices together using a naive multiplication algorithm
    /// - Parameters:
    ///   - matA: rows : M         columns : K
    ///   - matB: rows : K         columns : P
    /// - Returns: Outputs matrix with dimensions M by P
    static func multiply(matA : Matrix,matB : Matrix) -> Matrix{
        var result = Matrix(rows: matA.rows,columns: matB.columns,type: .zeroMatrix)
        if(matA.columns == matB.rows){
        for i in 0..<matA.rows{
            for j in 0..<matB.columns{
                var sum : Float = 0
                for k in 0..<matA.columns{
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
    
    
    /// Add two matrices together position does not matter function is commutative. Matrices must have same dimensions.
    /// - Parameters:
    ///   - matA: M by N matrix
    ///   - matB: M by N matrix
    /// - Returns: M by N matrix
    static func add(matA : Matrix,matB : Matrix) -> Matrix{
        var result = Matrix(rows: matA.rows,columns: matB.columns,type: .zeroMatrix)
        if(matA.columns == matB.columns && matA.rows == matB.rows){
        for i in 0..<matA.rows{
            for j in 0..<matB.columns{
                result[i,j] = matA[i,j] + matB[i,j]
            }
        }
        }else{
            print("dimension error")
        }
        return result
    }
    
    /// Add two matrices together position does not matter function is commutative. Matrices must have same dimensions.
    /// - Parameters:
    ///   - matA: M by N matrix
    ///   - matB: M by N matrix
    /// - Returns: M by N matrix
    static func sub(matA : Matrix,matB : Matrix) -> Matrix{
        var result = Matrix(rows: matA.rows,columns: matB.columns,type: .zeroMatrix)
        if(matA.columns == matB.columns && matA.rows == matB.rows){
        for i in 0..<matA.rows{
            for j in 0..<matB.columns{
                result[i,j] = matA[i,j] - matB[i,j]
            }
        }
        }else{
            print("dimension error")
        }
        return result
    }
}






public struct Matrix : matOperations{
    public enum types{
        case identityMatrix
        case zeroMatrix
        case custMatrix
        case vectorNd
    }
    public let rows : Int
    public let columns : Int
    var data : [Float]  = []
    
    public init(rows : Int, columns : Int, type : types, data : [Float]? = nil ){
        self.rows = rows
        
        switch type{
        
        
        case .zeroMatrix:
            self.data = Array(repeating: 0, count: rows*columns)
            self.columns = columns
        
        
        case .identityMatrix:
            self.columns = columns
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
            self.columns = columns
            
        
        case .vectorNd:
            self.columns = 1
            self.data = data!
        }
        
        

        
    }
    
    func indexisvalid(row : Int, column : Int) -> Bool{
        row >= 0 && row <= self.rows && column >= 0 && column <= self.columns
    }
    
    public subscript(row : Int, column : Int) -> Float{
        get{
            assert(indexisvalid(row: row, column: column), "Index out of range")
            return self.data[(row*self.columns) + column]
        }
        set{
            assert(indexisvalid(row: row, column: column), "Index out of range")
            self.data[(row*self.columns) + column] = newValue
        }
    }
    
}






