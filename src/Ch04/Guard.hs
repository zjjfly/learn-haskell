module Ch04.Guard where

--guard用于检测一个值的某个属性是否为真,而模式匹配是检测一个值是否合适并从中取值
--guard类似if,但处理多个条件分支时它的可读性更高
bmiTell :: RealFloat a => a -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  --最后的guard往往是otherwise,otherwise其实就是true

--如果所有的guard都没有匹配,也没有otherwise,会转入下一个模式,这是guard和模式匹配结合的方式
--如果始终没有找到匹配的guard或模式,会报错
--使用guard实现max
max' :: Ord a => a -> a -> a
max' a b
  | a > b = a
  | otherwise = b

--guard可以写在一行,但这样可读性不好,所以不推荐这样写
max'' a b
  | a > b = a
  | otherwise = b

--实现自己的compare
myCompare :: Ord a => a -> a -> Ordering
a `myCompare` b --反引号还可以在定义函数的时候使用,有时候这样会更易读
  | a > b = GT
  | a == b = EQ
  | otherwise = LT
