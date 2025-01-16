#import "/utils/todo.typ": TODO

= Analyse
#TODO[
    (Was braucht es für mich)
]
Dieses Kapitel befasst sich mit der Analyse und Bewertung der Möglichkeiten für die Umsetzung einer Edge ML Kamera. Zu diesem Zweck wurden anhand von Experimenten verschiedene Messungen durchgeführt. Für die Analyse dieser Experimente ist ein Dashboard @awild_andriwildip7-ml-model-eval_2024 entwickelt worden, um interaktiv verschiedene Komponenten miteinander zu verglichen. Die folgende @dashboard_screenshot zeigt ein Screenshot der Applikation.

#figure(
  image("../figures/dashboard_screenshot.png", width: 100%),
  caption: [ML Exploration Dashboard],
)<dashboard_screenshot>

== Zielgruppe
#TODO[
    - Was müssen Bediener können
]
Ein Kamera System, welches flexibel für verschiedene Zwecke einsetzbar ist, kann interessant sein für eine vielzahl an Anwendungszwecken und deckt daher auch eine breite Zielgruppe ab:
- Forschende: Wissenschaftlerinnen und Wissenschaftler aus den Bereichen Biodiversität, Ökologie oder Umweltwissenschaften.
- Citizen Scientists: Ehrenamtliche, die sich an wissenschaftlichen Projekten beteiligen.
- Naturschutzorganisationen: Institutionen, die Artenschutz- oder Umweltprojekte durchführen.
- Bildungseinrichtungen: Schulen, Universitäten und andere Lernstätten für Lehrzwecke und studentische Forschungsprojekte.
- Landwirtschaftliche Betriebe: Landwirte, die ihr Wissen über Bestäuber und Schädlingsbekämpfung erweitern möchten.
- Regierungs- und Umweltbehörden: Organisationen, die Umweltschutzmaßnahmen überwachen oder Berichte erstellen.
- Technologie- und Umweltenthusiasten: Personen mit Interesse an IoT und nachhaltiger Technologie.

== Use Cases 
Durch die grosse Anzahl an verschiedenen Zielgruppen gibt es auch viele verschiende Scenarien, in dem der Einsatz einer Edge ML Kamera vorstellbar ist.

- Biodiversitätsforschung: Überwachung von Bestäubern, Vögeln, Säugetieren oder Pflanzenwachstum.
- Artenschutz: Identifikation und Überwachung gefährdeter Tier- oder Pflanzenarten.
- Umweltüberwachung: Aufzeichnung und Analyse des Einflusses von Umweltbedingungen wie Temperatur, Feuchtigkeit oder Lichtverhältnissen auf die Pflanzen oder Tierwelt.
- Landwirtschaft: Erkennung von Schädlingen, Optimierung des Pflanzenwachstums.
- Bildungsprojekte: Praktische Anwendungen für Schüler und Studierende in Naturwissenschaften und Technik, als Ausbildungs Objekt für eine Machine Learning Applikation.
- Citizen Science: Ermöglicht Gemeinschaften, eigene wissenschaftliche Projekte durchzuführen, z. B. zur lokalen Artenvielfalt oder sich grösseren Projekten anzuschliessen.
#TODO[
    - Was sollen Personen fähig sein zu machen
]    


=== Referenz Use Case <referent_use_case>
Um bei der Entwicklung der Edge ML Kamera zielgerichtet arbeiten zu können, ist die Mitwelten Bestäuber Analyse das zu erfüllende Scenario. Durch die grosse Anzahl an verfügbaren und teilweise bereits gelabelten Bilder ist der Weg ein neues Modell zu trainieren geebnet. Die Bestäuber Detektion erfolgt in folgenden wesentlichen Schritten. Ein Foto von Blüten durchläuft in einem ersten Schritt eine Inferenz zur Detektion von Blüten. Die auf dem Bild detektierten Blüten werden anschliessen ausgeschnitten und somit zu kleineren Fotos. Jedes dieser Fotos wird anschliessend mit einer weiteren Inferenz und einem anderen Machine Learning Modell auf Bestäuber untersucht. Eine grosse Herausforderung in diesem Setup ist, dass die Anzahl Bestäuber-Inferenzen mit der Anzahl detektierten Blüten steigt. Dies kann bei grossen Blütenzahlen zu langen Analysen eines einzigen Bildes führen. 

