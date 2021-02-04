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

-- === unique ===

unique :: [Char] -> [Char]
unique [] = []
unique (head:tail) = head : unique (filter (/= head) tail)

-- === multiples ===

multiples :: [Int] -> Int -> [Int]
multiples list num = (filter (\x -> mod x num == 0) list)

-- === add ===

add :: [[Int]] -> Int
add [] = 0
add (head:tail) = (foldl1 (+) head) + add tail

-- === maskedSum ===
maskedSum :: [Int] -> [Bool] -> Int
maskedSum nums bools = sum(map (\(x,y) -> if y then x else 0) (zip nums bools))

-- === combine ===
combine :: [[t]] -> [[a]] -> [[(t, a)]]
combine [] _ = []
combine (head:tail) (first:second) = (zip head first) : combine tail second

-- === avgHeight ===

avgHeight :: [(String, Double)] -> ((String, Double), (String, Double))
avgHeight table = let
    males = (filter (\(gender, height) -> gender == "Male") table)
    females = (filter (\(gender, height) -> gender == "Female") table)
    function = map (\(_, height) -> height)
    in
       (("Male",sum (function males) / fromIntegral(length males)),("Female",sum (function females) / fromIntegral(length females)))

-- === maxHeight ===

data Record = Record [Char] Double deriving Show

maxHeight :: [Record] -> (Record, Record)
maxHeight table = let
    males = (filter (\(Record gender height) -> gender == "Male") table)
    females = (filter (\(Record gender height) -> gender == "Female") table)
    function = (\(Record genderX heightX) (Record genderY heightY) -> if heightX >= heightY then (Record genderX heightX) else (Record genderY heightY))
    in
        ((foldl1 function males), (foldl1 function females))

-- === Test cases ===

main = do 
    print "=== unique ==="
    print $ unique "i'll be back." -- "i'l beack"
    print $ unique "toto, i've got a feeling we're not in kansas anymore." -- "to, i'vegaflnwrksym."
    print $ unique "we'll always have paris." -- "we'l ayshvpri."
    print "=== multiples ==="
    print $ multiples [2, 4, 5, 6] 2 -- [2,4,6]
    print $ multiples [9, 27, 8, 15, 4] 3 -- [9,27,15]
    print $ multiples [9, 8, 17, 5] 6 -- []
    print "=== multiples ==="
    print $ add [[1, 2], [3, 4]] -- 10
    print $ add [[11, 12], [13, 14]] -- 50 
    print $ add [[1, 2, 3], [4, 5, 6], [7, 8, 9]] -- 45
    print "=== maskedSum ==="
    print $ maskedSum [1, 2, 3, 4, 5, 6] [True, True, False, False, True, True] -- 14
    print $ maskedSum [1, 2, 3, 4, 5, 6] [False, False, True, True, False, False] -- 7
    print $ maskedSum [1, 2, 3, 4, 5, 6] [True, False, True, False, True, False, True] -- 9
    print "=== combine ==="
    print $ combine [[1, 2], [3, 4]] [[11, 12], [13, 14]] -- [[(1,11),(2,12)],[(3,13),(4,14)]]
    print $ combine [[1, 2, 3], [4, 5, 6], [7, 8, 9]] [['a', 'b', 'c'], ['d', 'e', 'f'], ['g', 'h', 'i']] -- [[(1,'a'),(2,'b'),(3,'c')],[(4,'d'),(5,'e'),(6,'f')],[(7,'g'),(8,'h'),(9,'i')]]
    print $ combine [[1.1, 2.2]] [["Hello", "Goodbye"]] -- [[(1.1,"Hello"),(2.2,"Goodbye")]]
    print $ combine [[1.1], [2.2]] [["Hello"], ["Goodbye"]] -- [[(1.1,"Hello")],[(2.2,"Goodbye")]]
    print "=== avgHeight ===" 
    print $ avgHeight [("Male", 178), ("Female", 165), ("Female", 158), ("Female", 182), ("Male", 161), ("Male", 175), ("Female",179), ("Male", 188), ("Male", 169), ("Female", 156)] -- (("Male",174.2),("Female",168.0))
    print "=== maxHeight ===" 
    print $ maxHeight [(Record "Male" 178), (Record "Female" 165), (Record "Female" 158), (Record "Female" 182), (Record "Male" 161), (Record "Male" 175), (Record "Female" 179), (Record "Male" 188), (Record "Male" 169), (Record "Female" 156)] -- (Record "Male" 188.0,Record "Female" 182.0)