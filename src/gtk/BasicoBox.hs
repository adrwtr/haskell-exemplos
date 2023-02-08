module Main where

import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (Action, backspace)

hello :: (ButtonClass o) => o -> IO ()
hello b = set b [buttonLabel := "Hello World"]

main :: IO ()
main = do
    void initGUI
    window <- windowNew
    button <- buttonNew
    initGUI

    -- widget box container
    hbox    <- hBoxNew True 10
    button1 <- buttonNewWithLabel "Button 1"
    button2 <- buttonNewWithLabel "Button 2"

    set window [windowDefaultWidth := 200, windowDefaultHeight := 200,
        containerBorderWidth := 10, containerChild := hbox]

    -- # box widget "Se vai crescer" Pading
    boxPackStart hbox button1 PackNatural 0
    boxPackStart hbox button2 PackGrow 0

    onDestroy window mainQuit
    widgetShowAll window
    mainGUI