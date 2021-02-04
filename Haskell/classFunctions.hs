add :: [[Double]] -> [[Double]] -> [[Double]]
add [] [] = []
add (m1h:m1t) (m2h:m2t) = map (\(x,y) -> x + y) (zip m1h m2h) : add m1t m2t

transpose :: [[Double]]  -> [[Double]]
transpose ([]:_) = []
transpose m = (map head m) : (transpose (map tail m))

main = do 
    print "=== add matrix ==="
    print $ add [[1, 2, 3], [4, 5, 6]] [[10, 20, 30], [40, 50, 60]]
    print "=== transpose ==="
    print $ transpose [[1, 2, 3], [4, 5, 6]]
    print "=== multiply ===" 