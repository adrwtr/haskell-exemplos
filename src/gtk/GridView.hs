module Main where

{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}


import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (Action, backspace)
-- import Graphics.UI.Gtk.TreeList (treeViewColumnAddAttribute)

hello :: (ButtonClass o) => o -> IO ()
hello b = set b [buttonLabel := "Hello World"]

data Pessoa = Pessoa { nome :: String, idade :: Int }



main :: IO ()
main = do
    void initGUI
    window <- windowNew

    set window [windowTitle := "Table", containerBorderWidth := 20,
        windowDefaultWidth := 450, windowDefaultHeight := 400]

    -- row=3 cols=2
    table   <- tableNew 6 2 True
    containerAdd window table

    label <- labelNew (Just "Lista de pessoas:")
    -- col 0 ate 2 row 0 ate 1
    tableAttachDefaults table label 0 2 0 1

    button3 <- buttonNewWithLabel "Quit"
    onClicked button3 mainQuit
    tableAttachDefaults table button3 0 2 5 6

    -- Cria um modelo de dados usando um ListStore
    model <- listStoreNew [Pessoa "João da Silva" 30
        , Pessoa "Maria da Chica" 25
        , Pessoa "Pedro Golzaga" 40]

    -- Cria um componente de GtkTreeView
    treeView <- treeViewNewWithModel model

    -- Cria uma coluna para o nome da pessoa
    nameColumn <- treeViewColumnNew
    cellRendererName <- cellRendererTextNew
    treeViewColumnPackStart nameColumn cellRendererName False
    treeViewColumnSetTitle nameColumn "Nome"

    cellLayoutSetAttributes nameColumn cellRendererName model
            $ \(Pessoa n _) -> [cellText := n]

    treeViewAppendColumn treeView nameColumn

    -- Cria uma coluna para a idade da pessoa
    ageColumn <- treeViewColumnNew
    cellRendererAge <- cellRendererTextNew
    treeViewColumnPackStart ageColumn cellRendererAge True
    treeViewColumnSetTitle ageColumn "Idade"

    cellLayoutSetAttributes ageColumn cellRendererAge model
            $ \(Pessoa _ a) -> [cellText := show a]
    treeViewAppendColumn treeView ageColumn

    tableAttachDefaults table treeView 0 2 1 3


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