module Ch07.DataMap where

import Data.Char
import qualified Data.Map as M

-- haskell中的map就是一个二元组的list
phoneBook =
  [("jjzi", "15962194109"), ("cjl", "15150424601"), ("jjzi", "12345678")]

findKey :: (Eq k) => k -> [(k, v)] -> v
findKey key xs = (snd . head . filter (\(k, _) -> key == k)) xs

findKey' :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey' _ [] = Nothing
findKey' key ((k, v):xs) =
  if key == k
    then Just v
    else findKey' key xs

-- 一般来说使用fold比使用递归更好
findKey'' :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey'' key =
  foldr
    (\(k, v) acc ->
       if k == key
         then Just v
         else acc)
    Nothing

-- 使用Data.Map中的函数更方便
fromlist = M.fromList [(1, 2), (3, 4)]

-- fromList传入的list中如果有重复的键,后面的会把前面的覆盖
fromlist' = M.fromList [(1, 2), (1, 3), (3, 4)]

-- 创建一个空的Map
emptyMap = M.empty

-- 插入键值对
inserted = M.insert 5 6 fromlist

-- 实现一个简化版的fromList
fromList' :: (Ord k) => [(k, v)] -> M.Map k v
fromList' = foldr (\(k, v) acc -> M.insert k v acc) M.empty

-- 判断是否是空Map
isEmpty = M.null M.empty

phoneMap = M.fromList phoneBook

-- 返回Map的size
mapSize = M.size $ phoneMap

-- 初始化一个单个元素的Map
singleElemMap = M.singleton 1 2

-- lookup方法,通过key查找值,返回类型是Maybe,类似Scala中的get
lookUp = M.lookup "jjzi" phoneMap

-- member方法,判断key是否存在
isMember = M.member "jjzi" phoneMap

-- map和filter,都是针对value的
mapped = M.map (* 10) $ M.fromList [(1, 2), (3, 4)]

filtered = M.filter (isUpper) $ M.fromList [(1, 'a'), (2, 'B')]

-- toList,fromList的反函数
list = M.toList $ M.insert 1 2 M.empty

-- keys和elems各自返回键和值的list
keys = M.keys phoneMap

elems = M.elems phoneMap

-- fromList会去掉重复值,这很可能不是期望的结果,而fromListWith可以让用户指定如何处理重复key
phoneBookToMap = M.fromListWith (\v1 v2 -> v1 ++ "," ++ v2) phoneBook

-- insertWith之于insert,恰如fromListWith之于fromList
sumInsert = M.insertWith (+) 3 100 $ M.fromList [(3, 4), (5, 103), (6, 339)]