#import "@preview/codly:1.2.0" : *
#import "/utils/todo.typ": TODO
#show: codly-init
#pagebreak()

= Umsetzung 
Dieses Kapitel beschreibt die Umsetzung einer Software zum Betreiben einer Machine Learning Pipeline. Das System umfasst die Erfassung von Bildern, ausführen einer Machine Learning Analyse und der Weiterverarbeitung deren Resultate.
Die Einwicklung erfolgte drei Iterationen, bei welchen jeweils die erstellte Architektur reflektiert und anhand der gewünschten Qualitäten angepasst wurden.

== System Architektur
#TODO[
    - Qualitäten (Erweiterbarkeit, Robustheit, Self-contained, Einfachheit)
    - Modularisierung (Komponenten: Cam, ML Framework)
    - Verworfene Ansätze
]
Damit das System Citizen Science fähig ist, muss es möglichst leicht für neue Szenarien anpassbar sein. Bei den auswechselbaren Komponenten handelst es sich um: 
Die Quelle zum erfassen von Bildern mit einem Buffer, die Analyse der einzelnen Bilder und die Verarbeitung der Analysedaten. Diese drei Komponenten müssen ohne Anpassung von bestehendem Code auswechselbar sein, um die Komplexität für das betreibende Projektteam gering zu halten. Da ein Machine Learning Modell sehr individuell ist, verunmöglicht es eine generelle Implementierung einer Pipeline für verschiedene Modelle.

Ein weiterer wichtiger Punkt ist der Buffer für erfasste Bilder. Grundsätzlich ist das System zur Biodiversitätsüberwachung ausgelegt, weshalb die Zeit zur Erfassung von Bilder limitiert auf auf die Dauer des Sonnenscheins ist. Somit ist für die Analyse potentiell mehr Zeit zur Verfügung als für die Aufnahme der Bilder.


=== Komponenten Diagram
Die folgende @pipeline_komponenten zeigt eine übersicht des Systems. Eine Source repräsentiert die Quelle eines Bildes, wie zum Beispiel eine Kamera. Als Buffer zwischen der Analyse und der Source dient eine Queue. Bei der Operation handelt es sich um die Komponente der Analyse. Dies kann eine Machine Learning Inferenz sein oder eine andere Operation, die ein Bild verarbeitet und ein Resultat generiert. Anschliessend gelangt der Output der Operation in eine oder mehrere Sinks. Die Sink ist jener Komponent, welches das Resultat weiterverarbeitet. Dies ist beispielsweise eine Datenbank. 

#TODO[Frames weglassen]
#figure(
  image("../figures/pipeline_komponenten.png", width: 100%),
  caption: [Pipeline Komponenten\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<pipeline_komponenten>

=== Qualitäten
Da die Software für verschiedenste Anwendungen zum Einsatz kommen kann und dafür jeweils auch angepasst oder erweitert werden muss, ist das Hauptaugenmerk auf die folgenden Qualitäts Kriterien gelegt worden:
- Einfachheit: Der Code ist in Python geschrieben, eine Programmiersprache die gerade bei Forschenden hohen Bekanntheitsgrad geniesst. Implementierungen sind jeweils einfach gehalten, so dass sie beim lesen des Codes leicht verständlich und interpretierbar sind.
#TODO[beispiel, einfacher, komplexer code]
```python
print("hello world")
```
- Modularisierung: Alle Komponenten die austauschbar sind, sind durch abstrakte Klassen ohne Implementierung der Methoden vorgegeben. Interfaces, wie man es aus anderen Sprachen kennt gibt es in Python nicht.

=== Konfiguration
Das System lässt sich mittels Konfigurations File definieren. Die Konfiguration enthält im wesentlichen drei Komponenten, einen für jeden auswechselbaren Teil der Software. Somit lassen sich mehrere Sources, Operations und Sinks definieren. Diese Einzelteile können dann zur Laufzeit angepasst werden. Dieser Mechanismus erleichtert das angenehme beobachten und anpassen einer Pipeline.
Das folgende @config zeigt eine Beispiel Konfiguration mit jeweils einer Option für jeden Komponenten Typ.
#figure(
```yaml
sources:
  - name: webcam
    file_path: ./source/impl/webcam.py
    class_name: Webcam 
    parameters:
      device: "/dev/video0"
      width: 640
      height: 640 
operations:
  - name: detect coco objects
    class_name: UlDetect
    file_path: ./pipe/impl/ulDetect.py
    parameters:
      model_path: ./resources/ml_models/yolo11n.onnx
      label_path: ./resources/labels/coco.txt
      confidence_threshold: 0.5
      nms_threshold: 0.5
sinks:
  - name: console
    class_name: Console
    file_path: ./sink/impl/console.py
```,
    caption: [Beispiel Pipeline Konfiguration],
)<config>

