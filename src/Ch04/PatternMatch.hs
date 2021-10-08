module Ch04.PatternMatch where

lucky :: Integral a => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

sayMe :: (Integral a) => a -> String
sayMe 1 = "One"
sayMe 2 = "Two"
sayMe 3 = "Three"
sayMe 4 = "Four"
sayMe 5 = "Five"
sayMe x = "not between 1 to 5"

--模式匹配总是从上往下开始匹配,所以越细的匹配要放在越前面,越宽泛的匹配放在越后面
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial x = x * factorial (x - 1)

--如果匹配不是很全面,会报错
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

--所以,模式匹配最后一定要有一个万能的模式
--模式匹配的用法
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

--之前说过,只有两个元素的tuple有fst和snd方法
--我们可以使用模式匹配来自己实现
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

--模式匹配可以用在List Comprehension 中
sumPair :: Num a => [(a, a)] -> [a]
sumPair xs = [a + b | (a, b) <- xs]

--list本身也可以使用模式匹配,和Scala一样,使用x:xs这样的语法
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x --要绑定多个变量,需要使用括号括起来
head' [x, _] = x --上面模式的另一种写法

--使用模式匹配实现length
length' :: Integral t => [t1] -> t
length' [] = 0
length' (_:xs) = 1 + length' xs

--使用模式匹配实现sum
sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

--在模式匹配中使用@,和Scala类似
capital :: String -> String
capital [] = ""
capital list@(x:_) = "The first letter of " ++ list ++ " is " ++ [x]
