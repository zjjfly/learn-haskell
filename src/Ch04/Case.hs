module Ch04.Case where

--Haskell也有case语法,用于对变量进行模式匹配
--函数参数的模式匹配实际上就是case的语法糖
head' :: [a] -> a
-- head' [] = error "No head for empty lists!"
-- head' (x:_) = x
--等价下面的代码
head' xs =
  case xs of
    [] -> error "No head for empty lists!"
    x:xs -> x

--函数参数的模式匹配只能用在定义函数的时候,而case表达式可运用在任意地方
describeList :: [a] -> String
describeList xs =
  "This list is " ++
  case xs of
    [] -> "empty."
    [x] -> "a single list."
    _ -> "a longer list."

--下面这样写也是可以的
describeList' :: [a] -> String
describeList' xs = "This list is " ++ what xs
  where
    what [] = "empty."
    what [_] = "a single list."
    what _ = "a longer list."