module Ch04.Let where

--let绑定类似where绑定
--where对包括所有guard可见,只能定义在函数底部;而let对不同的guard不可见,但可以在任何位置定义
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^ 2
  in sideArea + 2 * topArea

--let的格式是let [bindings] in [expressions]
--let中的绑定仅对in中的表达式可见
--let是表达式,这是它和where最大的不同
num =
  4 *
  (let a = 9
   in a + 1) +
  2

--let也可以定义函数
squares =
  [ let square x = x * x
    in (square 5, square 3, square 2)
  ]

--let可以写成一行,但需要加分号
oneline =
  ( let a = 100
        b = 200
        c = 300
    in a * b * c
  , let foo = "Hey "
        bar = "there!"
    in foo ++ bar)

--在let中使用模式匹配
abc =
  (let (a, b, c) = (1, 2, 3)
   in a + b + c) *
  100

--在list comprehension中使用let,let绑定对限制条件和输出函数都是可见的
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]
