module Ch02.List where

--list
list = [1, 2, 3]

reverseList = reverse list --反转list

consList = [1, 2, 3] ++ [4, 5, 6] --list相连

concatStr = "Hello," ++ "World" --字符串实际也是list,所以也使用++连接

--Haskell的类型参数用的比较多的是a
-- ++是中缀函数,如果想要使用传统的方式调用,需要下面这样写
consList' = (++) [1, 2, 3] [4, 5, 6]

--Haskell的list的元素的类型必须是相同的,下面的代码是不合法的
-- list=[1,2,3,"s","d"]
list' = 1 : 2 : 3 : [] --另一种list字面量写法,Scala借鉴了这个

--使用!!来使用索引取出list的元素
third = list' !! 2

--两个list中的类型如果都是可比较的类型,那么可以使用比较操作符
--从第一个开始比较,如果相等那么接着比较
cmp = [3, 5] < [3, 5, -1] --如果比较的两个list的长度不一样,且前面的元素都一样,那么长度较长的大

cmp' = [3, 5, 6] > [3, 5, 4]

isEmptyList = null list --null测试list是否是空的

headOfList = head list --head获取list的头元素

lastElmt = last list --last获取list的最后一个元素

initList = init list --init获取list中除了最后一个元素之外的list

tailOfList = tail list --tail获取去除头元素之后的列表

--head,last,init,tail的参数list如果是空的会报错
--Range
range = [1 .. 10]

--指定步长
range' = [3,6 .. 20]

--避免在Range中使用浮点数
--可以不标明上限,会生成一个无限长的List.这一般和take搭配使用
range'' = take 10 [2,4 ..] --take n 表示取前n个元素

--还有几个会产生无限List的方法
manyOneTwoThree = take 10 (cycle [1, 2, 3])

mangFive = take 20 (repeat 5)

---实际编码中,如果想要得到包含相同元素的list,可以使用replicate
mangFive' = replicate 20 5

--List Comprehension
--取前十个偶数
firstTenEven = [x * 2 | x <- [1 .. 10]]

--添加条件
evenBiggerThan12 = [x * 2 | x <- [1 .. 10], x * 2 >= 12]

boomBangs xs =
  [ if x < 10
    then "BOOM!"
    else "BANG!"
  | x <- xs
  , odd x
  ]

nonono = [x | x <- [10 .. 20], x /= 13, x /= 15, x /= 19]

--可以从多个list取元素
xy = [x * y | x <- [2, 5, 10], y <- [8, 10, 11], x * y > 50]

--使用List Comprehension实现length函数
length' xs = sum [1 | _ <- xs] --_的用法和Scala的类似,表示不关心这个值

--字符串也可以使用List Comprehension
removeNonUpperCase st = [c | c <- st, c `elem` ['A' .. 'Z']]

--elem测试元素是否包含在list中.只有两个参数的函数套上反斜杠可以使用中缀语法
--list comprehension可以用于嵌套的list
nested xxs = [[x | x <- xs, even x] | xs <- xxs]