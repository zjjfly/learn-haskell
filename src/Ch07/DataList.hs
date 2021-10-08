module Ch07.DataList where

import Data.Function as F
import Data.List as L
import qualified Data.Set as S

-- Data.List模块
-- intersperse取一个值和一个列表,把这个值插入列表的每两个元素之间
intersperseByDot = L.intersperse '.' "Monkey" --"M.o.n.k.e.y"

-- intercalate接受两个参数,一个[a]和一个元素是[[a]],它在这些[a]中插入第一个参数,
-- 最后返回的也是一个[a].很适合用于把一个字符串List转换成一个用特定分隔符拼接起来的字符串
intercalateByBlank = L.intercalate " " ["hey", "there", "guys"] --"hey there guys"

-- unwords = intercalate " "的简写
intercalateByBlank' = L.unwords ["hey", "there", "guys"] --"hey there guys"

-- transpose,把一个[[a]]的行和列掉转
transposeTest = L.transpose [[1, 2, 3], [3, 4, 5], [6, 7, 8]] --[[1,3,6],[2,4,7],[3,5,8]]

-- foldl'和foldl1'是foldl和foldl1的严格版本,如果使用后者碰到了内存溢出问题,就换成前者
-- concat把[[a]]转换成[a],类似flatten
concatTest = L.concat ["foo", "bar", "car"]

-- concatMap,相当于flatMap
concatMapTest = L.concatMap (L.replicate 3) [1, 2, 3]

-- and和or,在BasicType中介绍过了
-- any和all,看名字就知道是做啥的,比and和or用的多
anyTest = L.any (> 4) [1, 2, 3, 4, 5] --true

allTest = L.all (> 4) [1, 2, 3, 4, 5] --false

-- iterate,类似java8的Stream.iterate
iterateTest = take 10 $ L.iterate (* 2) 1 --求2的1到10次幂

-- splitAt取一个List和数值作参数，将该List在特定的位置断开。
splitList = L.splitAt 3 "heyman"

splitList' = L.splitAt 100 "heyman" --("heyman","")

splitList'' = L.splitAt (-1) "heyman" --("","heyman")

splitAndReverse =
  let (a, b) = L.splitAt 3 "foobar"
  in b ++ a

-- takeWhile,和Scala中的类似,只取List中符合条件的部分,一旦条件不符合,直接结束
takeGT3 = L.takeWhile (> 3) [6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 4, 3, 2, 1]

takeNotBlank = L.takeWhile (/= ' ') "This is a sentence"

-- dropWhile,一旦条件不符合,返回List余下的数据
dropNotBlank = L.dropWhile (/= ' ') "This is a sentence"

dropGT3 = L.dropWhile (< 3) [1, 2, 2, 2, 3, 4, 5, 4, 3, 2, 1]

stock =
  [ (994.4, 2008, 9, 1)
  , (995.2, 2008, 9, 2)
  , (999.2, 2008, 9, 3)
  , (1001.4, 2008, 9, 4)
  , (998.3, 2008, 9, 5)
  ]

dayGT1000 = L.head $ L.dropWhile (\(s, _, _, _) -> s < 1000) stock

-- span和takeWhile类似,但它返回两个List,一个和takeWhile返回的一样,一个是List剩下的部分
spanList =
  let (fw, rest) = L.span (/= ' ') "This is a sentence"
  in "First word:" ++ fw ++ ",the rest:" ++ rest

-- break是在条件首次为True的时候断开,break p = span (not . p)
breakList = L.break (== ' ') "This is a sentence"

-- sort对List排序,List的元素必须实现了Ord
sorted = L.sort [8, 5, 3, 2, 1, 6, 4, 2]

sorted' = L.sort "This will be sorted soon" --"    Tbdeehiillnooorssstw"

-- group取一个List,并把其中相邻且相等的元素放入同一个List中
nums = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 2, 2, 2, 5, 6, 7]

groupList = L.group nums --[[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]]

--若在group之前先对其排序,可以知道每个元素出现的次数
countElement = map counter sorted
  where
    counter l@(x:_) = (x, length l)
    sorted = L.group $ L.sort nums

-- inits和tails和init和tail类似,只是会递归的调用自身,直到List中没有元素,可以用于实现正向最大匹配和反向最大匹配
initsOfList = L.inits "w00t" --["","w","w0","w00","w00t"]

tailsOfList = L.tails "w00t" --["w00t","00t","0t","t",""]

