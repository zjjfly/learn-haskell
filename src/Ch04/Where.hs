module Ch04.Where where

--where绑定一般用于在函数中声明一些本地变量和函数,它们只对本函数可见
bmiTell :: RealFloat a => a -> a -> String
bmiTell weight height
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where
    bmi = weight / height ^ 2

--再次优化,去除magic数字
bmiTell' :: RealFloat a => a -> a -> String
bmiTell' weight height
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where
    bmi = weight / height ^ 2
    (skinny, normal, fat) = (18.5, 25.0, 30) --where绑定可以使用模式匹配

--where绑定不会再多个模式中共享,如果需要在多个模式中共享变量,就要把它放在全局中
initials :: String -> String -> String
initials (x:_) (y:_) = [x] ++ "." ++ [y]

--where还可以定义函数
calcBims :: RealFloat a => [(a, a)] -> [a]
calcBims xs = [bmi w h | (w, h) <- xs]
  where
    bmi weight height = weight / height ^ 2
