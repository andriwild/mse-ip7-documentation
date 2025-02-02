#import "/utils/todo.typ": TODO
#pagebreak()

= Analyse<analyse>
Dieses Kapitel befasst sich mit der Analyse und Bewertung der Möglichkeiten für die Umsetzung einer Edge ML Kamera. Zuerst werden die Randbedingungen für das System eruiert in dem die Zielgruppe und die Anforderungen erarbeitet werden.
Das Unterkapitel Evaluation stellt anschliessend verschiedene Resultate zu Untersuchungen von ML Frameworks vor. Zum Abschluss von diesem Kapitel werden verschiedene Möglichkeiten für von Hardware Setups vorgestellt.



== Zielgruppe
Ein Edge ML Kamera, welche flexibel für verschiedene Zwecke einsetzbar ist, deckt dementsprechend eine breite Zielgruppe ab. Anwendungen könnten für die folgenden Interessengruppen von Bedeutung sein:

- Forschende: Wissenschaftlerinnen und Wissenschaftler aus den Bereichen Biodiversität, Ökologie oder Umweltwissenschaften.
- Citizen Scientists: Ehrenamtliche, die sich an wissenschaftlichen Projekten beteiligen.
- Naturschutzorganisationen: Institutionen, die Artenschutz- oder Umweltprojekte durchführen.
- Bildungseinrichtungen: Schulen, Universitäten und andere Lernstätten für Lehrzwecke und studentische Forschungsprojekte.
- Landwirtschaftliche Betriebe: Landwirte, die ihr Wissen über Bestäuber und Schädlingsbekämpfung erweitern möchten.

Die Bediener des Systems müssen die Edge ML Kamera in erster Linie für ihre Zwecke und Bedürfnisse anpassen können. Aus diesem Grund ist es von grosser Bedeutung, das System so einfach wie möglich zu halten. Da eine Anwendung spezifische Analyse von Bildern mittels Machine Learning nicht generalisiert werden kann, müssen die Benutzer ihre eigene Implementation in das System integrieren können. Ebenfalls muss die Erfassung von Bilder und die Destination der Analyse Resultate flexible gestaltet werden können. Beide Aspekte erfordern einen Eingriff in das System. Um diese Vorgänge zu vereinfachen, müssen dieses anhand von Anleitungen und Beispielen unterstütz werden.

== Use Cases 
Durch die grosse Anzahl an verschiedenen Zielgruppen gibt es auch viele verschiedene Szenarien, in dem der Einsatz einer Edge ML Kamera vorstellbar ist.

- Biodiversitätsforschung: Überwachung von Bestäubern, Vögeln, Säugetieren oder Pflanzenwachstum.
- Artenschutz: Identifikation und Überwachung gefährdeter Tier- oder Pflanzenarten.
- Umweltüberwachung: Aufzeichnung und Analyse des Einflusses von Umweltbedingungen wie Temperatur, Feuchtigkeit oder Lichtverhältnissen auf die Pflanzen oder Tierwelt.
- Landwirtschaft: Erkennung von Schädlingen, Optimierung des Pflanzenwachstums.


=== Referenz Szenario
Die Mitwelten Bestäuber Analyse dient während der Entwicklung der Edge ML Kamera als Referenz. Um das System zielgerichtet voranzutreiben, wurden Tests und Evaluationen mittels dieser Analyse bewertet. Dies bietet sich an, weil bereits Machine Learning Modelle bestehen und dementsprechend auch Daten, um die Modelle zu trainieren.


== Anforderungen
#TODO[
    - Funktionale
        - Features (Cam Preview, Inferenz ausführen, Modelwahl, Framework wahl)
        - Hardware
    - Nicht funktionale
        - Inferenz Zeitlimit
        - Einsatzgebiet
    - Citizen Science bezogen
]
Wie in den Kapitel zuvor diskutiert, gibt es eine breite Anwendung für eine Edge ML Kamera. 
Der Referenz Use Case für die Entwicklung des Systems ist die in der Mitwelten Projekt eingesetzte Bestäuber Analyse. Dieser Anwendungsfall dient somit zur Definierung der Anforderungen an das System.