Jede Komponente hat die folgenden Werte, die definiert sein müssen:
- `name`: Der name des Komponenten, damit man ihn später über das Konfigurations Interface erkennen kann.
- `file_path`: Der Pfad zum File, in der die zu ladende Klasse implementiert ist.
- `class_name`: Die zu ladende Klasse aus dem definierten File. In Python können mehrere Klassen in einem File implementiert sein.
- `parameters` (optional): Ist ein Satz an Parameter, die der Klasse beim initialisieren übergeben werden. Weil diese Parameter sehr Anwendungsspezifisch sind, ist die Struktur dieses Objekts offen gelassen.

Auf diese Weise lassen sich unabhängig vom Rest der Software Klassen definieren und in die Pipeline einbinden.

== Software Design 

#TODO[Referenz auf Buch]

In diesem Abschnitt wird aufgezeigt, wie die einzelnen Komponente mit einander kommunizieren.
Zu diesem Zweck ist folgend ein Klassen Diagramm mit den relevanten Elementen darstellt. Die zentrale Komponente stellt die Klasse Pipeline dar. Diese hat eine Beziehung zu der Source, Operation und Sink und orchestriert den Datenfluss zwischen den Komponenten. Mit der Applikation wird auch ein Konfiguration Server gestartet. Mittels setter-Methoden auf der Pipeline lassen sich die Austauschbaren Komponenten konfigurieren. Der Konfigurations-Server liefert ein simples index.html File aus, welches die Optionen aus dem Konfigurationsfile anzeigt. Durch Auswählen und Bestätigen gelangt die Information an den Server zurück, worauf die Pipeline angepasst wird.

\
#TODO[Kardinalität im Diagramm]
#figure(
  image("../figures/architecture_V2.png", width: 100%),
  caption: [Klassen Diagramm\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<architecture_V2>

//```sequenceDiagram
//    participant Source
//    participant Thread1
//    participant Queue
//    participant Pipeline
//    participant Operation
//    participant Sink
//
//
//    Thread1->>+Source: get_frame()
//    Source-->>-Thread1: Frame
//    Thread1->>Queue: put(frame)
//
//    Pipeline->>+Queue: get()
//    Queue-->>-Pipeline: Frame
//    Pipeline->>+Operation: process(frame)
//    
//    Operation-->>-Pipeline: Resultat
//    Pipeline->>Sink: put(result)
//```

\
Um die zeitlichen Abläufe besser dazustellen ist folgend ein vereinfachtes Sequenz Diagramm dargestellt.
Die Pipeline ist dafür verantwortlich, dass ein Thread zur Erfassung von Bildern gestartet wird. Diese Bilder werden in eine Thread-Safe Queue zwischengespeichert. Im Haupt-Thread der Applikation holt die Pipeline ein Bild von Queue ab und führt die Operation aus, wobei es sich zum Beispiel um die Mitwelten Analyse handelt. Anschliessend übergibt die Pipeline die Resultate der Analyse einer oder mehreren Sinks. Es kann mehrere Sinks geben, weil die Möglichkeit bestehen soll, Resultate abzuspeichern und gleichzeitig auf der Konsole oder auf einem Web Interface visuell darzustellen.

#TODO[Mehrzahl Sinks, Thread1 -> Thread]
#figure(
  image("../figures/sequentdiagram_pipeline.png", width: 100%),
    caption: [Pipeline Komponenten \
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
]
)<sequentdiagram_pipeline>


== Prototypen: verschiedene System Setups 
In diesem Kapitel werden zwei unterschiedliche Prototypen vorgestellt, die verschiedene System-Setups für die Anwendung der entwickelten Applikation demonstrieren. Beide Prototypen setzen Machine Learning auf dem Raspberry Pi 5 ein, unterscheiden sich jedoch in ihrer verwendeten Hardware und Konfiguration. Durch den Vergleich dieser Setups lassen sich die Vor- und Nachteile verschiedener Ansätze analysieren und bewerten. 

=== Prototyp 1 - Mitwelten Analyse<prototyp_1>
#TODO[Auslastung]

