-- Haskell中的module和类型的首字母要大写
module Lib
  ( someFunc
  ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

sayHello :: String -> IO ()
sayHello x = putStrLn ("Hello " ++ x ++ "!")

-- 定义简单的函数
-- 函数的首字母小写,参数小写
triple x = x * 3
