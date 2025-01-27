#import "@preview/codly:1.2.0" : *
#import "/utils/todo.typ": TODO
#show: codly-init
#pagebreak()

= Umsetzung 
#TODO[
    (Was ich tatsächlich Umgesetzt habe)
]
Dieses Kapitel beschreibt die Umsetzung einer Software zum Betreiben einer Machine Learning Pipeline. Das System umfasst die Erfassung von Bildern, ausführen einer Machine Learning Analyse und der Weiterverarbeitung deren Resultate.
Die Einwicklung erfolgte drei Iterationen, bei welchen jeweils die erstellte Architektur reflektiert und anhand der gewünschten Qualitäten angepasst wurden.

== System Architektur
#TODO[
    - Qualitäten (Erweiterbarkeit, Robustheit, Self-contained, Einfachheit)
    - Modularisierung (Komponenten: Cam, ML Framework)
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
#TODO[
(Aufteilung in Klassen)
    - Klassen Diagramm
    - Sequenz Diagramm
]
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
#TODO[
    (welche Konfiguration wurde verwendet)
    - Prototyp 1 
    - Prototyp 2
    - FPS und andere Metriken
]
Der folgende Abschnitt beschreibt verschiedene Setups, welche für den Einsatz der Mitwelten Analyse möglich wären. Alle Ansätze erfüllen die nötigen Anforderungen.
(nicht nur MW)

=== Prototyp 1
#TODO[
    - Mitwelten Analyse auf CPU, ONNX Model, nicht NCNN weil kein export suport
]
=== Prototyp 2
#TODO[
    - Mitwelten Analyse auf edge TPU
]

=== Prototyp 3
#TODO[
    - AI-Camera Setup
]

=== Prototyp 4
#TODO[
    - Hailo Object Detection
]
