(import [os[path]] 
        [subprocess[check_output]]
        [pathlib[Path]]) 


(defn main [&rest args] 
    (setv files (cut args 1))
    (for [file files]
        (-> file
            (create-compilation-target)
            (save-compilation-target))))


(defn create-compilation-target [filepath] { 
        :filepath (init-target-path filepath)
        :buffer (hy2py filepath) 
}) 


(defn init-target-path [filepath]
    (setv target-path (calc-target-path filepath))
    (force-mkdir (:dirname target-path))
    (:fullpath target-path)) 


(defn calc-target-path [filepath]
    (setv dirname (path.join "build" (path.dirname filepath)))
    (setv filename (.replace (path.basename filepath) ".hy" ".py"))
    (target-path dirname filename)) 


(defn target-path [dirname filename] {
    :dirname dirname
    :filename filename
    :fullpath (path.join dirname filename)
})


(defn hy2py [filepath]
    (-> (check_output ["hy2py3" filepath]) (.decode)))


(defn save-compilation-target [target]
    (write-to-file
        :filepath (:filepath target)
        :buffer (:buffer target))) 


(defn write-to-file [filepath buffer]
    (with [output_file (open filepath "w")]
        (output_file.write buffer))) 


(defn force-mkdir [target-path] 
    (.mkdir (Path target-path) :parents True :exist-ok True)) 


(defmain [&rest args] 
    (main #* args)) 