=== Funktionale
Die folgenden funktionalen Anforderungen an eine Edge ML Kamera wurden identifiziert:
- Datenerfassung: Das System muss anhand einer angeschlossenen Kameraeinheit Bilder kontinuierlich erfassen können
- Analyse Resultate: Das System muss die Analysedaten für den jeweiligen Anwendungszweck zur Verfügung stellen
- Benutzerinteraktion: Das System muss vom Benutzer konfiguriert werden können
- Energieversorgung: Während des Betriebs muss eine stabile Energieversorgung vorhanden sein

=== Nicht Funktionale

Die folgenden nicht funktionalen Anforderungen an eine Edge ML Kamera wurden identifiziert:
- Analysedauer: Im Mitwelten Projekt ist definiert, dass die Analyse von Bestäubern in 15 Sekunden erfolgen muss @wullschleger_automated_nodate[p~62]. Die Zeit ist von der Verweildauer von Bestäuber auf einer Blume limitiert.
- Betrieb: Das System muss zuverlässig im Dauerbetrieb funktionieren.
- Kosten: Der Preis für das Gesamtsystem muss so tief sein, dass Citizen Science Projekte realistisch sind
#TODO[wie belegen?]

== Evaluation
Im folgenden werden Resultate der Untersuchungen bezüglich ML Frameworks und Hardware aufgezeigt. Dabei sind Inferenzen mit PyTorch, Tensorflow lite, ONNX, NCNN und Hailo Modellen implementiert worden. Die Inferenzen wurden auf Raspberry Pi's mit und ohne Beschleuniger Hardware ausgeführt und gemessen. Um die Resultate miteinander zu vergleichen und anhand von Grafiken zu untersuchen wurde ein Dashboard entwickelt @noauthor_ip7-ml-model-evaldashboard_nodate. Das Dashboard basiert auf CSV Daten, welche Test Scripts zur Messung von Inferenzzeiten automatisch generieren. Für jedes Framework existiert ein separates Script, welches ein Framework auf einer spezifischer Hardware mit variabler Anzahl Bilder ausführt. Die folgende @dashboard_screenshot zeigt den Start Screen der Applikation.

#figure(
  image("../figures/dashboard_screenshot.png", width: 100%),
  caption: [ML Exploration Dashboard\
    (Quelle: Screenshot eigene Entwicklung, Andri Wild, 2025)
],
)<dashboard_screenshot>

Im Repository @awild_andriwildip7-ml-model-eval_2024 befinden sich nebst dem Dashboard auch die Scripts zur Messung der Inferenzzeiten. Je nach Test muss die entsprechende Hardware an das System angeschlossen sein.

=== Methodik
Bei allen verwendeten Modellen handelt es sich um Yolo Modelle verschiedener Generation und Grösse. Die Modelle zur Bestäuber Analyse aus @referenz_use_case sind ebenfalls Yolo Modelle der Generation 5. Inzwischen sind die Modelle weiter entwickelt worden. Während dieser Arbeit wurde die 11te Generation veröffentlicht. Verglichen wurden die Generationen 5,8 und 10 um festzustellen, wie sich die Metriken über die Generationen verhalten. Die Modelle stammen von Ultralytics @jocher_ultralytics_2023 und haben eine Input Grösse von 640x640 Pixel. 

#TODO[
   - Abkürzungsschlüssel für Legenden
    - YOLO Input size
    - Genauigkeit
]

=== ML Framework 

==== Vergleich Inferenzzeiten
Die folgende Abbildung @comp_fw_yolo zeigt auf, wie sich die Inferenzzeiten der jeweiligen ML Frameworks in Bezug auf die YOLO Generation verhält. Ersichtlich ist, dass hauptsächlich die Inferenzzeit der PyTorch Inferenz mit der neuen Generation signifikant gestiegen ist. Die anderen Frameworks weisen nur geringe Unterschiede auf, wobei die Tendenz des Anstieges bei jeder Kategorie feststellbar ist. Ein weiteres Merkmal ist, dass die Inferenz mit dem ONNX Model bei allen Versuchen am wenigsten Zeit benötigt.

