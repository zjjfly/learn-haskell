module Ch07.DataSet where

import qualified Data.List as L
import qualified Data.Set as S

text1 = "I just had an anime dream. Anime... Reality... Are you so different?"

text2 =
  "The old man left his garbage can out and now his trash is all over my lawn!"

-- fromList把一个list转成set
fromListSet =
  let set1 = S.fromList text1
      set2 = S.fromList text2
  in (show set1, show set2)

-- intersection取两个set的交集
intersectionSet =
  let set1 = S.fromList text1
      set2 = S.fromList text2
  in S.intersection set1 set2

-- difference取在第一个set而不在第二个set中的元素
differenceSet =
  let set1 = S.fromList text1
      set2 = S.fromList text2
  in (S.difference set1 set2, S.difference set2 set1)

-- 取两个set的并集
unionSet =
  let set1 = S.fromList text1
      set2 = S.fromList text2
  in S.union set1 set2

-- 几个实用的函数
isNull = S.null S.empty

-- true
size = S.size $ S.fromList [3, 4, 5, 5, 4, 3]

single = S.singleton 9

insert = S.insert 4 $ S.fromList [9, 3, 8, 1]

-- 判断子集和真子集
isSubset = S.fromList [1, 3, 4] `S.isSubsetOf` S.fromList [1, 2, 3, 4, 5]

isProperSubset = S.fromList [1, 3, 4] `S.isProperSubsetOf` S.fromList [1, 3, 5]

filtered=S.filter odd $ S.fromList [3,4,5,6,7]
mapped=S.map (+1) $ S.fromList [3,4,5,6,7]

--Set的常见的用途就是去掉List中的重复元素,相比nub函数,它更适合处理大的list
