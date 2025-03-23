extends Node

enum dirctn {  ZERO, NORDEN,  SUEDEN,  OSTEN,  WESTEN }
var start_dirctn = dirctn.ZERO



# Schritt 3: Konfiguriere das Skript als Autoload Singleton.
# 
# Gehe in der Godot-Editor zu Projekt -> Projekteinstellungen.
# Klicke im linken Menü auf den Reiter Autoload.
# Klicke auf das "+"-Symbol unter der Liste "Pfad".
# Wähle im Dateidialog das Skript aus, das du gerade erstellt hast (GlobalEnums.gd).
# Im Feld Name (rechts neben dem Pfad) kannst du einen globalen Namen für dieses Singleton festlegen. Dies ist der Name, den du verwenden wirst, um von 
# anderen Skripten aus auf das enum zuzugreifen. Ein üblicher Name ist der gleiche wie der Dateiname ohne die Endung, also in diesem Fall GlobalEnums. Godot 
# schlägt dies normalerweise automatisch vor. Stelle sicher, dass das Kästchen Aktiviert angehakt ist.
# 
# Schritt 4: Verwende das enum in deinen anderen Skripten.
# Nachdem du GlobalEnums.gd als Autoload konfiguriert hast, kannst du in jedem anderen Skript in deinem Projekt auf die darin definierten enum-Werte zugreifen, 
# indem du den Namen des Autoload Singletons verwendest, gefolgt von einem Punkt und dann dem Namen des enum und dem gewünschten Wert.
# 
# Beispiel:
# 
# Angenommen, du hast ein Skript an deinem Spieler-Node angehängt:
# GDScript
# 
# # SpielerSkript.gd
# extends KinematicBody2D
# 
# var current_state = GlobalEnums.PlayerState.IDLE