#figure(
  image("../figures/mw_pipeline.png", width: 100%),
  caption: [Mitwelten Machine Learning Pipeline],
)

== Anforderungen
#TODO[
    - Funktionale
        - Features (Cam Preview, Inferenz ausführen, Modelwahl, Framework wahl)
        - Hardware
    - Nicht funktionale
        - Inferenz Zeitlimit
        - Einsatzgebiet
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
Analysedauer: Im Mitwelten Projekt ist definiert, dass die Analyse von Bestäubern in 15 Sekunden erfolgen muss @wullschleger_automated_nodate[p~62]. Die Zeit ist von der Verweildauer von Bestäuber auf einer Blume limitiert.

== Evaluation
Im folgenden werden Resultate der Untersuchungen bezüglich ML Frameworks und Hardware aufgezeigt. Dabei sind Inferenzen mit PyTorch, Tensorflow lite, ONNX und Hailo Modellen implementiert worden. Die Inferenzen wurden auf Raspberry Pi's mit und ohne Beschleuniger Hardware ausgeführt und gemessen.

=== Methodik
Bei den Verwendeten Modellen handelt es sich um die YOLOv5, v8 und v10 Modellreihen in verschiedenen Grössen. Die Grösse des Modells bestimmt die Anzahl der trainierten Gewichte eines Modells. In diesen Versuchen werden die kleineren Modelle verwendet, weil diese grundsätzlich schneller sind. Der Preis für weniger Gewichte und somit schnelleren Inferenzen ist die geringere Genauigkeit. 

Die YOLO Modelle wurden gewählt, weil sie zum Zeitpunkt dieser Arbeit gute Ergebnisse in den Bildanalysen liefern und breit eingesetzt werden. Zudem ist die Pipeline des Referenz Use Case @referent_use_case mit Modellen der YOLO Generation 5 umgesetzt. Die Messungen wurden jeweils auf den von Ultralytics vor trainierten YOLO Modellen mit Bildern des COCO Standard Datenset durchgeführt.

=== ML Framework 
#TODO[
    - Unterschiede
    - Vor und Nachteile
    - Auswertung
]
Im folgenden werden die Inferenzzeiten gleicher Modelle mit unterschiedlichen ML Frameworks verglichen. Dies auf einem Raspberry Pi 5 8GB mit einem aktiven Kühlelement.

==== Vergleich Inferenzzeiten
Die folgende Abbildung @comp_fw_yolo zeigt auf, wie sich die Inferenzzeiten der jeweiligen ML Frameworks in Bezug auf die YOLO Generation verhält. Ersichtlich ist, dass hauptsächlich die Inferenzzeit der PyTorch Inferenz mit jeder Generation signifikant gestiegen ist. Die anderen Frameworks weisen nur geringe Unterschiede auf, wobei die Tendenz des Anstieges bei jeder Inferenzzeit feststellbar ist. Ein weiteres Merkmal ist, dass die Inferenz mit dem ONNX Model bei allen Versuchen am wenigsten Zeit benötigt.

#figure(
  image("../figures/comp_fw_yolo.png", width: 100%),
  caption: [Vergleich Inferenzzeit YOLOv5, v8 auf Raspberry Pi 5],
)<comp_fw_yolo>

In einem nächsten Schritt wird ONNX mit NCNN verglichen. Wie in @ncnn erwähnt, ist NCNN für Geräte mit begrenzter Rechenleistung optimiert. Dies zeigt sich auch in der folgenden Abbildung @comp_onnx_ncnn. Die Inferenzzeiten halbieren sich nochmals gegenüber der Inferenz mit ONNX.

#figure(
  image("../figures/comp_onnx_ncnn.png", width: 100%),
  caption: [Vergleich ONNX und NCNN auf Raspberry Pi 5],
)<comp_onnx_ncnn>

Aus diesen Analysen geht hervor, dass mit NCNN auf einer Rasperry Pi 5 CPU die schnellsten Ergebnisse erzielt werden können.
Um nun die Inferenzzeiten weiter zu beschleunigen, wird zusätzliche Hardware benötigt.

