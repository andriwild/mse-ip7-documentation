#import "/utils/todo.typ": TODO

#pagebreak()

= Validierung

Der in @prototyp_1 vorgestellte Prototyp zeigt, dass die Mitwelten-Bestäuber-Analyse auch auf einem Edge-Device realisierbar ist. Eine solche Umsetzung war mit Hardware im gleichen Preissegment bislang noch nicht möglich.

Die Entwicklung einer Applikation für unterschiedliche Einsatzbereiche hat deutlich gemacht, dass sich im Bereich der Edge-AI-Hardware und Software einiges bewegt. Dank der Weiterentwicklung spezialisierter Machine-Learning-Hardware können immer mehr Anwendungen direkt an der Edge realisiert werden, sodass die Leistungsfähigkeit moderner Edge-Computer zunehmend weniger als limitierender Faktor wirkt.

== Versuchsaufbau und Temperaturentwicklung

Besonders hervorzuheben ist der Einsatz von Beschleunigern, wie etwa den Komponenten von Hailo, die nicht nur für schnellere Inferenzzeiten sorgen, sondern auch die Wärmeentwicklung signifikant reduzieren. Die @versuchsaufbau_temp zeigt ein einfacher Versuchsaufbau um die Temperatur Entwickelung in einem Gehäuse zu untersuchen. Während das Gehäuse bei Einsatz der Hailo-Inferenz konstant auf einem niedrigen Temperaturniveau bleibt, führt die CPU-Inferenz zu einem rapiden Temperaturanstieg. 

#figure(
  image("../figures/versuchsaufbau_temp.jpg", width: 40%),
    caption: [Versuchsaufbau Temperatur Messung\
    (Quelle: Eigene Aufnahme, Andri Wild, 2025)
]
)<versuchsaufbau_temp>

Mit der CPU betriebenen Inferenz erhöhte sich die Temperatur im geschlossenen Gehäuse innerhalb einer Stunde auf 40 Grad, steigend. Die CPU Temperatur lag bei ca. 85 Grad, womit die Drosselung aktiviert wird und die Rechenleistung sinkt.

Die optimierte Energieeffizienz der Beschleuniger hat positive Auswirkungen auf das Gehäusedesign – insbesondere bei Anwendungen wie Biodiversitätsanalysen, bei denen das Gerät oft im Freien und in wasserdichten Gehäusen eingesetzt wird. Der Wegfall von aktiver Belüftung eröffnet hier wesentliche Konstruktionsvorteile.


Ein Punkt beim Umgang mit den Hailo Beschleuniger, wecher nochmals untersucht werden muss ist die Stabilität in betrieb. Während länger laufenden Betriebstest kam es mehrfach zu Segmentation faults. Dieser Umstand ist zum Zeitpunkt dieser Arbeit noch nicht geklärt und bedarf an weiteren Untersuchungen.

== Konkurrenz Produkte
Die Möglichkeit, Analysen direkt auf einem Edge-Device auszuführen, ist eine vielversprechende Anwendung, was durch die Verfügbarkeit von Produkten auf dem Markt bestätigt wird. Zwei besonders interessante Geräte sind die reCamera @noauthor_recamera_nodate und die EcoEye-Kamera @noauthor_ecoeye_nodate, die beide über SeeedStudio erhältlich sind.

Die reCamera lässt sich mithilfe von Node-Red konfigurieren, wodurch die Konfiguration von Applikationen ohne Programmierkenntnisse möglich ist. Dies bietet insbesondere für Projekte ohne informatikaffine Mitarbeitende oder für Citizen-Science-Anwendungen einen erheblichen Vorteil. Die Kamera ist äusserst kompakt, jedoch nicht wasserdicht und erfordert daher einen zusätzlichen Schutz für den Ausseneinsatz.

Die EcoEye-Kamera wurde speziell für den Ausseneinsatz entwickelt und verfügt über einen grossen Akku, der den Betrieb in Gebieten ohne externe Stromversorgung ermöglicht. Ihre Bauweise ähnelt der einer herkömmlichen Wildkamera, bietet jedoch zusätzliche Rechenleistung, um Analysen direkt auf dem Gerät durchzuführen. Dadurch können Daten bereits vor Ort verarbeitet werden, was den Bedarf an externer Infrastruktur reduziert.

#pagebreak()
= Fazit

#TODO[Ausblick, was kann man besser machen: Gehäuse, Tests, User Tests]
Die Infererenz Zeiten beschleunigt mithilfe von Hailo Komponenten sind für die Bestäuber Analyse kürzer als Verlangt. Daher 
Abschliessend lässt sich sagen, dass die entwickelte Edge ML Kamera grosses Potenzial für Citizen Science-Projekte bietet, da sie den Zugang zu modernen Machine-Learning-Methoden auch ausserhalb zentraler Infrastrukturen ermöglicht. In dieser Arbeit wurde gezeigt, wie der gezielte Einsatz optimierter ML-Frameworks und spezialisierter Hardware – etwa moderner Hailo-Beschleuniger, NCNN-optimierter Modelle und des Raspberry Pi 5 – zu deutlich schnelleren Inferenzzeiten und einem geringeren Energieverbrauch führt.

Dank dieser schnellen Inferenzzeiten können zudem grössere und präzisere Modelle trainiert werden, die trotzdem die Zeitvorgaben erfüllen. Ausserdem legt die Analyse nahe, dass es prinzipiell möglich wäre, mehr als einen Kamerastream gleichzeitig auf einem einzigen Gerät auszuwerten. Dies wäre besonders in abgelegenen oder ressourcenbegrenzten Umgebungen von Vorteil, da so mehrere Datenquellen parallel verarbeitet werden könnten.
