module RVRS.Syntax.Identifier (type Name, nameFromString) where

import Ya hiding (Maybe)
import Ya.ASCII
import Ya.Literal (glyph_to_ascii)

import Data.Char (isAscii, isLetter)
import GHC.IsList (fromList)
import Prelude (Maybe (..), String, otherwise, traverse, (&&), (<$>))

type Name = Nonempty List Letter

nameFromString :: String -> Maybe Name
nameFromString [] = Nothing
nameFromString characters = fromList <$> traverse letterFromChar characters
  where
    letterFromChar character
      | isAscii character && isLetter character =
          case glyph_to_ascii character of
            Letter letter -> Just letter
            _ -> Nothing
      | otherwise = Nothing