=== Hardware
#TODO[
    - Recherche Hardware
        - Beschleuniger (TPU, AI-Camera)
        - Kamera (Rasperry Pi Cam, Webcam)
        - Edge Computer (Raspberry Pi 4,5)
]
Im folgenden werden verschiedene Hardware Setups miteinander verglichen. Teilweise beansprucht spezifische Hardware auch definierte ML Frameworks. Somit ist der Vergleich von verschiedener Hardware nicht mit gleichen Frameworks möglich. Dennoch können die Inferenzzeiten verglichen werden.

==== Raspberry Pi Vergleiche
Der erste Verglich zeigt den Fortschritt der Raspberry Pi Generationen auf. Die Inferenzzeiten eines ONNX Models ist auf einem Raspberry Pi 5 mehr als doppelt so schnell.

#figure(
  image("../figures/comp_rpi4_rpi5.png", width: 100%),
  caption: [Vergleich Raspberry Pi 4 vs. Pi 5],
)<comp_rpi4_rpi5>

Ein weiterer wichtiger Punkt ist die Kühlung des Systems. Ansonsten wird die CPU Leistungs des Rechners gedrosselt. In der folgenden @comp_active_cooled_rpi5 ist ersichtlich, dass die Inferenzzeiten mit Kühlung rund 20% Prozent schneller gegenüber der selben Inferenz auf dem Vorgängermodell Raspberry Pi 4.

#figure(
  image("../figures/comp_active_cooled_rpi5.png", width: 100%),
  caption: [Vergleich Raspberry Pi 5 mit und ohne Kühlung],
)<comp_active_cooled_rpi5>

==== Coral Accelerator

Das Toolkit Coral @noauthor_products_nodate wurde von Google entwickelt und stellt Beschleuniger verschiedener Art zur Verfügung. Im Konstext dieser Arbeit wurden zwei dieser Beschleuniger untersucht: Ein USB Dongle mit einer Edge TPU von 4 TOPS und eine ein über PCI verbundenes Board mit einer TPU von 8 TOPS.
Bei den Versuchen hat sich herausgestellt, dass der USB Dongle unzuverlässig ist. Es kam während länger laufenden Tests wiederholt zu Verbindungs unterbrüchen. Die Edge TPU über PCI funktionierte zuverlässig.

#figure(
  image("../figures/comp_edge_tpu_rpi5.png", width: 100%),
  caption: [Vergleich Raspberry Pi 5 vs. Coral PCI Edge TPU],
)<comp_edge_tpu_rpi5>

Es ist sofort ersichtlich, dass die Inferenz auf der Edge TPU um ein vielfaches schneller ist als auf der CPU des Raspberry Pi 5.

==== Hailo

Hailo @noauthor_ki-edge-prozessoren_nodate ist ein Unternehmen, welches auf Hochleistungs KI-Edge-Prozessoren spezialisiert hat. In dieser Untersuchung wurden die beiden Modelle Hailo8l (13 TOPS) und Hailo8 (26 TOPS) eingesetzt. Die beiden Module werden jeweils über die PCI Schnittstelle mit dem Raspberry Pi 5 verbunden. Aufgrund der benötigten PCI Schnittstelle kann das Raspberry Pi 4 Modell nicht verwendet werden.
Für die Messungen der Inferenzzeit ist das von Hailo zur Vergügung gesetllte ML-Framework verwendet worden. Zudem müssen die Modelle im Hailo eigenen Format .hef sein, um sie auf den Accelerator auszuführen. Hailo stellt ein Model Zoo @tapuhi_hailo_2021 zur Verfügung, welcher die Modelle YOLOv5s und YOLOv5m beinhaltet.
Die folgende @comp_hailo_edge_tpu zeigt den Vergleich mit der Coral Edge TPU.

#figure(
  image("../figures/comp_hailo_edge_tpu.png", width: 100%),
  caption: [Vergleich Hailo Accelerator vs. Coral PCI Edge TPU],
)<comp_hailo_edge_tpu>

Die beiden Hailo Accelerator sind signifikant schneller als der schon etwas ältere Coral Accelerator.
Ebenso ist ersichtlich, dass sich die doppelte Anzahl TOPS direkt auf die Inferenz Geschwindigkeit auswirkt. 
Die schnellste Inferenz wird somit mit dem Hailo8 Accelerator erzielt und beträgt run 15ms.
