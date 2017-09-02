add1 x = x + 1

square x = x * x

square(add1 1)

(square . add1) 1

:type (.) -- > (.) :: (b -> c) -> (a -> b) -> (a -> c)

------------------------------------------------------

add1 (x, log) = (x + 1, log ++ "add1")

square (x, log) = (x * x, log ++ "square")

add2 (x, log) = (x + 2, log)

square(add2(add1 (1, "")))

(square . add2 . add1) (1, "")

------------------------------------------------------

add1 x = (x + 1, "add1")

square x = (x * x, "square")

add2 x = x + 2 -- no logging; unchanged

-- square(add2(add1 1))
-- (square . add2 . add1) 1
-- :type (.) -- > (.) :: (b -> c) -> (a -> b) -> (a -> c)

------------------------------------------------------

add1 x = (x + 1, "add1")
square x = (x * x, "square")
add2 x = x + 2

applyWithLog f (x, log) = let (y, newLog) = f x
                          in (y, log ++ newLog)

apply f (x, log) = (f x, log)

applyWithLog square (apply add2 (add1 1))
square `applyWithLog` (add2 `apply` (add1 1))

------------------------------------------------------

import Control.Monad.Writer

-- newtype Writer w a = Writer { runWriter :: (a, w) }

add1 x = writer (x + 1, "add1")
square x = writer (x * x, "square")
add2 x = x + 2

runWriter (add1 1 >>= (return . add2) >>= square) -- (16, "add1square)
runWriter (square =<< (return . add2) =<< add1 1) -- (16, "add1square)
