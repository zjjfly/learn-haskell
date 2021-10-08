module Ch08.TypeParameter where

-- data定义类型的时候可以加上类型参数,如下面的a,b
data Either' a b
  = Left' a
  | Right' b

-- 类型参数一般用于有容器性质的类型,而且一般类型参数不会印象类型的行为
-- 不要在类型定义的时候加上类型约束,这样会让很多不关心类型的函数也要加上无谓的类型约束
data Vector a =
  Vector a
         a
         a
  deriving (Show)

-- 类型约束最适合的地方是函数声明,例如下面这几个函数
vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) =
  Vector (i + l) (j + m) (k + n) 
  
vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m =
  Vector (i * m) (j * m) (k * m) 
  
scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i * l + j * m + k * n

-- 这三个函数的只有一个类型约束,所有传递给它们的Vector中的元素类型必须是一致的
