module Ch02.Function
  ( firstOrEmpty
  , (+++)
  , reverse2
  ) where

firstOrEmpty :: [String] -> String
firstOrEmpty lst =
  if not (null lst)
    then head lst
    else "empty"

infix +++

(+++) :: [a] -> [a] -> [a]
lst1 +++ lst2 =
  if null lst1
    {-多行
      注释
    的写法-}
    then lst2
    else head lst1 : (tail lst1 +++ lst2)

reverse2 :: [a] -> [a]
reverse2 lst =
  if null lst
    then []
    else reverse2 (tail lst) ++ [head lst]

--没有参数的函数称为定义,类似一个不可变的常量
conanOBrien = "It's a-me, Conan O'Brien!"