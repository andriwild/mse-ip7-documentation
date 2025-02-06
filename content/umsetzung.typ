#import "@preview/codly:1.2.0" : *
#import "/utils/todo.typ": TODO
#show: codly-init
#pagebreak()

= Umsetzung 
Dieses Kapitel beschreibt die Umsetzung einer Software zum Betreiben einer Edge ML Kamera. Das System umfasst die Erfassung von Bildern, Ausführen einer Operation jeglicher Art, die aus einem Bild Resultate generiert, und die Weiterverarbeitung dieser Resultate.

Die Entwicklung erfolgte in drei Iterationen, bei welchen jeweils die erstellte Architektur reflektiert und anhand der gewünschten Qualitäten angepasst wurde.

Zuerst wird die Systemarchitektur vorgestellt, gefolgt von den wichtigsten Aspekten des Softwaredesigns. Anschliessend folgen verschiedene Prototypen zur Umsetzung konkreter Beispiele.

== Systemarchitektur
Damit das System für Citizen Science geeignet ist, muss es self-contained und flexibel an neue Szenarien anpassbar sein. Dafür sind drei modular austauschbare Komponenten entscheidend: die Bildquelle mit Buffer, die Bildanalyse durch eine Operation und die Verarbeitung der Analysedaten. Besonders die Bildanalyse, die meist eine Machine-Learning-Inferenz umfasst, erfordert individuelle Anpassungen. Da Modelle spezifisches Pre- und Postprocessing benötigen, lässt sich keine allgemeine Implementierung für verschiedene ML-Frameworks realisieren.

=== Komponentendiagramm
Die folgende @pipeline_komponenten zeigt eine Übersicht des Systems. Eine `Source` repräsentiert die Quelle eines Bildes, wie zum Beispiel eine Kamera. Als Buffer zwischen der Analyse und der Source dient eine `Queue`. Bei der Operation handelt es sich um die Komponente der Analyse. Dies kann eine Machine Learning Inferenz sein oder eine andere Operation, die ein Bild verarbeitet und ein Resultat generiert. Anschliessend gelangt der Output der Operation in eine oder mehrere `Sinks`. Die Sink verarbeitet die Daten weiter, sodass sie den Anforderungen des Projekts entsprechen. Beispielsweise können die Ergebnisse per HTTP-Request gesendet oder in einer Datenbank gespeichert werden.

