module Ch02.FunctionSpec where

import SpecHelper

spec :: Spec
spec = do
  describe "+++可以连接两个list" $
    it "[1,2]+++[3,4] == [1,2,3,4]" $ [1, 2] +++ [3, 4] `shouldBe` [1, 2, 3, 4]
  describe "reverse2可以翻转list" $
    it "reverse2 [1,2,3]==[3,2,1]" $ reverse2 [1, 2, 3] `shouldBe` [3, 2, 1]