Dieser Prototyp setzt den Referenz Use Case aus @referenz_use_case mit verschiedenen Modellen um.
Die Analysen wurden jeweils mit Testbildern durchgeführt, daher ist der Energieverbrauch ohne Kamera zu betrachten.
Die folgenden @mw_analyse_comp zeigt die Beziehung zwischen Anzahl Blumen auf einem Bild und der Zeit für die Bestäuber Analyse.
Die angegebene Zeit beinhaltet die Detektierung der Blüten sowie die Detektierung von Bestäuber auf jeder detektierten Blüte.

#figure(
  image("../figures/mw_analyse_comp.png", width: 100%),
    caption: [Mitwelten Analyse - Vergleich\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
]
)<mw_analyse_comp>

Aus @mw_analyse_comp geht hervor, dass alle drei Pipelines die zeitlichen Anforderungen erfüllen.
Dabei ist auch ersichtlich, dass sich die Ergebnisse aus @analyse wiederspiegeln.

==== ONNX
Die Analyse hat gezeigt, dass die Ausführung der Modelle im ONNX Format schon eine beträchtliche Zeiteinsparung pro Inferenz zur Folge hat. Zu diesem Zweck sind die Mitwelten Modelle mittels Ultralytics export Funktion in das ONNX Format konvertiert worden. Aus @mw_analyse_comp ist ersichtlich, dass der Zeitbedarf der Mitwelten Analyse im Bereich des akzeptierbaren liegt.  Der Energieverbrauch liegt bei rund 10W.
Durch den linearen zusammenhang zwischen Anzahl Blumen und Inferenzzeit können wir die maximale Anzahl Blumen ermittlen, welche innerhalb der 15 Sekunden berechenbar sind.
Mit den Datenpunkten: $4 "Blumen" ,2.051 s$ und $27 "Blumen" ,12.168 s$ lässt sich für 15 Sekunden rund 33 Blumen analysieren.

$ m = (y_2 - y_1) / (x_2 - x_1) = (27 - 4) / (12.168s- 2.051s)  = 2.275 $
$ b = y_1 - (m * x_1) = 4 - (2.275 * 2.051s) = -0.66 $
$ y = m * x + b  = 2.275 * 15 -0.66 = 33.465 $ 


==== NCNN
Aus @analyse ist zu erwarten, dass die Umsetzung der Mitwelten Analyse mit NCNN Modellen nochmals deutlich schneller wird. Dies zeigt auch die Umsetzung dieses Prototyp. Der Zeitbedarf entspricht etwa der Hälfte von der Umsetzung mit ONNX Modellen, während der Energiebedarf mit rund 10W etwa gleich bleibt. \
Die Konvertierung des Bestäuber Modells in das NCNN Format verursachte einige Schwierigkeiten. Folglich wurde das Yolov8n als alternative trainiert und verwendet. Die Yolov8 Generation ist eine Weiterentwicklung der Yolov5 Modelle. Das Yolov8n (nano) Modell ist von der Geschwindigkeit vergleichbar mit dem Yolov5s (small), welches für die Bestäuberanalyse verwendet wurde @ultralytics_yolov5_nodate-1. Allerdings soll an dieser Stelle erwähnt sein, dass das ursprüngliche Model mit einer grösse von 480x480 trainiert worden ist. Dies wurde bei der adaptierung auf Yolov8 nicht berücksichtigt, somit dürfte sich die Inferenz Dauer in einem ähnlichen Bereich bewegen.
Die Berechnung, wie viele Blüten in 15 Sekunden analysiert werden könnten ergab in diesem Fall 
Durch Einsetzen der Datenpunke: 27 Blüten in 6.11 Sekunden und 4 Blüten in 1.179 Sekunden, erhalten wir das Resultat von 68.47 Blüten, welche in 15 Sekunden analysiert werden könnten.

==== Hailo
Eine weitere Implementierung wurde mit der Beschleuniger Hardware von Hailo umgesetzt.
Um Modelle auf dieser Hardware auszuführen, müssen diese in das hef Format konvertiert werden.
Dies erreicht man mit der vom Hersteller zur Verfügung gestellten Software Suite @noauthor_software_nodate.
Diese beinhaltet im wesentlichen einen parser, optimierer und compiler. Diese Prozesse müssen 
für jedes Modell richtig konfiguriert werden. Dafür ist die Untersuchung des zu konvertierenden Modells unerlässlich.
Der folgende Befehl in @hailo_compiler_cmd zeigt beispielhaft, wie ein kompilierungs Prozess ausgeführt werden kann.

