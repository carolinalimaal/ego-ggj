extends Control

@onready var mask_1_panel: ColorRect = $HBoxContainer/ColorPanel1
@onready var mask_2_panel: ColorRect = $HBoxContainer/ColorPanel2

func _ready() -> void:
	GameManager.connect("player_ready", onPlayerReady)
	

func onPlayerReady(player: Player):
	player.connect("create_mask_1_ui", maskOneUiVisible)
	player.connect("create_mask_2_ui", maskTwoUiVisible)
	player.connect("update_color_ui", updatePanelsColors)

func maskOneUiVisible() -> void:
	mask_1_panel.visible = true
	
func maskTwoUiVisible() -> void:
	mask_2_panel.visible = true

func updatePanelsColors() -> void:
	updatePanelOneColor()
	updatePanelTwoColor()
	
func updatePanelOneColor() -> void:
	if GameManager.player_ref.current_mask == GameManager.player_ref.Mascaras.CAMALEON:
		mask_1_panel.color = Color("3d9de287")
	else:
		mask_1_panel.color = Color("95959587")

func updatePanelTwoColor() -> void:
	if GameManager.player_ref.current_mask == GameManager.player_ref.Mascaras.BAT:
		mask_2_panel.color = Color("3d9de287")
	else:
		mask_2_panel.color = Color("95959587")
