module Ch03.BasicTypeSpec where

import SpecHelper

spec :: Spec
spec = do
  describe "字符的两种数字表示法:" $ do
    it "'\\97'=='a'" $ x' `shouldBe` x''
    it "'\\x61'=='a'" $ x'' `shouldBe` 'a'
  describe "可以用chr把Int转换成Char" $ it "chr 97=='a'" $ charFromInt `shouldBe` 'a'
  describe "问题:写一个检查list或者list的第一个元素是否是空的表达式." $
    it "答案:null list || null (head list)" $ do
      let list = [[], ['a', 'b']]
      null list || null (head list) `shouldBe` True
  describe "问题:检测list是否只有一个元素" $
    it "答案:not (null list) && null (tail list)" $ do
      let list1 = ['a']
      let list2 = ['a', 'b']
      not (null list1) && null (tail list1) `shouldBe` True
      not (null list2) && null (tail list2) `shouldBe` False
  describe "问题:把list中嵌套的两个list相连" $
    it "答案:firstElmt ++ secondElmt" $ do
      let list = ["abc", "de"]
      let firstElmt = head list
      let secondElmt = head (tail list)
      firstElmt ++ secondElmt `shouldBe` "abcde"
