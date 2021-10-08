module Ch06.Lambda where

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain x
  | even x = x : chain (x `div` 2)
  | odd x = x : chain (x * 3 + 1)

--lambda以\开头,之后是空格分隔的参数,然后是箭头和函数体
numLongChain :: Int
numLongChain = length (filter (\xs -> length xs > 15) (map chain [1 .. 100]))

--但由于Haskell的函数式的特点,其实不用像java和scala那样写很多lambda,而是用柯里化函数
--可以在lambda中使用模式匹配,和scala类似
sumPair = map (\(a, b) -> a + b) [(1, 2), (3, 5), (6, 3), (2, 6), (2, 5)]

--可以使用lambda让我们之前自己实现的flip函数跟容易理解
flip' :: (a -> b -> c) -> b -> a -> c
flip' f = \x y -> f y x --lambda更明确的表明返回值是函数

--fold函数
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

--使用fold实现自己的map函数
map' :: (a -> b) -> [a] -> [b]
-- map' f xs =foldl (\acc x-> acc++ [f x]) [] xs
map' f xs = foldr (\x acc -> f x : acc) [] xs

--foldl1和foldr1的行为和foldl,foldr一样,但是不需要初始值,其实就是reduce函数
sum'' :: (Num a) => [a] -> a
sum'' = foldl1 (+)

maximum' :: (Ord a) => [a] -> a
maximum' =
  foldr1
    (\x acc ->
       if x > acc
         then x
         else acc)

reverse' :: [a] -> [a]
-- reverse' = foldl (\acc x -> x : acc) []
--上面的(\acc x -> x : acc),但是参数位置反了,所以可以使用flip
reverse' = foldl (flip' (:)) []

product' :: (Num a) => [a] -> a
product' = foldr1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p =
  foldr
    (\x acc ->
       if p x
         then x : acc
         else acc)
    []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

--scanr和scanl类似,但返回的是累加值的所有状态的list
--scanl的最终结果是list的最后一个元素,而scanr相反
--它们的作用是可以跟踪fold的中间过程
scanLeft = scanl (+) 0 [3, 5, 2, 1]

--从1开始求平方根的和,到何值的时候平方根的和超过1000
sqrtSums :: Int
sqrtSums = length (takeWhile (< 1000) (scanl1 (+) (map sqrt [1 ..]))) + 1