#TODO[Frames weglassen]
#figure(
  image("../figures/pipeline_komponenten.png", width: 100%),
  caption: [Pipeline Komponenten\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<pipeline_komponenten>

Ein erwähnenswerter Punkt ist der Buffer für erfasste Bilder. Grundsätzlich ist das System für Biodiversitätsmonitoring ausgelegt, weshalb die Zeit zur Erfassung von Bildern limitiert ist durch die Lichtverhältnisse.  Somit ist für die Analyse potentiell mehr Zeit verfügbar als für die Aufnahme der Bilder. Defaultmässig wird eine In-Memory-Queue verwendet. Es ist aber durchaus möglich, dass beispielsweise eine Queue mit Zugriff auf eine externe Festplatte verwendet wird. Diese Implementierung lässt sich durch Einhalten der Queue-Schnittstelle leicht auf eigene Bedürfnisse anpassen.

=== Qualitäten
Da die Software für verschiedenste Anwendungen zum Einsatz kommen kann und dafür jeweils auch angepasst oder erweitert werden muss, ist das Hauptaugenmerk auf die folgenden Qualitätskriterien gelegt worden:

- Einfachheit: Der Code ist in Python geschrieben, einer Programmiersprache, die bei Forschenden einen hohen Bekanntheitsgrad geniesst. Die Struktur und Implementierungen sind jeweils einfach gehalten, so dass sie beim Lesen des Codes leicht verständlich und interpretierbar sind.

- Modularisierung: Alle Komponenten, die austauschbar sind, sind durch abstrakte Klassen vorgegeben. Interfaces, wie man sie aus anderen Sprachen kennt, stehen in Python nicht zur Verfügung.

- Dokumentation: Die Applikation muss je nach Use Case angepasst oder erweitert werden. Dies gelingt besser, wenn der Code gut strukturiert und dokumentiert ist.

- Typisierung: Klassen und Methoden sind mit klar definierten Datentypen versehen, wodurch die Lesbarkeit und das Verständnis des Codes verbessert werden.

- Logging: Die Applikation verfügt über ein integriertes Logging, das je nach Bedarf auf verschiedenen Ebenen aktiviert werden kann, um Debugging und Einarbeitung zu erleichtern.

=== Konfiguration
Das System lässt sich mittels Konfigurationsfile definieren. Die Konfiguration enthält im Wesentlichen drei Komponenten, einen für jeden auswechselbaren Teil der Software. Somit lassen sich mehrere Sources, Operations und Sinks definieren. Diese Einzelteile können dann zur Laufzeit mittels Webinterface angepasst werden. Dieser Mechanismus erleichtert das angenehme Beobachten und Anpassen einer Pipeline.

Das folgende @config zeigt eine Beispielkonfiguration mit jeweils einer Option für jeden Komponententyp.

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

Jede Komponente definiert die folgenden Attribute:
- `name`: Der Name der Komponente, damit man ihn später über das Konfigurationsinterface identifizieren kann.
- `file_path`: Der Pfad zur Datei, in der die zu ladende Klasse implementiert ist.
- `class_name`: Die zu ladende Klasse aus dem definierten File. In Python können mehrere Klassen in einer Datei implementiert sein.
- `parameters` (optional): Ist ein Satz an Parametern, die der Klasse beim Initialisieren übergeben werden. Weil diese Parameter sehr anwendungsspezifisch sind, ist die Struktur dieses Objekts offen gelassen.

Die Applikation lädt alle Komponenten beim Start mithilfe eines `ClassLoader` Mechanismus und speichert deren Instanzen intern. Durch die Namen können die Komponenten zur Laufzeit flexibel ein- oder ausgeschaltet werden. Ein einfaches Anwendungsbeispiel ist das Umschalten zwischen einem Kamerastream und einem Testbild.

=== Webinterface
Die Applikation startet nebst den genannten Komponenten auch ein Webinterface zur Konfiguration des laufenden Systems. Komponenten lassen sich über die Dropdown-Menüs selektieren.

Die @webinterface zeigt ein Screenshot des Interfaces.

#TODO[delete Choose in interface]

#figure(
  image("../figures/webinterface.png", width: 50%),
  caption: [Klassen Diagramm\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<webinterface>

Das Webinterface wird standardmässig auf Port 8001 ausgeliefert.

== Software Design 

#TODO[Referenz auf Buch]

In diesem Abschnitt wird aufgezeigt, wie die einzelnen Komponenten miteinander kommunizieren.

Zu diesem Zweck wird folgend ein Klassendiagramm mit den relevanten Elementen dargestellt. Die zentrale Komponente stellt die Klasse Pipeline dar. Diese hat eine Beziehung zu einer Source, Operation und Sink. Die Pipeline orchestriert den Datenfluss zwischen den einzelnen Komponenten. Mittels Setter-Methoden auf der Pipeline lassen sich die austauschbaren Komponenten über das Webinterface konfigurieren.

Während der Entwicklung wurde das Design kontinuierlich angepasst um sicherzustellen, dass Abhängigkeiten reduziert werden und somit die Einfachheit gefördert wird. Gleichzeitig wurde versucht, sich auf die Kernfunktionalitäten des Systems zu beschränken und Features mit wenig Funktionalität zu beseitigen. 

\
#figure(
  image("../figures/architecture_V2.png", width: 100%),
  caption: [Klassen Diagramm\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<architecture_V2>


//https://mermaid.live/edit
//sequenceDiagram
//    participant Source
//    participant Queue
//    participant Thread
//    participant Pipeline
//    participant Operation
//    participant Sink1
//    participant Sink2
//
//    Thread->>+Source: get_frame()
//    Source-->>-Thread: Frame
//    Thread->>Queue: put(frame)
//
//    Pipeline->>+Queue: get()
//    Queue-->>-Pipeline: Frame
//    Pipeline->>+Operation: process(frame)
//    
//    Operation-->>-Pipeline: Resultat
//    Pipeline->>Sink1: put(result)
//    Pipeline->>Sink2: put(result)


\
Um die zeitlichen Abläufe darzustellen, ist folgend ein vereinfachtes Sequenzdiagramm dargestellt.
Die Pipeline ist dafür verantwortlich, dass ein Thread zur Erfassung von Bildern gestartet wird. Diese Bilder werden in einer Thread-Safe-Queue zwischengespeichert. Im Haupt-Thread der Applikation holt die Pipeline ein Bild von der Queue ab und führt die Operation aus. Anschliessend übergibt die Pipeline die Resultate einer oder mehrerer Sinks. Es kann mehrere Sinks geben, weil die Möglichkeit bestehen soll, Resultate abzuspeichern und gleichzeitig auf der Konsole oder auf einem Webinterface visuell darzustellen.
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

Dieser Prototyp setzt den Referenz-Use-Case aus @referenz_use_case mit verschiedenen Modellen um.
Die Analysen wurden jeweils mit Testbildern durchgeführt, daher ist der Energieverbrauch ohne Kamera zu betrachten.
Die folgende @mw_analyse_comp zeigt die Beziehung zwischen der Anzahl Blumen auf einem Bild und der Zeit für die Bestäuberanalyse.
Die angegebene Zeit beinhaltet die Detektierung der Blüten sowie die Detektierung von Bestäubern auf jeder detektierten Blüte.

#figure(
  image("../figures/mw_analyse_comp.png", width: 100%),
    caption: [Mitwelten Analyse - Framework Vergleich\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
]
)<mw_analyse_comp>

Aus @mw_analyse_comp geht hervor, dass alle drei Pipelines die zeitlichen Anforderungen erfüllen.
Dabei ist auch ersichtlich, dass sich die Ergebnisse aus der Analyse in @analyse widerspiegeln.

==== ONNX

Die Analyse hat gezeigt, dass die Ausführung der Modelle im ONNX-Format schon eine beträchtliche Zeiteinsparung pro Inferenz zur Folge hat. Zu diesem Zweck sind die Mitwelten-Modelle mittels Ultralytics-Exportfunktion in das ONNX-Format konvertiert worden. Aus @mw_analyse_comp ist ersichtlich, dass der Zeitbedarf der Mitweltenanalyse im Bereich des Akzeptablen liegt.  Der Energieverbrauch liegt bei rund 10 Watt.
Durch den linearen Zusammenhang zwischen Anzahl Blumen und Inferenzzeit können wir die maximale Anzahl Blumen ermitteln, welche innerhalb der 15 Sekunden berechenbar ist.
Mit den Datenpunkten 4 Blumen in 2,051 Sekunden und 27 Blumen in 12,168 Sekunden lässt sich für 15 Sekunden rund 33 Blumen analysieren.

$ m = (y_2 - y_1) / (x_2 - x_1) = (27 - 4) / (12.168s- 2.051s)  = 2.275 $
$ b = y_1 - (m * x_1) = 4 - (2.275 * 2.051s) = -0.66 $
$ y = m * x + b  = 2.275 * 15 -0.66 = 33.465 $ 


==== NCNN
Aus @analyse ist zu erwarten, dass die Umsetzung der Mitwelten-Analyse mit NCNN-Modellen nochmals deutlich schneller wird. Dies zeigt auch die Umsetzung dieses Prototyps. Der Zeitbedarf entspricht etwa der Hälfte von der Umsetzung mit ONNX-Modellen, während der Energiebedarf mit rund 10 Watt etwa gleich bleibt. \

Die Konvertierung des Bestäuber-Modells in das NCNN-Format verursachte einige Schwierigkeiten. Folglich wurde das Yolov8n als alternative trainiert und verwendet. Die Yolov8-Generation ist eine Weiterentwicklung der Yolov5-Modelle. Das Yolov8n (nano) Modell ist von der Geschwindigkeit her vergleichbar mit dem Yolov5s (small), welches für die Bestäuberanalyse verwendet wurde @ultralytics_yolov5_nodate-1. Allerdings soll an dieser Stelle erwähnt sein, dass das ursprüngliche Modell mit einer Grösse von 480 × 480 trainiert worden ist. Dies wurde bei der adaptierung auf Yolov8 nicht berücksichtigt. Somit dürfte sich durch das leicht kleinere Modell die Inferenzdauer in einem ähnlichen Bereich bewegen.

Die Berechnung, wie viele Blüten in 15 Sekunden analysiert werden könnten, ergab in diesem Fall durch Einsetzen der Datenpunkte 4 Blüten in 1.179 Sekunden und 27 Blüten in 6,11 Sekunden erhalten wir das Resultat von 68,47 Blüten, welche in 15 Sekunden analysiert werden könnten.

==== Hailo
Eine weitere Implementierung wurde mit der Beschleuniger-Hardware von Hailo umgesetzt.
Um Modelle auf dieser Hardware auszuführen, müssen diese in das von Hailo definierte hef-Format konvertiert werden.
Dies erreicht man mit der vom Hersteller zur Verfügung gestellten Software-Suite @noauthor_software_nodate.
Diese beinhaltet im Wesentlichen einen Parser, Optimierer und Compiler. Diese Prozesse müssen 
für jedes Modell richtig konfiguriert werden. Dafür ist die Untersuchung des zu konvertierenden Modells unerlässlich.
Der folgende Befehl in @hailo_compiler_cmd zeigt beispielhaft, wie ein Kompilierungsprozess ausgeführt werden kann.

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

Speziell für die end-node-names muss das Modell mit einem Tool wie netron.app untersucht werden, damit diese gefunden werden können. Netron stellt die interne Struktur eines Machine Learning Modells anhand eines Graphen dar.
Ebenso können Anpassungen in der YAML-Datei, welche mit dem Flag --yaml angegeben wird, nötig sein. Diese YAML-Datei definiert weitere Parameter zur Beschreibung des Modells.
Zusätzlich wird eine .alls-Datei geladen, welche verwendet wird, um den Output-Node richtig zu konfigurieren. Auch dieses File verweist noch auf eine Postprocessing-Config Datei, welche die End-Nodes nach dem Parsing-Prozess von Hailo definiert. Diese müssen je nach Modell angepasst werden. Die verschiedenen Konfigurationsfiles werden von Hailo in ihrem eigenen Model Zoo zur Verfügung gestellt @noauthor_hailo_model_zoohailo_model_zoocfg_nodate.
Um die Nodes nach dem Parsing zu finden, stellt Hailo einen Profiler zur Verfügung. Folgende @hailo_profiler zeigt einen Screenshot des Hailo-Profiler-Interfaces. Der Ausschnitt zeigt einige Nodes eines Yolov8n-Modells.

#figure(
  image("../figures/hailo_profiler.png", width: 100%),
    caption: [Teil eines Hailo Model Graph Yolov8n\
    (Quelle: Screenshot Hailo Profiler, Andri Wild, 2025)
]
)<hailo_profiler>

Weil dieser Prozess für die bestehenden Yolov5-Modelle nicht erfolgreich war, kamen an dieser Stelle neu trainierte Yolov8-Modelle zum Einsatz.
Das Training der Modelle lag an dieser Stelle nicht im Fokus, daher weisen diese nicht die gleiche Präzision auf wie die Yolov5-Modelle. Dies ist der Grund, dass auf @mw_analyse_comp weniger Blüten bei der Hailo-Pipeline ersichtlich sind.
Die Untersuchung der Inferenzzeiten für die Bestäuberanalyse zeigt beeindruckende Resultate. Auch mit vielen Blüten ist die Performance sehr gut. Die Gesamtzeit der Inferenz von 13 Blüten dauert rund 20 Millisekunden.
Des Weiteren ist auch der Energiebedarf bei rund 5 Watt, was der Hälfte der CPU-betriebenen Pipelines entspricht. Die Gesamtauslastung der CPU ist durch die Auslagerung allgemein sehr tief, so dass diese von 2,5 GHz auf 1,7 GHz gedrosselt wird.

=== Prototyp 2 - AI-Camera
Der zweite Prototyp verwendet die AI-Camera. Um eigens trainierte Modelle auf der AI-Camera auszuführen, müssen diese für den Sony IMX500-Chip konvertiert werden @noauthor_imx500_nodate. Dieser Prozess ist nicht trivial und konnte im Kontext dieser Arbeit nicht mehr erarbeitet werden.
Trotzdem soll an dieser Stelle ein Use Case mit dieser Hardware vorgestellt werden.
Eine besondere Eigenschaft der AI-Camera ist, dass diese zugleich mit dem Bild die Inferenzresultate liefert. Dies hat zur Folge, dass das Host-System praktisch unbelastet ist. Dies ermöglicht das Abarbeiten von anderen Tasks durch die freie Rechenleistung oder das Verwenden von weniger leistungsfähiger Hardware.

Erwähnenswert ist in diesem Setup die Konfiguration. Das @config_ai_cam zeigt, dass die AI-Kamera sowohl als `source` als auch als `pipe` definiert ist.

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

#TODO[Cache, Singleton nicht möglich]

== Erweiterung und Adaptierung der Anwendung
Die Installation der Anwendung ist im `README.md` des Github-Repository ausführlich beschrieben und dient als Anleitung für die Inbetriebnahme.
In der Anleitung werden auch die wichtigsten Schritte zur Erweiterung des Systems aufgeführt. Zudem bestehen für die auswechselbaren Komponenten Beispielimplementierungen. Um die Entwicklung zu vereinfachen, findet man im Utitlity-Ordner einige Helferfunktionen.
