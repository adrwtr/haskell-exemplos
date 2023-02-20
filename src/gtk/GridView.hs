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

    table   <- tableNew 6 2 True
    containerAdd window table

    label <- labelNew (Just "Lista de pessoas:")
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

    treeSelection <- treeViewGetSelection treeView
    treeSelectionSetMode treeSelection  SelectionSingle
    onSelectionChanged treeSelection (oneSelection model treeSelection)

    -- adiciona a tree na janela
    tableAttachDefaults table treeView 0 2 1 3

    onDestroy window mainQuit

    widgetShowAll window
    mainGUI


oneSelection :: ListStore Pessoa -> TreeSelection ->  IO ()
oneSelection list tree = do
    sel <- treeSelectionGetSelectedRows tree
    let s = head (head sel)
    (Pessoa nome1 _) <- listStoreGetValue list s
    putStrLn $ "selected " ++ nome1