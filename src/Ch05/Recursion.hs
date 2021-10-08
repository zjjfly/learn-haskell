module Ch05.Recursion where

--递归一般的流程是,先定义边界条件,在定义函数
--定义函数的时候,一般先取一个元素,然后把剩下的元素重新出传入函数
--list的边界条件一般是空的list,tree的边界条件一般是没有子元素的节点
--几个使用递归实现的函数
maximum' :: Ord a => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
  | x > maxTail = x
  | otherwise = maxTail
  where
    maxTail = maximum' xs

--改用max函数实现会更清晰
maximum'' :: Ord a => [a] -> a
maximum'' [] = error "maximum of empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum' xs)

replicate' :: Integral a => a -> b -> [b]
replicate' n x
  | n <= 0 = []
  | otherwise = x : replicate' (n - 1) x

take' :: Integral a => a -> [b] -> [b]
take' n _
  | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n - 1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

--haskell支持无限list,所以递归不一定要有边界条件
repeat' :: a -> [a]
repeat' x = x : repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

--实现快速排序
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) =
  let smaller = quicksort (filter (< x) xs)
      bigger = quicksort (filter (> x) xs)
  in smaller ++ [x] ++ bigger
