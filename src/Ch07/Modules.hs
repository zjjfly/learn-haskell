module Ch07.Modules where

import Ch07.DataList
import Data.Bool hiding (otherwise) --引入除otherwise之外的函数,常用于解决命名冲突

-- import Data.List (nub, sort) --只引入部分函数
import Data.List
import qualified Data.Map as M --模块别名,最常用的解决命名冲突的方法

numUnique :: (Eq a) => [a] -> Int
numUnique = length . nub

--Map的filter方法用于过滤出满足条件的值
filtered = M.filter (> "b") (M.fromList [(5, "a"), (3, "c")])

distinctNum = numUnique [1, 2, 3, 4, 1, 3]