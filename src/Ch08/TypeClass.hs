module Ch08.TypeClass where

import GHC.Generics (prec)
import GHC.Maybe 
-- type class类似Java的interface，
-- 它定义了一组函数的类型签名，任何实现了这些函数的类型都可以被认为是这个type class的实例

-- 以一个Person数据类为例：
data Person = Person
  { firstName :: String,
    lastName :: String,
    age :: Int
  }
  deriving (Eq)

-- 它派生了Eq type class,所以它的对象可以使用==和/=进行比较

main :: IO ()
main = do
  let aliceS = Person {firstName = "Alice", lastName = "Smith", age = 30}
  let mikeJ = Person {firstName = "Mike", lastName = "Johnson", age = 30}
  let adamY = Person {firstName = "Adam", lastName = "Yauch", age = 25}
  print (aliceS == mikeJ) -- False
  print (aliceS == aliceS) -- True
  -- Person可以用于类型声明中使用了Eq类约束的函数
  let beastieBoys = [aliceS, mikeJ, adamY]
  print (mikeJ `elem` beastieBoys) -- True

-- 如果一个类型的构造子有参数，那么每个参数的类型都需要实现Eq，这样整个类型才能正确地实现Eq，否则编译器会报错

-- 类型派生Show和Read可以让其和string进行来回的转换
data Car = Car
  { company :: String,
    model :: String,
    year :: Int
  }
  deriving (Show, Read)

main2 :: IO ()
main2 = do
  let car1 = Car {company = "Ford", model = "Mustang", year = 1967}
  print car1 -- Car {company = "Ford", model = "Mustang", year = 1967}
  print $ "This car is: " ++ show car1
  -- This car is: Car {company = "Ford", model = "Mustang", year = 1967}
  -- read函数是把一个字符串转成对象，需要在最后加上类型注释来说明要转成什么类型的对象，否则编译器无法推断出类型
  let car = read "Car {company = \"Benz\", model = \"CLA\", year = 2020}" :: Car
  print car
  -- 也可以read带类型参数的类的对象，但需要把类型参数也在类型注释中写出来
  let maybe = read "Just 3" :: Maybe Int
  print maybe

-- 实现Ord type class的类型，可以使用比较运算符<, >, <=, >=进行比较
-- Bool也实现了Order，且False在True之前，所以False < True
main3 :: IO ()
main3 = do
  print (False `compare` True) -- LT
  print (False < True) -- True
  -- Maybe的构造子中，Nothing在Just之前，所以Nothing比任何的Just都要小
  print (Nothing < Just (-10000)) -- True
  -- Just之间也是可以比较的，因为它们的参数类型实现了Ord
  print (Just 3 < Just 100) -- True

-- 对于枚举，可以使用数字来实现，但最好是使用Enum和Bounded这两个type class来实现更好
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

main4 :: IO ()
main4 = do
  print Monday
  print (read "Monday" :: Day)
  print (Monday < Tuesday) -- True
  -- 实现了Bounded，所以可以使用minBound和maxBound来获取这个类型的最小值和最大值
  print (minBound :: Day) -- Monday
  print (maxBound :: Day) -- Sunday
  -- 实现了Enum，所以可以使用succ和pred来获取下一个值和上一个值
  print (succ Monday) -- Tuesday
  print (pred Tuesday) -- Monday
  print [Monday .. Sunday] -- [Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday]
  -- 获取枚举的所有可能值
  print ([minBound .. maxBound] :: [Day])

-- preclude中的Eq的定义类似下面这样：
-- class Eq a where
--   (==) :: a -> a -> Bool
--   (/=) :: a -> a -> Bool
--   x == y = not (x /= y)
--   x /= y = not (x == y)
-- 我们发现==和/=是互相定义的，这样做的好处是实现的时候只要实现其中一个就可以了，另一个会自动推导出来

-- 为class type定义instance
data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where
  Red == Red = True
  Yellow == Yellow = True
  Green == Green = True
  _ == _ = False

instance Show TrafficLight where
  show Red = "Red light"
  show Yellow = "Yellow light"
  show Green = "Green light"

main5 :: IO ()
main5 = do
  print (Red == Red) -- True
  print (Red == Yellow) -- False
  print (Red `elem` [Red, Yellow, Green]) -- True
  print (show Red) -- Red light