#figure(
```bash
hailomz compile \
    --hw-arch hailo8l \
    --yaml ./hailo_model_zoo/hailo_model_zoo/cfg/networks/yolov8n.yaml \
    --ckpt /local/shared_with_docker/yolov8n_pollinator_ep50_v1.onnx \
    --classes 5 \
    --end-node-names /model.22/cv2.0/cv2.0.2/Conv /model.22/cv3.0/cv3.0.2/Conv /model.22/cv2.1/cv2.1.2/Conv /model.22/cv3.1/cv3.1.2/Conv /model.22/cv2.2/cv2.2.2/Conv /model.22/cv3.2/cv3.2.2/Conv \
    --calib-path /local/shared_with_docker/pollinators/
```,
    caption: [Hailo Konvertierung]
)<hailo_compiler_cmd>

Speziell für die end-node-names muss das Model mit einem Tool wie netron.app untersucht werden damit diese gefunden werden können.
Ebenso können Anpassungen im yaml file, welches mit dem Flag --yaml angegeben wird nötig sein. Dieses yaml file definiert weitere Parameter zur Beschreibung des Modells.
Zusätzlich wird ein .alls file geladen, welches verwendet wird, um den Output Node richtig zu konfigurieren. Auch dieses File verweist noch auf ein postprocessing config file, welches die end-nodes nach dem parsing process definiert. Diese müssen je nach Modell auch angepasst werden. Die verschiendenen Konfigurationsfiles werden von Hailo in ihrem eigenen Model Zoo zur Verfügung gestellt @noauthor_hailo_model_zoohailo_model_zoocfg_nodate.
Um die Nodes nach dem parsing zu finden stellt Hailo ein profiler zur Verfügung. Folgende @hailo_profiler zeigt ein Screenshot des Hailo Profiler Interfaces. Der Ausschnitt zeigt einige Nodes eines Yolov8n Modells.

#figure(
  image("../figures/hailo_profiler.png", width: 100%),
    caption: [Teil eines Hailo Model Graph Yolov8n\
    (Quelle: Screenshot Hailo Profiler, Andri Wild, 2025)
]
)<hailo_profiler>

Weil dieser Prozess für die bestehenden Yolov5 Modelle nicht erfolgreich war, kamen an dieser Stelle neu trainierte Yolov8 Modelle zum Einsatz.
Das Trainig der Modelle lag an dieser Stelle nicht Fokus, daher weisen diese nicht die gleiche Präzision auf, wie die Yolov5 Modelle. Dies ist auch der Grund, dass die @mw_analyse_comp weniger Blüten bei der Hailo Pipeline hat.
Die Analyse der Inferenzzeiten für die Beustäuber Analyse zeigt beeindruckende Resultate. Auch mit vielen Blüten ist die Performance sehr gut. Die Gesamtzeit der Inferenz von 13 Blüten dauert rund 20ms.
Des weiteren ist auch der Energiebedarf bei rund 5W, was der Hälfte der CPU betriebenen Pipelines entspricht.


=== Prototyp 2 - AI-Camera
#TODO[
    - AI-Camera Setup
]
Der zweite Prototyp verwendet die AI-Camera. Um eigens trainierte Modelle auf der AI-Camera auszuführen, müssen diese für den Sony IMX500 Chip konvertiert werden @noauthor_imx500_nodate. Dieser Prozess ist nicht trivial und konnte im Kontext dieser Arbeit nicht mehr erarbeitet werden.
Trotzdem soll an dieser Stelle ein Use Case mit dieser Hardware vorgestellt werden.
Eine besondere Eigenschaft der AI-Camera ist, dass diese zugleich mit dem Bild die Inerenzresultate liefert. Dies hat zur Folge, dass das Host System praktisch unbelastet ist. Dies ermöglicht das abarbeiten von anderen Tasks durch die freie Rechenleistung oder das Verwenden von weniger Leistungsfähiger Hardware.

Erwähnenswert ist in diesem Setup die Konfiguration. Das @config_ai_cam zeigt, dass die AI-Kamera sowohl als `source`  als auch als `pipe` definiert ist.

#figure(
```yaml
sources:
  - name: AI-Camera 
    file_path: ./source/impl/aiCamera.py
    class_name: AiCamera
    parameters:
      width: 640
      height: 640 
pipes:
  - name: AI-Camera
    file_path: ./source/impl/aiCamera.py
    class_name: AiCamera
sinks:
  - name: console
    class_name: Console
    file_path: ./sink/impl/console.py
```
  ,
    caption: [Konfiguration AI-Kamera\
]
)<config_ai_cam>

Durch die Modularität der Applikation erhält hier die AI-Kamera eine Doppelrolle. Effektiv existiert in der Applikation nur eine Instanz der Klasse `AiCamera`. Die Applikation sorgt beim Laden der Klassen dafür, dass dies sichergestellt ist.