#figure(
  image("../figures/comp_fw_yolo.png", width: 100%),
  caption: [Vergleich: Inferenzzeit YOLOv5, v8 auf Raspberry Pi 5],
)<comp_fw_yolo>

In einem nächsten Schritt wird ONNX mit NCNN verglichen. Wie in @ncnn erwähnt, ist NCNN für Geräte mit begrenzter Rechenleistung optimiert. Dies zeigt sich auch in der folgenden Abbildung @comp_onnx_ncnn. Die Inferenzzeiten halbieren sich nochmals gegenüber der Inferenz mit ONNX.

#figure(
  image("../figures/comp_onnx_ncnn.png", width: 100%),
  caption: [Vergleich: ONNX und NCNN auf Raspberry Pi 5],
)<comp_onnx_ncnn>

Aus diesen Analysen geht hervor, dass mit NCNN auf einer Rasperry Pi 5 CPU die schnellsten Ergebnisse erzielt werden können.
Um nun die Inferenzzeiten weiter zu beschleunigen, wird zusätzliche Hardware benötigt.

=== Hardware
Im folgenden werden verschiedene Hardware Setups miteinander verglichen. Teilweise beansprucht spezifische Hardware auch definierte ML Frameworks. Somit ist der Vergleich von verschiedener Hardware nicht mit gleichen Frameworks möglich. Dennoch können die Inferenzzeiten verglichen werden.

==== Raspberry Pi Vergleiche
Der erste Verglich zeigt den Fortschritt der Raspberry Pi Generationen auf. Die Inferenzzeiten eines ONNX Models ist auf einem Raspberry Pi 5 in grün mehr als doppelt so schnell.

#figure(
  image("../figures/comp_rpi4_rpi5.png", width: 100%),
  caption: [Vergleich: Raspberry Pi 4 vs. Pi 5 \
    (Quelle: Screenshot eigene Entwicklung, Andri Wild, 2025)
]
)<comp_rpi4_rpi5>

Ein weiterer wichtiger Punkt ist die Kühlung des Systems, ansonsten wird die CPU Leistungs des Rechners gedrosselt. In der folgenden @comp_active_cooled_rpi5 ist ersichtlich, dass die Inferenzzeiten mit Kühlung rund 20% Prozent schneller gegenüber der selben Inferenz auf dem Vorgängermodell Raspberry Pi 4.

#figure(
    image("../figures/comp_active_cooled_rpi5.png", width: 100%),
    caption: [
    Vergleich: Raspberry Pi 5 mit und ohne Kühlung \
    (Quelle: Screenshot eigene Entwicklung, Andri Wild, 2025)
     ]
)<comp_active_cooled_rpi5>

==== Coral Accelerator

Das Toolkit Coral @noauthor_products_nodate wurde von Google entwickelt und stellt Beschleuniger verschiedener Art zur Verfügung. Im Kontext dieser Arbeit wurden zwei dieser Beschleuniger untersucht: Ein USB Dongle mit einer Edge TPU von 4 TOPS und ein über PCI verbundenes Board mit einer TPU mit 8 TOPS.
Bei den Versuchen hat sich herausgestellt, dass der USB Dongle unzuverlässig ist. Es kam während länger laufenden Tests wiederholt zu Verbindungs unterbrüchen. Die Edge TPU über PCI funktionierte zuverlässig.

#figure(
  image("../figures/comp_edge_tpu_rpi5.png", width: 100%),
  caption: [Vergleich: Raspberry Pi 5 vs. Coral PCI Edge TPU],
)<comp_edge_tpu_rpi5>

Es ist sofort ersichtlich, dass die Inferenz auf der Edge TPU um ein vielfaches schneller ist als auf der CPU mit NCNN des Raspberry Pi 5. Allerdings muss hier erwähnt werden, dass ein die EdgeTPU nur quanzisierte TensorFlow lite Modelle ausführen kann und somit besteht auch ein Verlust der Präzision.
#TODO[Präzision mAp]

