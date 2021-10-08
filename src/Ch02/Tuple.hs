module Tuple
  ( maxmin
  ) where

-- tuple,和Scala的类似
--不同元素个数的tuple类型不同
--相同元素数量但元素类型不同的tuple也不算一个类型
tuple =
  ( "hello"
  , True
  , if 2 > 3
      then 'a'
      else 'b')

maxmin :: Ord a => [a] -> (a, a)
maxmin lst =
  if null (tail lst)
    then (head lst, head lst)
    else ( if head lst > fst (maxmin (tail lst))
             then head lst
             else fst (maxmin (tail lst))
         , if head lst < snd (maxmin (tail lst))
             then head lst
             else snd (maxmin (tail lst)))

--上面的代码有很多重复,而且性能也有问题,对其进行优化:
maxmin' :: Ord a => [a] -> (a, a)
--两种本地绑定:let和where.
--let必须以in结尾
maxmin' list =
  let h = head list
  in if null (tail list)
       then (h, h)
       else ( if h > t_max
                then h
                else t_max
            , if h < t_min
                then h
                else t_min)
  where
    t = maxmin' (tail list)
    t_max = fst t
    t_min = snd t

--上面的where还有另一种写法:
--where {t = maxmin (tail list);t_max = fst t;t_min = snd t}
--但这种写法不推荐,一般自动生成代码的时候才考虑这种写法.
--不能有单元素的tuple,Haskell会把括号是认为是多余的而不是认为它们表示tuple
wrong = (1)

--但是可以有空的tuple
right = ()

--tuple也可以像list一样比较,但不能比较不同长度的tuple
compareTuple = (1, 2) > (3, 2)

--几个有用的tuple操作函数
first = fst (1, 2)

second = snd (1, 2)

--上面两个方法只能用于两个元素的tuple,两个元素的tuple也称为序对
--zip,类似Scala中的zip方法,生成序对的list
ziped = zip [1, 2, 3, 4] [2, 3, 1, 1]

--如果两个list的长度不同,较长的会断开匹配较短的
ziped' = zip [1, 3, 4] [6, 4]

--tuple和list混合使用
rightTriangles =
  [ (a, b, c)
  | a <- [1 .. 10]
  , b <- [1 .. 10]
  , c <- [1 .. 10]
  , a ^ 2 + b ^ 2 == c ^ 2
  , a + b + c == 24
  ]
