module Ch02.DataType where

--data type,类似Java中的class
--下面的data type声明了三个构造器,对应政府组织,公司,个人,每个构造器用|分隔
--Haskell中,类型 构造器 type class和kind的首字母都要大写
data Client
  = GovOrg String
  | Company String
            Integer
            Person
            String
  | Individual Person
               String
               Bool
  deriving (Show) {-如果要打印这个类的对象,需要使用Haskell的默认派生这个特性,给这个类型加入功能
  Show是一个type class,实现它意外这有途径可以用一个String标识这个类型的实例,你也可以自己定制展示的内容-}

nasa = GovOrg "NASA"

--ADT中可以使用其他的ADT.下面定义的这个就在Client中使用了
data Person
  --对于只有一个构造器的类型,构造器名和类型名保持一致
      =
  Person String
         String
         Gender
  deriving (Show) --这个类型用在了实现Show的类中,所以必须也要实现Show

--有时候你只在意构造器本身,而不会保存任何额外的信息,类似Java的枚举
data Gender
  = Male
  | Female
  | Unknown
  deriving (Show)

hillstone =
  Company "Hillstone Networks" 1 (Person "Luo Dongping" "Luo" Male) "A"