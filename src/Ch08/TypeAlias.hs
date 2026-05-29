module Ch08.TypeAlias where

import Data.Map as Map

-- 类型别名,用type定义的类型别名,叫作类型构造子，并不会创建一个新的类型
-- 如String，它就是[Char]的别名，String和[Char]是同一个类型
-- 它的作用其实和在其他语言里的类型别名是一样的,主要是为了让代码更清晰,更有可读性

-- 如把DataMap里的phoneBook的类型别名成PhoneBook,这样就不用每次都写[(String, String)]
type PhoneNumber = String

type Name = String

type PhoneBook = [(Name, PhoneNumber)]

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook

-- 定义类型别名的时候也是可以有类型参数的
-- 一个更通用的[(k,v)]的别名
type AssocList k v = [(k, v)]

-- 类型参数可以是具体的类型和类型变量的组合
type IntMap v = Map.Map Int v

-- 也可以这么写
type IntMap' = Map.Map Int

-- 类型构造子不能在值构造子中使用,只能在类型注释中使用

-- 实现一个类似更衣室的柜子的类型
data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
  case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
    Just (state, code) ->
      if state /= Taken
        then Right code
        else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"

main :: IO ()
main = do
  let lockers = Map.fromList [(100, (Taken, "ZD39I")), (101, (Free, "JAH3I")), (103, (Free, "IQSA9")), (105, (Free, "QOTSA")), (109, (Taken, "893JJ")), (110, (Taken, "99292"))]
  print (lockerLookup 101 lockers)
