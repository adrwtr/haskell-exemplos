module Main where

{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}


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
        windowDefaultWidth := 450, windowDefaultHeight := 400]

    -- row=3 cols=2
    table   <- tableNew 4 2 True
    containerAdd window table

    label <- labelNew (Just "Digite seu nome:")
    -- col 0 ate 2 row 0 ate 1
    -- a leitura é igual a, imprime de-até
    -- ou use a área de-até tal valor
    tableAttachDefaults table label 0 2 0 1

    entry1 <- entryNew
    -- col 0 ate 2 row 1 ate 2
    tableAttachDefaults table entry1 0 2 1 2

    button2 <- buttonNewWithLabel "Off"
    onClicked button2 (buttonSwitch button2)
    -- col 0 ate 2 row 2 ate 3
    tableAttachDefaults table button2 0 2 2 3

    button3 <- buttonNewWithLabel "Quit"
    onClicked button3 mainQuit
    tableAttachDefaults table button3 0 1 3 4

    button4 <- buttonNewWithLabel "Quit false"
    onClicked button4 (buttonTest entry1 button4)
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

buttonTest :: Entry -> Button -> IO ()
buttonTest fld b1 = do
    txt <- entryGetText fld
    -- let mesg = "\"" ++ txt ++ "\""
    let mesg = txt ++ ""
    buttonSetLabel b1 mesg
    return ()