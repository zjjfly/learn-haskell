module Ch03.BasicType
  ( x'
  , x''
  , upper
  , charFromInt
  ) where

import Data.Char
import Data.Ratio
import Data.Typeable ()

-- 字符类型的两种写法
x = 'a'

x' = '\97' --a

x'' = '\x61' --a

--使用Data.Char中提供的函数操作Char
upper = toUpper x

charFromInt = chr 97 --把Int转换成Char,结果是a

-- 数字类型
floatNum = 1 % 2 + 1 % 3 --有理数的表示法,分子 % 分母

ratioFromFloat = toRational 1.3 --toRational把浮点数转成有理数

ratioNum = toRational (fromRational (13 % 10)) --fromRational把有理数转成浮点数

negativeNum = 1 + (-2) --因为Haskell的函数调用的时候参数不套括号,所以要小心,因为-号其实是一个中缀函数

---字符串
string = "hello" --字符串类型是元素是Char的list

list :: [Integer]
list = [1, 2, 3]

--Bool类型
--Haskell中Bool的实例只有True和False
flag = (True && False) || (False && not False)

--有or和and方法,可以接受一个Bool的列表,但一般不会像下面这么用,纯粹演示
flag' = or [True, False, and [False, True, False]]

--Haskell也有浮点数的精度问题,所以下面的值可能是True
floatPrecision = 4.0000000000000004 - 4 == 0

--if then else
--和Scala的类似,是一个表达式,有返回值,并且返回值类型要一致
ifThenElse =
  if not (null list)
    then head list
    else 0

--函数也有类型
-- ::后面跟着函数的类型声明,->前的是参数类型,后面的师返回类型
removeNonUppercase :: String -> String
removeNonUppercase st = [c | c <- st, c `elem` ['A' .. 'Z']]

--多个参数也使用->分隔
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

--Haskell的类型参数一般是a,b,c,d这样的小写字母
pair :: a -> b -> (a, b) --a,b是类型参数
pair x y = (x, y)

--Haskell中的类型类是描述行为的接口,类似OOP语言中的接口
--下面是几个常用的类型类
--Eq,这个类型提供了比较相等性的接口,类似Java中实现了equals方法的类
--Eq提供了两个函数==和/=,凡是属于Eq的类都提供了它们的实现.
--除了函数以外的基本类型都实现了Eq
--Ord,提供了比较大小的接口,有>,>=,<,<=等函数,类似Java的Comparable接口
--还有一个compare函数,返回三种结果:GT,LT,EQ
cmp = (1 `compare` 2) /= GT

--Show,表示可以用字符串表示的类型,类似Java中实现了toString方法的类
--除函数以外的所有基本类型都属于Show类
--最常用的函数式show,类似调用toString方法
toString = show 3

--Read,和Show的作用刚好相反,除函数外的所有基本类型都属于Read类
--常用的方法是read,把字符串转换为一个Read类的对象
readSomeOne = read "True" || False

readSomeOne' = read "1.2" + 1.1

readSomeOne'' = read "[1,2,3]" ++ [4, 5]

--不能单独使用read x,这样编译器不知道你要转换的具体类型,需要在后面加类型注释
readSome = read "1" :: Int

readSome' = read "(1,'3')" :: (Int, Char)

--Enum,连续的类型.它存在的主要用处是在Range表达式中.
--每个值都有后继和前置,分别通过succ和pred函数获取
--它的类型包括(),Bool,Char,Ordering,Int,Integer,Float,Double
a2z = ['a' .. 'z']

ordering = [LT .. GT] --[LT,EQ,GT]

predOfC = pred 'c'

succOfC = succ 'c'

--Bounded的成员都一个上下限
minInt = minBound :: Int

maxChar = maxBound :: Char

maxBool = maxBound :: Bool

minBool = minBound :: Bool

--minBound和maxBound的类型都是(Bounded a) => a,都是多态常量
--如果tuple的每个元素都属于Bounded类型,那么这个tuple也属于Bounded
maxTuple = maxBound :: (Int, Char, Bool)

--Num,表示数字,包括实数和整数
--Integral表示整数,包括Int和Integer
--Floating表示浮点数,包括Float和Double
--有一个很有用的函数fromIntegral
--它的类型是(Num b, Integral a) => a -> b,这里使用的多种类型约束
--它可以把Integral类型的数字转换成Num类型
--在同时处理浮点数和整数的时候很有用
int2num = fromIntegral (length [1, 2]) + 1.2 --length返回类型是Int,可能是历史原因
