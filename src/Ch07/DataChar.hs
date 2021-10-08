module Ch07.DataChar where

import Data.Char as C
import Data.Function as F
import Data.List as L

-- isControl用于判断是否是控制字符
isControlChar = isControl '\t'

-- isSpace用于判断是否是空字符,包括空格,制表符,换行符
isSpaceChar = isSpace ' '

isSpaceChar' = isSpace '\t'

isSpaceChar'' = isSpace '\n'

-- isLower和isUpper用于判断字符是否是小写/大写字母
isLowerChar = isLower 'a'

isUpperChar = isUpper 'B'

-- isDigit判断是否是Assii码中的数字
isDigitChar = isDigit '1'

-- isNumber判断是否是Unicode中的数字,包括很多语言中的数字
isNumberChar = isNumber 'Ⅷ'

-- isAlpha判断是否是Unicode字母型字符,等价于isLetter函数
isAlphaChar = isAlpha 'з'

isAlphaChar' = isAlpha 'Ⅷ' --false

-- isAlphaNum判断是否是Unicode字母
isAlphaNumChar = isAlphaNum 'з'

isAlphaNumChar' = isAlphaNum 'Ⅷ' --true

-- isPrint判断是否是可打印的Unicode字符
isPrintChar = isPrint 'ઋ'

-- isOctDigit判断是否是八进制字符
isOctDigitChar = isOctDigit '7'

-- isHexDigit判断是否是十六进制字符
isHexChar = and [C.isHexDigit 'f', C.isHexDigit 'A']

-- isLetter判断是否是字母,等价于isAlpha
isLetterChar = C.isLetter 'a'

-- isPunctuation判断是否是标点符号
isPunctuationChar = C.isPunctuation ','

-- 判断是否是货币符号
isSymbolChar = C.isSymbol '$'

-- 判断是否是unicode的空格或分隔符
isSeparatorChar = and [C.isSeparator ' ', C.isSeparator '\160']

-- 判断是否是unicode字母表的前128位
isAsciiChar = C.isAscii 'X'

-- 用isSpace来实现Data.List中的words函数
words' :: String -> [String]
words' a = filter (not . all C.isSpace) $ groupBy ((==) `F.on` C.isSpace) a

-- Data.Char中有一个枚举GeneralCategory,里面列举了字符的31中分类
-- 使用generalCategory可以获取到字符所属的分类
charCategory = generalCategory ' '

-- 把字符转成大写或小写
upperChar = toUpper 'a'

lowerChar = toLower 'A'

-- 把字符转成数字
char2int = digitToInt '1'

-- 把数字转成字符,参数必须是0-15
int2char = intToDigit 1

-- 字符和对应的ascii码互相转换
asciiChar = chr 97

assiiCode = ord 'a'

-- 使用chr和ord实现凯撒码加密
encode :: Int -> String -> String
encode shift msg = map chr shifted
  where
    ords = map ord msg
    shifted = map (+ shift) ords
