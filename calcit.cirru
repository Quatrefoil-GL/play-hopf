
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :native)
      :reload-fn 'app.main/reload!
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (store)
            let
                states $ field store :states
                cursor $ field states :cursor
                state $ either (field states :data)
                  {} $ :tab :portal
                tab $ field state :tab
                scaled 0.01
              scene ({})
                group
                  {}
                    :scale $ [] scaled scaled scaled
                    :position $ [] -0.4 1 -0.4
                  ambient-light $ {} $ :color 0x666666
                  comp-hopf $ >> states :hopf
                  point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
                  point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                    :position $ [] 0 60 0
          :examples $ []
          :schema $ :: 'Dynamic
        'field $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn field (value key)
            option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
            quatrefoil.core :refer $ defcomp >>
            app.comp.shapes :refer $ comp-shapes comp-quilling
            app.comp.hopf :refer $ comp-hopf
    'app.comp.hopf $ %{} 'FileEntry
      :defs $ {}
        'circle-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn circle-fn (t factor)
            let
                c0 $ &list:nth factor 0
                vx $ &list:nth factor 1
                vy $ &list:nth factor 2
                scale $ &list:nth factor 3
                th $ &* t const-2PI
              rotate-yz $ v-scale
                &v+ c0 $ &v+
                  v-scale vx $ js-number $ js/Math.cos th
                  v-scale vy $ js-number $ js/Math.sin th
                , scale
          :examples $ []
          :schema $ :: 'Dynamic
        'comp-hopf $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-hopf (states)
            let
                cursor $ field states :cursor
                state $ or (field states :data)
                  {}
                    :from $ [] 0 0
                    :r0 1
                    :delta-r 0
                    :size 10
                    :scale 10
                    :layers 1
                    :spiral? false
                size $ js-number $ js/Math.ceil (field state :size)
                layers $ js-number $ js/Math.ceil (field state :layers)
                r0 $ field state :r0
                d-r $ field state :delta-r
                center $ field state :from
                th-step $ / (* 2 &PI) size
                scale $ field state :scale
                spiral? $ field state :spiral?
              group ({})
                point-light $ {} (:color 0xffffff) (:intensity 10) (:distance 600)
                  :position $ [] 0 10 0
                group
                  {} $ :position $ [] 0 8 0
                  comp-value-2d
                    {} (:label |From) (:speed 2) (:color 0xffff55) (:show-text? true) (:fract-length 1)
                      :value $ field state :from
                      :position $ [] 0 10 0
                    fn (v d!)
                      d! cursor $ assoc state :from v
                  comp-value
                    {} (:speed 2) (:color 0x5555ff) (:label |r0) (:show-text? true) (:fract-length 0)
                      :position $ [] 34 0 0
                      :value $ field state :r0
                    fn (v d!)
                      d! cursor $ assoc state :r0 v
                  comp-value
                    {} (:speed 4) (:color 0xaaaaff) (:label |size) (:show-text? true) (:fract-length 0)
                      :position $ [] 40 0 0
                      :value $ field state :size
                    fn (v d!)
                      d! cursor $ assoc state :size v
                  comp-value
                    {} (:speed 4) (:color 0x5555ff) (:label |scale) (:show-text? true) (:fract-length 0)
                      :position $ [] 44 0 0
                      :value $ field state :scale
                    fn (v d!)
                      d! cursor $ assoc state :scale v
                  comp-value
                    {} (:speed 4) (:color 0x55ffaa) (:label |delta-r) (:show-text? true) (:fract-length 0)
                      :position $ [] 44 -4 0
                      :value $ field state :delta-r
                    fn (v d!)
                      d! cursor $ assoc state :delta-r v
                  comp-value
                    {} (:speed 4) (:color 0x5555ff) (:label |layers) (:show-text? true) (:fract-length 0)
                      :position $ [] 48 -4 0
                      :value $ field state :layers
                    fn (v d!)
                      d! cursor $ assoc state :layers v
                  comp-switch
                    {} (:color 0xaaffdd) (:label |spiral?) (:show-text? true) (:fract-length 0)
                      :position $ [] 48 8 0
                      :value $ field state :spiral?
                    fn (v d!)
                      d! cursor $ assoc state :spiral? v
                sphere $ {} (:radius 0.4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00)
                  :emissiveIntensity 1
                  :roughness 0
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-basic) (:color 0xffffff) (:opacity 0.3) (:transparent true)
                group ({}) & $ -> layers (range)
                  map $ fn (idx)
                    tube $ {} (:points-fn lowed-circle-fn)
                      :factor $ let
                          r $ + r0 $ * idx d-r
                        [] ([] & center 0) ([] r 0 0) ([] 0 r 0) scale
                      :radius 0.04
                      :tubular-segments 80
                      :radial-segments 8
                      :position $ [] 0 0 0
                      :material $ {} (:kind :mesh-standard) (:color 0x7777ff) (:opacity 0.4) (:transparent true)
                group ({}) & $ -> layers (range)
                  map $ fn (l-idx)
                    group ({}) & $ -> size (range)
                      map $ fn (idx)
                        let
                            r1 $ + r0 (* d-r l-idx)
                              if spiral?
                                * idx $ / d-r size
                                , 0
                            x $ + (first center)
                              * r1 $ cos $ * idx th-step
                            y $ + (last center)
                              * r1 $ sin $ * idx th-step
                            th $ get-angle x y
                            len $ c-length $ complex x y
                            r $ c-length $ complex len 2
                            vertical-angle $ get-angle 2 len
                            left-edge $ - len r
                            rail-r len
                            rail-center $ []
                              * rail-r $ cos th
                              * rail-r $ sin th
                              , 0
                            h $ * r $ sin vertical-angle
                            w $ * r $ cos vertical-angle
                            th2 $ + th $ * 0.5 &PI
                            vx $ []
                              * r $ cos th
                              * r $ sin th
                              , 0
                            vy $ []
                              * w $ cos th2
                              * w $ sin th2
                              , h
                          ; println |point x y
                          tube $ {} (:points-fn lowed-circle-fn)
                            :factor $ [] rail-center vx vy scale
                            :radius 0.08
                            :tubular-segments $ if
                              &> (&* scale r) 10
                              , 100 60
                            :radial-segments 3
                            :position $ [] 0 0 0
                            :material $ {} (:kind :mesh-standard)
                              :color $ layer-color l-idx
                              :opacity 1
                              :transparent true
          :examples $ []
          :schema $ :: 'Dynamic
        'const-2PI $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def const-2PI (&* 2 &PI)
          :examples $ []
          :schema $ :: 'Dynamic
        'field $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn field (value key)
            option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        'get-angle $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-angle (x y)
            cond
                > x 0
                js/Math.atan $ / y x
              (< x 0)
                + &PI $ js-number $ js/Math.atan (/ y x)
              (> y 0) (* 0.5 &PI)
              (< y 0) (* -0.5 &PI)
              true 0
          :examples $ []
          :schema $ :: 'Dynamic
        'js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        'layer-color $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn layer-color (idx)
            case-default idx 0xaaaaff (0 0xaaaa00) (1 0x685aff) (2 0x00ff85) (3 0x00fff9) (4 0xff66aa)
          :examples $ []
          :schema $ :: 'Dynamic
        'lowed-circle-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn lowed-circle-fn (t factor)
            let
                c0 $ &list:nth factor 0
                vx $ &list:nth factor 1
                vy $ &list:nth factor 2
                scale $ &list:nth factor 3
                th $ &* t const-2PI
                cos-v $ js-number $ js/Math.cos th
                sin-v $ js-number $ js/Math.sin th
              []
                &* scale $ -> (&list:nth c0 0)
                  &+ $ &* cos-v $ &list:nth vx 0
                  &+ $ &* sin-v $ &list:nth vy 0
                &* scale $ -> (&list:nth c0 2)
                  &+ $ &* cos-v $ &list:nth vx 2
                  &+ $ &* sin-v $ &list:nth vy 2
                negate $ &* scale $ -> (&list:nth c0 1)
                  &+ $ &* cos-v $ &list:nth vx 1
                  &+ $ &* sin-v $ &list:nth vy 1
          :examples $ []
          :schema $ :: 'Dynamic
        'rotate-yz $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn rotate-yz (v)
            let[] (x y z) v $ [] x z $ negate y
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.hopf
          :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* q+ invert
            quaternion.vector :refer $ v-scale &v+ v3
            quaternion.complex :refer $ &c* &c+ &c- c-length complex
            quatrefoil.app.materials :refer $ cover-line
            quatrefoil.comp.control :refer $ comp-value comp-value-2d comp-switch
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *store
            {}
              :tasks $ {} $ 100
                {} (:id 100) (:text "|Initial task") (:done? false)
              :states $ {} $ :cursor ([])
          :examples $ []
          :schema $ :: 'Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
          :examples $ []
          :schema $ :: 'Dynamic
        'ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        'js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            load-console-formatter!
            inject-tree-methods
            set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
              :position $ [] 0 1 1
              :aspect $ /
                js-number $ .-innerWidth $ ffi-object js/window
                js-number $ .-innerHeight $ ffi-object js/window
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} $ :background 0x110022
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            init-controls!
            println "|App started!"
          :examples $ []
          :schema $ :: 'Dynamic
        'mobile? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mobile?
            .!mobile $ new mobile-detect js/window.navigator.userAgent
          :examples $ []
          :schema $ :: 'Dynamic
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (some? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!)
                when mobile?
                  clear-control-loop!
                  handle-control-events
                remove-watch *store :changes
                add-watch *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println "|Code updated."
          :examples $ []
          :schema $ :: 'Dynamic
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            |@quatrefoil/utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! init-controls! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            app.updater :refer $ [] updater
            |three :as THREE
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            |mobile-detect :default mobile-detect
            |bottom-tip :default hud!
            |./calcit.build-errors :default build-errors
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-data)
            case-default op store $ :states $ update-states store op-data
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ quatrefoil.cursor :refer $ update-states
