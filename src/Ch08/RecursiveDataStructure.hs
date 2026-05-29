module Ch08.RecursiveDataStructure where

-- 递归数据结构,递归数据结构是指在定义一个数据类型的时候,它的某个字段的类型是这个数据类型本身或类型参数是其本身

-- 以定义一个List数据类型为例
-- 使用infixr来定义一个右结合的中缀构造函数
infixr 5 :-:

data List a = Nil | a :-: List a deriving (Show, Eq)

main :: IO ()
main = do
  let list1 = 5 :-: Nil
  print list1
  let list2 = 4 :-: 5 :-: Nil
  print list2

-- 再定义一个中缀函数来concat两个list
infixr 5 .++

(.++) :: List a -> List a -> List a
Nil .++ ys = ys
-- :-:是构造子，所以可以用于模式匹配，同理:也可以
(x :-: xs) .++ ys = x :-: (xs .++ ys)

main2 :: IO ()
main2 = do
  let list1 = 1 :-: 2 :-: Nil
  let list2 = 3 :-: 4 :-: Nil
  let list3 = list1 .++ list2
  print list3

-- 定义一个二叉树数据结构
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)
  | otherwise = Node a left right

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem _ EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right
  | otherwise = False

main3 :: IO ()
main3 = do
  let nums = [8 :: Integer, 6, 4, 1, 7, 3, 5]
  let tree1 = foldr treeInsert EmptyTree nums
  print tree1
  print $ 3 `treeElem` tree1
  print $ 8 `treeElem` tree1
  print $ 100 `treeElem` tree1