-- 使用tails实现一个子List搜索
search :: Eq a => [a] -> [a] -> Bool
search needle haystack =
  foldl accumulator False $
  L.takeWhile (\xs -> length xs >= nlen) $ L.tails haystack
  where
    accumulator accu x = take nlen x == needle || accu
    nlen = length needle

-- Data.List中其实已经有isInfixOf和上面的search的功能其实类似
-- isInfixOf从一个List中搜索一个子List,若该List包含子List,则返回True
isInfix = "cat b" `isInfixOf` "i am a cat burglar"

-- isPrefixOf和isSuffixOf则是判断是否已这个子List开头和结尾
isPrefix = "hey" `isPrefixOf` "hey here"

isSuffix = "here" `isSuffixOf` "hey here"

-- elem和notElem测试一个List中是否有某个元素
-- partition根据传入的判断函数把一个List分成两个list,和Scala中的类似
-- partition和span以及break是不一样的
partitionList = L.partition (`elem` ['A' .. 'Z']) "BOBsidneyMORGANeddy"

-- find,类似Java中的findFirst,返回的是Maybe a,类似Java的Optional<a>
findSome = L.find (> 4) [1, 2, 3, 4, 5] --Just 5,类似Some(5)

findNothing = L.find (> 9) [1, 2, 3, 4, 5] --Nothing

--elemIndex和elem类似,但返回的是这个元素的可能的索引值,类型Maybe
elemIndexOf = 3 `elemIndex` [1, 2, 3, 4, 5, 3]

--elemIndices返回的是索引的list,所以不需要使用Maybe
elemIndicesOf = ' ' `elemIndices` "Where are the spaces?"

--findIndex返回的首个符合传入的条件的元素的索引值,类型Maybe
findIndexOf = L.findIndex (== 4) [1, 2, 3, 4, 5]

--findIndices返回的所以符合传入的条件的元素的索引值的list
findIndicesOf = L.findIndices (`elem` ['A' .. 'Z']) "Where Are The Caps?"

--zip3,zipWith3...4,5直到7,用法和zip,zipWith类似
zip3List = zip3 [1, 2, 3] [4, 5, 6] [7, 8, 9]

zipWith3List = zipWith3 (\x y z -> x + y + z) [1, 2, 3] [4, 5, 2, 2] [2, 2, 3]

--lines,把字符串使用换行符分隔为[String]
linesString = lines "first line\nsecond line\nthird line"

--unlines,和lines相反
unlinesString = unlines ["first line", "second line", "third line"]

--words,把String根据空格分成多个单词
--unwords则相反
wordsOfString = words "hey these are the words in this sentence"

unwords2String = unwords ["hey", "there", "mate"]

--nub去除list中的重复元素
uniqueList = nub [1, 2, 3, 2, 4, 5, 4]

--delete删除list中首次出现的特定元素
deleteList = delete 'h' $ delete 'h' "hey there ghang!"

deleteList' = delete 'h' . delete 'h' . delete 'h' $ "hey there ghang!"

-- \是差集操作,从左边的集合扣除存在于右边集合的元素
subtractList = [1 .. 10] \\ [2, 5, 9]

-- union是并集操作
unionList = "hey man" `union` "man what's up"

-- "hey manwt'sup"
--insert 把元素插入到list的首个大于等于它的元素之前
insertList = insert 3 [1, 2, 4, 5, 6]

-- [1,2,3,4,5,6]
-- length take等函数的参数或返回值都存在Int类型,这不是很好,但为了向后兼容也不能修改,所以Data.List提供了它们的generic版本
-- 下面就是使用length的generic版本的例子,算一个list的平均值,如果直接使用length会报类型错误
averageList =
  let xs = [1 .. 6]
  in sum xs / genericLength xs

-- nub ,delete,group, union,insert也有一个加上By后缀的版本,这个版本多了一个判断相等性的函数
-- 例子,把一组数字按照正数或负数进行分组
groupByList =
  let values = [2.1, 3.1, -2.1, 4.1, -4.9, 5.2, -1.3, 1.9]
  in groupBy (\x y -> (x > 0) == (y > 0)) values

-- 使用Data.Function的on函数对其进行简化
groupByList' =
  let values = [2.1, 3.1, -2.1, 4.1, -4.9, 5.2, -1.3, 1.9]
  in groupBy ((==) `F.on` (> 0)) values

-- on在语义上更接近自然语言
sortByLength =
  let xs = [[5, 4, 5, 4, 5], [2, 3], [1, 2, 4], [], [9]]
  in sortBy (compare `F.on` length) xs
