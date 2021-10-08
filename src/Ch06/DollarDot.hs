module Ch06.DollarDot where

-- $是一个函数调用符,但它的优先级是最低的
--用空格的函数调用是左结合,即f a b c 等价于((f a)b)c
--而$是右结合的,即(f g h c)等价于(f(g(h c)))
--它的作用,就是减少括号数量
sqrtSum = sum (map sqrt [1 .. 130])

sqrtSum' = sum $ map sqrt [1 .. 130]

-- 它还可以把数据当做函数使用
map3 = map ($ 3) [(4 +), (10 *), (^ 2), sqrt]

-- .号在Haskell中是一个中缀函数,它的作用是把两个函数组合成一个函数
-- 它是右结合的,f . g = \x -> f (g x ),f的参数类型必须和g的返回值类型是相同的
absNegative = map (negate . abs) [1, -2, 3, 4, -5]

negateTailSum = map (negate . sum . tail) [[1 .. 5], [3 .. 6], [1 .. 7]]

--如果要组合的函数的参数不止一个怎么办?可以使用不完全调用让每个函数都只剩下一个参数
sumReplicate = sum (replicate 5 (max 6.7 8.9))

--先在最靠近参数的函数后加$,然后把前面的所有函数用.组合起来
sumReplicate' = sum . replicate 5 . max 6.7 $ 8.9

--函数组合的另一个用途是定义point free的函数
--什么是point free style?看下面的例子
sum' :: (Num a) => [a] -> a
-- sum' xs = foldl (+) 0 xs
sum' = foldl (+) 0 --它去掉了xs

--point free的好处是可以让你更多的考虑的是函数的组合方式,而不是数据的传递方式
--还是求小于1000的所有的奇数的平方的和
-- 之前的写法
oddSquareSum = sum (takeWhile (< 1000) (filter odd (map (^ 2) [1 ..])))

-- 函数组合狂人的写法,这种不推荐,过多的函数组合只会带来很差的可读性
oddSquareSum' = sum . takeWhile (< 1000) . filter odd . map (^ 2) $ [1 ..]

-- 最推荐的写法
oddSquareSum'' =
  let oddSquare = filter odd $ map (^ 2) [1 ..]
      belowLimit = takeWhile (< 1000) oddSquare
  in sum belowLimit
