module Ch06.HighOrdFunction where

--Haskell的多参数的函数实际是由一个个单参数的函数串联而成的
--这点从函数签名就可以看出来
multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

--以不全的参数调用函数可以很方便的创建新函数
multTwoWithNine = multThree 9

multWithEighteen = multTwoWithNine 2

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100

--中缀函数也可以不全调用
divideByTen :: (Floating a) => a -> a
divideByTen = (/ 10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A' .. 'Z'])

--但也有一个例外,就是减法
--(-3)不是表示一个减去三的函数,而是-3这个数字
--如果一定要减法的函数,可以这样写
subtractWithFour = subtract 4

--来点高阶函数
applyTwice :: (a -> a) -> a -> a
applyTwice f a = f (f a)

-- applyTwice (+ 2) 2
-- applyTwice (2:) [1]
--实现zipWith
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f _ [] = []
zipWith' f [] _ = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

--zipWith' (+) [1,3] [4,9]
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f =
  let f' x y = f y x
  in f'

--更简单的写法:
flip'' f x y = f y x

--map和filter
plusThree = map (+ 3) [1, 5, 3, 1, 6]

concatSome = map (++ "!") ["BIFF", "BANG", "POW"]

filterEven = filter even [1, 2, 3, 4, 5]

filterA2Z = filter (`elem` ['a' .. 'z']) "u LaUgH aT mE BeCaUsE I aM diFfeRent"

--实际上map和filter都可以通过list comprehension实现,这个看个人选择
--但如果需要连续的map或filter,那么还是list comprehension用着舒服
--取不大于10000的所有数中可以被3829整除的最大值
largestDivisible :: Integral a => a
largestDivisible = head (filter p [10000,9999 ..])
  where
    p x = x `mod` 3829 == 0

--由于是惰性求值,所以[10000,9999..]不需要指明结束元素
--取所有小于10000的等于某个数平方的奇数,求和
squareSum = sum (takeWhile (< 10000) (filter odd (map (^ 2) [1 ..])))

--考拉咨序列
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain x
  | even x = x : chain (x `div` 2)
  | odd x = x : chain (x * 3 + 1)

--x小于100的时候长度大于15的链个数
biggerThanFifty = length (filter isLong (map chain [1 .. 100]))
  where
    isLong xs = length xs > 15

--map也可以用来生成一组函数
listOfFuns = map (*) [0 ..]

multipleFive = (listOfFuns !! 4) 5

--一个codewars的习题
nbYear :: Int -> Double -> Int -> Int -> Int
nbYear p0 percent a p = length (takeWhile (< p) (map cal [1,2 ..]))
  where
    rate = 1.0 + percent / 100.0
    cal 1 = p0
    cal n = floor (fromIntegral (cal (n - 1)) * rate) + a
