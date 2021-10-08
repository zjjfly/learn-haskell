module Ch08.Record where

-- 如果一个类型的字段太多,那么需要定义很多获取其中的字段的方法
-- 为此,Haskell引入了record syntax
data Person = Person
  { firstName :: String
  , lastName :: String
  , age :: Int
  , height :: Float
  , phoneNumber :: String
  , flavor :: String
  } deriving (Show)

-- Person {firstName="Ford", lastName="Mustang", age=1967,height=1.1,flavor="XXX",phoneNumber="1234567890"}

-- record syntax会自动为每个字段生成getter函数,函数名和字段名一致
-- 如果它派生了Show,它的输出也比一般的类型的可读性更强
data Car = Car
  { company :: String
  , model :: String
  , year :: Int
  } deriving (Show)
  
-- Car {company="Ford", model="Mustang", year=1967}
