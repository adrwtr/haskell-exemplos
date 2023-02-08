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

    set window [windowTitle := "Table", containerBorderWidth := 20,
        windowDefaultWidth := 150, windowDefaultHeight := 100]

    -- row=3 cols=2
    table   <- tableNew 4 2 True
    containerAdd window table

    label <- labelNew (Just "Teste Label:")
    -- col 0 ate 2 row 0 ate 1
    tableAttachDefaults table label 0 2 0 1

    button1 <- buttonNewWithLabel "On"
    onClicked button1 (buttonSwitch button1)
    -- col 0 ate 2 row 1 ate 2
    tableAttachDefaults table button1 0 2 1 2

    button2 <- buttonNewWithLabel "Off"
    onClicked button2 (buttonSwitch button2)
    -- col 0 ate 2 row 2 ate 3
    tableAttachDefaults table button2 0 2 2 3

    button3 <- buttonNewWithLabel "Quit"
    onClicked button3 mainQuit
    tableAttachDefaults table button3 0 1 3 4

    button4 <- buttonNewWithLabel "Quit false"
    tableAttachDefaults table button4 1 2 3 4

    onDestroy window mainQuit

    widgetShowAll window
    mainGUI

buttonSwitch :: Button -> IO ()
buttonSwitch b = do
    txt <- buttonGetLabel b
    let newtxt = case txt of
            "Off" -> "On"
            "On"  -> "Off"
    buttonSetLabel b newtxt