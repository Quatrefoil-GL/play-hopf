
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/ |js-ffi/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {} $ 'comp-container
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (store)
            let
                states $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  .unwrap $ get store :states
                  Map Tag app.updater/SceneStateNode
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  .unwrap $ get states :cursor
                  List Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  match (get states :data)
                    (:some raw) raw
                    (:none)
                      {} $ :tab :portal
                  Map Tag app.updater/SceneStateNode
                tab $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  .unwrap $ get state :tab
                  , 'Tag
                scaled 0.01
              scene ({})
                group
                  {}
                    :scale $ [] scaled scaled scaled
                    :position $ [] -0.4 1 -0.4
                  ambient-light $ {} $ :color 0x666666
                  comp-hopf $ quatrefoil.util.core/require-decoded $ try-decode-map-as (>> states :hopf) (Map Tag app.updater/SceneStateNode)
                  point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
                  point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                    :position $ [] 0 60 0
          :examples $ []
          :schema $ quote $ Fn (Map Tag app.updater/SceneStateNode) (-> quatrefoil.schema/Component)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
            quatrefoil.core :refer $ defcomp >>
            app.comp.hopf :refer $ comp-hopf
    'app.comp.hopf $ %{} 'FileEntry
      :defs $ {}
        'HopfCircle $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct HopfCircle
            :center $ Tuple Number Number Number
            :vx $ Tuple Number Number Number
            :vy $ Tuple Number Number Number
            :scale Number
          :examples $ []
          :schema $ quote StructDef
        'HopfControlValue $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion HopfControlValue Number Bool (List Number)
          :examples $ []
          :schema $ quote UnionDef
        'as-bool $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-bool (value)
            quatrefoil.util.core/require-decoded $ try-decode-map-as value 'Bool
          :examples $ []
          :schema $ quote $ Fn HopfControlValue (-> Bool)
        'as-number $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-number (value)
            quatrefoil.util.core/require-decoded $ try-decode-map-as value 'Number
          :examples $ []
          :schema $ quote $ Fn HopfControlValue (-> Number)
        'as-number-list $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-number-list (value)
            quatrefoil.util.core/require-decoded $ try-decode-map-as value $ List Number
          :examples $ []
          :schema $ quote $ Fn HopfControlValue
            -> $ List Number
        'comp-hopf $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-hopf (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  .unwrap $ get states :cursor
                  List Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  match (get states :data)
                    (:some raw)
                      or raw $ {}
                        :from $ [] 0 0
                        :r0 1
                        :delta-r 0
                        :size 10
                        :scale 10
                        :layers 1
                        :spiral? false
                    (:none)
                      {}
                        :from $ [] 0 0
                        :r0 1
                        :delta-r 0
                        :size 10
                        :scale 10
                        :layers 1
                        :spiral? false
                  Map Tag app.comp.hopf/HopfControlValue
                size $ ceil $ as-number
                  .unwrap $ get state :size
                layers $ ceil $ as-number
                  .unwrap $ get state :layers
                r0 $ as-number $ .unwrap (get state :r0)
                d-r $ as-number $ .unwrap (get state :delta-r)
                center $ as-number-list $ .unwrap (get state :from)
                center-x $ list-number-at center 0
                center-y $ list-number-at center 1
                center3 $ assert-type ([] center-x center-y 0) (Tuple Number Number Number)
                th-step $ / (* 2 &PI) size
                scale $ as-number $ .unwrap (get state :scale)
                spiral? $ as-bool $ .unwrap (get state :spiral?)
              group ({})
                point-light $ {} (:color 0xffffff) (:intensity 10) (:distance 600)
                  :position $ [] 0 10 0
                group
                  {} $ :position $ [] 0 8 0
                  comp-value-2d
                    {} (:label |From) (:speed 2) (:color 0xffff55) (:show-text? true) (:fract-length 1) (:value center)
                      :position $ [] 0 10 0
                    fn (v d!)
                      hint-fn $ Fn (List Number)
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :from v
                  comp-value
                    {} (:speed 2) (:color 0x5555ff) (:label |r0) (:show-text? true) (:fract-length 0) (:value r0)
                      :position $ [] 34 0 0
                    fn (v d!)
                      hint-fn $ Fn Number
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :r0 v
                  comp-value
                    {} (:speed 4) (:color 0xaaaaff) (:label |size) (:show-text? true) (:fract-length 0) (:value size)
                      :position $ [] 40 0 0
                    fn (v d!)
                      hint-fn $ Fn Number
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :size v
                  comp-value
                    {} (:speed 4) (:color 0x5555ff) (:label |scale) (:show-text? true) (:fract-length 0) (:value scale)
                      :position $ [] 44 0 0
                    fn (v d!)
                      hint-fn $ Fn Number
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :scale v
                  comp-value
                    {} (:speed 4) (:color 0x55ffaa) (:label |delta-r) (:show-text? true) (:fract-length 0) (:value d-r)
                      :position $ [] 44 -4 0
                    fn (v d!)
                      hint-fn $ Fn Number
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :delta-r v
                  comp-value
                    {} (:speed 4) (:color 0x5555ff) (:label |layers) (:show-text? true) (:fract-length 0) (:value layers)
                      :position $ [] 48 -4 0
                    fn (v d!)
                      hint-fn $ Fn Number
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :layers v
                  comp-switch
                    {} (:color 0xaaffdd) (:label |spiral?) (:show-text? true) (:fract-length 0) (:value spiral?)
                      :position $ [] 48 8 0
                    fn (v d!)
                      hint-fn $ Fn Bool
                        Fn (List Tag) (Map Tag HopfControlValue) (-> Unit)
                        -> Unit
                      d! cursor $ assoc state :spiral? v
                sphere $ {} (:radius 0.4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-basic) (:color 0xffffff) (:opacity 0.3) (:transparent true)
                group ({}) & $ -> layers (range)
                  map $ fn (idx)
                    hint-fn $ Fn Number $ -> quatrefoil.schema/Shape
                    let
                        r $ + r0 $ * idx d-r
                      tube $ {} (:points-fn lowed-circle-fn)
                        :factor $ HopfCircle :center center3 :vx ([] r 0 0) :vy ([] 0 r 0) :scale scale
                        :radius 0.04
                        :tubular-segments 80
                        :radial-segments 8
                        :position $ [] 0 0 0
                        :material $ {} (:kind :mesh-standard) (:color 0x7777ff) (:opacity 0.4) (:transparent true)
                group ({}) & $ -> layers (range)
                  map $ fn (layer-idx)
                    hint-fn $ Fn Number $ -> quatrefoil.schema/Shape
                    group ({}) & $ -> size (range)
                      map $ fn (idx)
                        hint-fn $ Fn Number $ -> quatrefoil.schema/Shape
                        let
                            r1 $ + r0 (* d-r layer-idx)
                              if spiral?
                                * idx $ / d-r size
                                , 0
                            x $ + center-x $ * r1
                              cos $ * idx th-step
                            y $ + center-y $ * r1
                              sin $ * idx th-step
                            th $ get-angle x y
                            len $ c-length $ complex x y
                            r $ c-length $ complex len 2
                            vertical-angle $ get-angle 2 len
                            rail-r len
                            rail-center $ assert-type
                              []
                                * rail-r $ cos th
                                * rail-r $ sin th
                                , 0
                              Tuple Number Number Number
                            h $ * r $ sin vertical-angle
                            w $ * r $ cos vertical-angle
                            th2 $ + th $ * 0.5 &PI
                            vx $ assert-type
                              []
                                * r $ cos th
                                * r $ sin th
                                , 0
                              Tuple Number Number Number
                            vy $ assert-type
                              []
                                * w $ cos th2
                                * w $ sin th2
                                , h
                              Tuple Number Number Number
                          tube $ {} (:points-fn lowed-circle-fn)
                            :factor $ HopfCircle :center rail-center :vx vx :vy vy :scale scale
                            :radius 0.08
                            :tubular-segments $ if
                              > (* scale r) 10
                              , 100 60
                            :radial-segments 3
                            :position $ [] 0 0 0
                            :material $ {} (:kind :mesh-standard)
                              :color $ layer-color layer-idx
                              :opacity 1
                              :transparent true
          :examples $ []
          :schema $ quote $ Fn (Map Tag app.updater/SceneStateNode) (-> quatrefoil.schema/Component)
        'const-2PI $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def const-2PI (&* 2 &PI)
          :examples $ []
          :schema $ quote Number
        'get-angle $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-angle (x y)
            cond
                > x 0
                math-atan $ / y x
              (< x 0)
                + &PI $ math-atan $ / y x
              (> y 0) (* 0.5 &PI)
              (< y 0) (* -0.5 &PI)
              true 0
          :examples $ []
          :schema $ quote $ Fn Number Number (-> Number)
        'layer-color $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn layer-color (idx)
            match idx (0 0xaaaa00) (1 0x685aff) (2 0x00ff85) (3 0x00fff9) (4 0xff66aa) (_ 0xaaaaff)
          :examples $ []
          :schema $ quote $ Fn Number (-> Number)
        'list-number-at $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn list-number-at (xs idx)
            (nth xs idx) .unwrap
          :examples $ []
          :schema $ quote $ Fn (List Number) Number (-> Number)
        'lowed-circle-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn lowed-circle-fn (t factor)
            let
                center $ :center factor
                vx $ :vx factor
                vy $ :vy factor
                scale $ :scale factor
                th $ * t const-2PI
                cos-v $ cos th
                sin-v $ sin th
              []
                * scale $ + (list-number-at center 0)
                  * cos-v $ list-number-at vx 0
                  * sin-v $ list-number-at vy 0
                * scale $ + (list-number-at center 2)
                  * cos-v $ list-number-at vx 2
                  * sin-v $ list-number-at vy 2
                negate $ * scale $ + (list-number-at center 1)
                  * cos-v $ list-number-at vx 1
                  * sin-v $ list-number-at vy 1
          :examples $ []
          :schema $ quote $ Fn Number HopfCircle
            -> $ Tuple Number Number Number
        'math-atan $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn math-atan (x)
            quatrefoil.util.core/require-decoded $ try-decode-map-as (js/Math.atan x) 'Number
          :examples $ []
          :schema $ quote $ Fn Number (-> Number) (:features :js-ffi)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.hopf
          :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.complex :refer $ &c* &c+ &c- c-length complex
            quatrefoil.comp.control :refer $ comp-value comp-value-2d comp-switch
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ quote $ Ref (Map Tag app.updater/SceneStateNode)
        'MobileDetectHost $ %{} 'CodeEntry (:doc |)
          :code $ quote $ deftrait MobileDetectHost
            .mobile? $ Fn app.main/MobileDetectHost $ -> (JsNullish String)
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} $ :mobile? |mobile
          :schema $ quote Trait
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            if (list? op)
              reset! *store $ updater @*store
                decode-map-as op $ List Tag
                decode-map-as op-data $ Map Tag app.updater/SceneStateValue
              let
                  tag $ decode-map-as op Tag
                  store $ if (= tag :states)
                    let
                        args $ decode-map-as op-data $ Tuple (List Tag) (Map Tag app.updater/SceneStateValue)
                      let[] (path state) args $ updater @*store path state
                    , @*store
                reset! *store store
                , &unit
            , &unit
          :examples $ []
          :schema $ quote $ Fn Action Payload (-> Unit) (:generics Action Payload) (:features :js-ffi :state)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (load-console-formatter!) (inject-tree-methods)
            set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
              :position $ [] 0 1 1
              :aspect $ / (viewport-width) (viewport-height)
            let
                canvas-el $
                  query-selector |canvas
                  , .unwrap
              init-renderer! canvas-el $ {} $ :background 0x110022
            render-app!
            add-watch! *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            init-controls!
            println |App-started!
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'mobile? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mobile? ()
            let
                detector $ js-cast (new mobile-detect js/window.navigator.userAgent) 'app.main/MobileDetectHost
              js-present? $ detector .mobile?
          :examples $ []
          :schema $ quote $ Fn (-> Bool) (:features :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (non-nil? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!)
                when (mobile?) (clear-control-loop!) (handle-control-events)
                remove-watch! *store :changes
                add-watch! *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println |Code-updated.
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :state)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            |@quatrefoil/utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! init-controls! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            |three :as THREE
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop!
            |mobile-detect :default mobile-detect
            |bottom-tip :default hud!
            |./calcit.build-errors :default build-errors
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            js-ffi.browser :refer $ viewport-width viewport-height query-selector
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'SceneStateAtom $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion SceneStateAtom Tag Number
          :examples $ []
          :schema $ quote UnionDef
        'SceneStateNode $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion SceneStateNode Tag Number Bool (List SceneStateAtom) (Map Tag SceneStateNode)
          :examples $ []
          :schema $ quote UnionDef
        'SceneStateValue $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion SceneStateValue Tag app.comp.hopf/HopfControlValue
          :examples $ []
          :schema $ quote UnionDef
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store path state)
            decode-map-as
              update-states store $ [] path state
              Map Tag SceneStateNode
          :examples $ []
          :schema $ quote $ Fn (Map Tag SceneStateNode) (List Tag) (Map Tag SceneStateValue)
            -> $ Map Tag SceneStateNode
          :tests $ [] $ %{} 'TestEntry (:name |typed-nested-scene-state)
            :code $ quote $ let
                store $ {} $ :states
                  {} $ :cursor $ []
                state $ {}
                  :from $ [] 1 2
                  :spiral? true
                  :layers 3
                next $ updater store ([] :hopf) state
                expected $ {} $ :states
                  {}
                    :cursor $ []
                    :hopf $ {} $ :data state
              assert= expected next
            :tags $ #{} :unit
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ quatrefoil.cursor :refer $ update-states
