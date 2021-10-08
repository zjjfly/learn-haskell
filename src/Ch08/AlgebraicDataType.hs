module Ch08.AlgebraicDataType
  ( Point(..) -- 导出类型的构造函数
  , Shape'(..)
  , surface' 
  , nudge
  , baseCircle
  , baseRect
  ) where

-- 定义自己的类型的一种方法是使用data
-- data后面跟着的是类型名称,等号右边的是值构造子(value constructor),它表明了类型可能的值
-- Circle的值构造子有三个项,也可以说是三个参数.值构造子其实是函数,可以返回一个类型的值
data Shape
  = Circle Float
           Float
           Float
  | Rectangle Float
              Float
              Float
              Float
  deriving (Show) --deriving声明了它是从什么类型派生出来的

-- 类型可以使用模式匹配
-- 函数声明不能使用值构造子,而是要使用类型名
surface :: Shape -> Float
-- 模式匹配针对的就是构造子
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x1 - x2) * (abs $ y1 - y2)

-- Shape派生自Show,所以可以打印
display = show $ Circle 1 1 1

-- 定义一个Point类型来表示二维的点
data Point =
  Point Float
        Float
  deriving (Show)

data Shape'
  = Circle' Point
            Float
  | Rectangle' Point
               Point
  deriving (Show)

-- 重写surface方法
surface' :: Shape' -> Float
surface' (Circle' _ r) = pi * r ^ 2
surface' (Rectangle' (Point x1 y1) (Point x2 y2)) =
  (abs $ x2 - x1) * (abs $ y2 - y1)

nudge :: Shape' -> Float -> Float -> Shape'
nudge (Circle' (Point x y) r) a b = Circle' (Point (x + a) (y + b)) r
nudge (Rectangle' (Point x1 y1) (Point x2 y2)) a b =
  Rectangle' (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2 + b))

baseCircle :: Float -> Shape'
baseCircle r = Circle' (Point 0 0) r

baseRect :: Float -> Float -> Shape'
baseRect width height = Rectangle' (Point 0 0) (Point width height)
