module Main where

import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (Action, backspace)

hello :: (ButtonClass o) => o -> IO ()
hello b = set b [buttonLabel := "Hello World"]

# este exemplo abre uma janela Gtk
# ela possui um botão - ao clicar no botão
# exibe hello word no label do botao

main :: IO ()
main = do
    void initGUI
    window <- windowNew
    button <- buttonNew
    set window [ windowTitle  := "win-test"
        , windowResizable     := True
        , windowDefaultWidth  := 400
        , windowDefaultHeight := 400
        , containerChild := button
        , containerBorderWidth := 10]

    onClicked button (hello button)
    onDestroy window mainQuit

    widgetShowAll window

    mainGUI