==== Hailo
In dieser Untersuchung wurden die beiden Modelle Hailo8l (13 TOPS) und Hailo8 (26 TOPS) eingesetzt. Die beiden Module werden jeweils über die PCI Schnittstelle mit dem Raspberry Pi 5 verbunden. Aufgrund der benötigten PCI Schnittstelle kann das Raspberry Pi 4 Modell nicht verwendet werden.
Für die Messungen der Inferenzzeit ist das von Hailo zur Vergügung gesetllte ML-Framework verwendet worden. Zudem müssen die Modelle im Hailo eigenen Format .hef sein, um sie auf den Accelerator auszuführen. Hailo stellt ein Model Zoo @tapuhi_hailo_2021 zur Verfügung, welcher die Modelle YOLOv5s und YOLOv5m beinhaltet.
Die folgende @comp_hailo_edge_tpu zeigt den Vergleich mit der Coral Edge TPU.

#figure(
  image("../figures/comp_hailo_edge_tpu.png", width: 100%),
  caption: [Vergleich Hailo Accelerator vs. Coral PCI Edge TPU\
    (Quelle: Screenshot eigene Entwicklung, Andri Wild, 2025)
],
)<comp_hailo_edge_tpu>

Die beiden Hailo Accelerator sind signifikant schneller als der schon etwas ältere Coral Accelerator.
Ebenso ist ersichtlich, dass sich die doppelte Anzahl TOPS direkt auf die Inferenz Geschwindigkeit auswirkt. 
Die schnellste Inferenz wird somit mit dem Hailo8 Accelerator erzielt und beträgt run 15ms.

== Edge ML Setups
#TODO[
    - billig Setup
    - Performance Setup
    - AI-Camera Setup
    - Chart mit Trade Off
]
Aus der Selektion der Hardware und den in diesem Kapitel aufgeführten Evaluationen von Inferenzen lassen sich nun verschiedene Konstellationen mit unterschiedlichen Stärken, resp. Schwächen definieren. Die @comp_cost_speed zeigt das Verhältnis von Kosten zu Inferenzgeschwindigkeit der vielversprechendsten Kombinationen mit dem YOLOv8n Model.

#figure(
  image("../figures/cost_speed_tradeoff.png", width: 100%),
  caption: [Vergleich: Kosten vs. Geschwindigkeit mit YOLOv8n\
    (Quelle: Screenshot eigene Entwicklung, Andri Wild, 2025)
],
)<comp_cost_speed>


#TODO[Paper referenzieren]

Weil das Raspberry 4 kaum billiger ist als sein Nachfolger Pi 5 ist das Model 4 für diese Bewertung auszuschliessen.
Die mit Abstand am Kostengünstigsten Varianten sind jene ohne zusätzliche Beschleuniger-Hardware. Dabei schneidet das NCNN Framework auf dem Raspberry Pi 5 mit ca 9.6 FPS am besten ab gefolgt von ONNX mit rund 5.2 FPS.

Bei den Setups mit Beschleuniger sehen wir, dass mit höheren Ausgaben entsprechend mehr FPS zu erzielen sind. Die schnellsten Inferenzen liefert der teuerste Beschleuniger Hailo8 mit 26 TOPS von Hailo. Der kleinere Hailo Beschleuniger befindet sich auf Stufe der AI-Camera von Raspberry Pi. Etwas abgeschlagen, dafür auch Kostengünstiger ist der M.2 PCI Edge TPU von Coral.

Um auf dem Raspberry Pi die beste Performance zu erzielen, empfiehlt sich ein Chip von Hailo. Eine Edge TPU von Google ist aufgrund des abnehmenden Supports und der weniger ausführlichen Dokumentation nicht empfehlenswert.

Lässt es die Applikation zu, ist auch die AI-Kamera von Raspberry Pi eine gute Wahl. Dabei muss berücksichtigt werden, dass in Systemen mit mehr als einer Inferenz nur die erste auf der Kamera durchgeführt werden kann. Darauffolgende Inferenzen müssten auf der CPU oder auf einem weiteren Beschleuniger ausgeführt werden. Ein Setup mit einem weiteren Beschleuniger würde natürlich auch die Kosten erhöhen.


