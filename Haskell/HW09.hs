-- ====================
-- Complete the following functions and submit your file to Canvas.
-- ====================
-- Do not change the names of the functions. 
-- Do not change the number of arguments in the functions.
-- If your file cannot be loaded by the Haskell compiler, your submission may be cancelled. 
-- Then, submit only code that works.
-- ====================
-- Grading instructions:
-- There is a series of test cases for each function. In order to state that your function
-- "works as described", your output must be similar to the expected one in each case.

-- === invert ===

invert :: [t] -> [t]
invert [] = []
invert [x] = [x]
invert (first:rest) = invert rest ++ [first]

-- === or ===

listor :: [Int] -> [Int] -> [Int]
listor [] [] = []
listor [x] [y] = if x == 0 && y == 0
    then [0]
    else [1]
listor (onef:ones) (secondf:seconds) = if onef == 0 && secondf == 0
    then [0] ++ listor ones seconds
    else [1] ++ listor ones seconds

-- === multiples ===

multiples :: [Int] -> Int -> [Int]
multiples [] _ = []
multiples x y = if mod (head x) y == 0
    then [head x] ++ multiples (tail x) y
    else multiples (tail x) y

-- === differences ===
differencesAux :: [Int] -> Int -> [Int]
differencesAux [] _ = []
differencesAux [x] y = [abs (y - x)]
differencesAux (first:rest) y = [abs (first - head rest)] ++ (differencesAux rest y)

differences :: [Int] -> [Int]
differences [] = []
differences x = differencesAux x (head x)

-- === toBinaryString ===

toBinaryString :: Int -> [Char]
toBinaryString 0 = "0"
toBinaryString 1 = "1"
toBinaryString n =  if mod n 2 == 0
    then toBinaryString (n `div` 2) ++ "0"
    else toBinaryString (n `div` 2) ++ "1"
    
-- === modulo ===

modulo :: Int -> Int -> Int
modulo x y
        | x == 0 = 0
        | x < y = x
        | otherwise = modulo (x - y) y 

-- === evaluate ===

evaluate :: [Double] -> Double -> Double
evaluate [] _ = 0.0
evaluate (first:rest) x = first * x^(length rest) + (evaluate rest x)

-- === cleanString ===

cleanString :: [Char] -> [Char]
cleanString [] = []
cleanString [x] = [x]
cleanString (first:rest) = if first == head rest
    then cleanString rest
    else  [first] ++ cleanString rest

-- === iSort ===
inserSort :: Int -> [Int] -> [Int]
inserSort x [] = [x]
inserSort x (first:rest) = if x < first
        then x : first : rest
        else first : (inserSort x rest)


iSort :: [Int] -> [Int]
iSort [] = []
iSort (first:rest) = inserSort first (iSort rest)

-- === Test cases ===

main = do 
    print "=== invert ==="
    print $ invert ([] :: [Int])-- []
    print $ invert [1, 2, 3, 4, 5] -- [5,4,3,2,1]
    print $ invert "hello world!" -- "!dlrow olleh"
    print "=== listor ==="
    print $ listor [1, 1, 0] [0, 1, 0] -- [1,1,0]
    print $ listor [1, 0, 1, 0] [0, 0, 1, 1] -- [1,0,1,1]
    print $ listor [1, 0, 1, 0, 1] [1, 1, 1, 0, 0] -- [1,1,1,0,1]
    print "=== multiples ==="
    print $ multiples [2, 4, 5, 6] 2 -- [2,4,6]
    print $ multiples [9, 27, 8, 15, 4] 3 -- [9,27,15]
    print $ multiples [9, 8, 17, 5] 6 -- []
    print "=== differences ==="
    print $ differences [1, 2, 4, 8, 20] -- [1,2,4,12,19]
    print $ differences [5, 9, 13, 27, 100, 91, 4] -- [4,4,14,73,9,87,1]
    print $ differences [99] -- [0]
    print $ differences [] -- [] 
    print "=== toBinaryString ==="
    print $ toBinaryString 0 -- "0"
    print $ toBinaryString 1 -- "1"
    print $ toBinaryString 7 -- "111"
    print $ toBinaryString 32 -- "100000"
    print $ toBinaryString 1024 -- "10000000000"
    print "=== modulo ==="
    print $ modulo 10 2 -- 0
    print $ modulo 15 4 -- 3
    print $ modulo 20 9 -- 2
    print $ modulo 77 10 -- 7
    print "=== evaluate ==="
    print $ evaluate ([] :: [Double]) 100 -- 0.0
    print $ evaluate [2, 3.1, 10, 0] 2 -- 48.4
    print $ evaluate [10, 0] 2 -- 20.0
    print $ evaluate [1, 2, 3, 4, 5] 3 -- 179.0
    print "=== cleanString ==="
    print $ cleanString ([] :: String) -- ""
    print $ cleanString "yyzzza" -- "yza"
    print $ cleanString "aaaabbbccd" -- "abcd"
    print "=== iSort ==="
    print $ iSort [] -- []
    print $ iSort [1] -- [1]
    print $ iSort [1, 6, 3, 10, 2, 14] -- [1,2,3,6,10,14]