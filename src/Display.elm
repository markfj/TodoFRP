module Display (display) where

import Graphics.Input (FieldState)
import Model (Task)
import open Inputs

-- Actually display the entire Todo list.
display : (Int,Int) -> FieldState -> [Task] -> Element
display (w,h) fieldState tasks =
  let pos = midTopAt (relative 0.5) (absolute 40) in
  layers [ tiledImage w h "/texture.png"
         , container w h pos <| flow down [ header
                                          , inputBar fieldState
                                          , flow down (map displayTask tasks) ]
         ]

header : Element
header = 
    flow down
      [ width 500 . centered . Text.color (rgb 179 179 179) . Text.height 48 <| toText "todos"
      , color (rgb 141 125 119) (spacer 500 15)
      , color (rgb 108 125 119) (spacer 500 1 ) ]

inputBar : FieldState -> Element
inputBar fieldState =
    let grey = rgb 247 247 247 in
    color grey . container 500 45 midRight . color grey . width 440 . height 45 <|
          taskField.field id "What needs to be done?" fieldState

-- Display a specific task.
displayTask : Task -> Element
displayTask task =
    let btn : (Text -> Text) -> Element
        btn f = container 30 30 middle . text . Text.height 28 . f <| toText "&times;"
        grey = rgb 230 230 230
    in 
        color (rgba 255 255 255 0.9) . container 500 30 midRight <|
        flow right [ container 410 30 midLeft . text <| toText task.description
                   , taskDelete.customButton task.id
                         (btn <| Text.color grey) (btn id) (btn bold)
                   ]