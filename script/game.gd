extends Control

var diary=0
var page=1

func _ready():
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(0.6).timeout
	$AudioStreamPlayer.play()

func _process(delta):
	if diary==0:
		$diary.visible=false
	if diary==1:
		$diary.visible= true
	if page==1:
		$diary/name.text="THE SQUIRE"
		$diary/AnimatedSprite2D.play("squire")
		$diary/description.visible=true
		$diary/description.text= "We used to be a team\nA strong soldier\nA powerfull mage\nA devout priest\nAnd I, a little squire,\nwho everyone treats\nlike a jester\ni'll take all their power\nanyone will never \nlaugh at me again\nthey will be the joke,\nif them survive"
	if page==2:
		$diary/name.text="THE MAGE"
		$diary/AnimatedSprite2D.play("mage")
		$diary/description.visible=false
		if GlobalVars.progress >3:
			$diary/description.visible=true
			$diary/description.text= "She was always greedy\nbut it's unexpected\ntransform your body\nin pure magic\nit's a shame\nshe was so young\nshe was so beautiful\nshe was so so clever\n...\n\nbut I don't regret \nletting her die\n"

	if page==3:
		$diary/name.text="THE PRIEST"
		$diary/AnimatedSprite2D.play("priest")
		$diary/description.visible=false
		if GlobalVars.progress >6:
			$diary/description.visible=true
			$diary/description.text= "I was not that religious\nbut he talked so much\nabout this new religion\nfull of followers\nI listened his words\nand now every sunday\ni go to church\nI thankfull for that\n...\n\nbut I don't regret \nletting him die\n"
	if page==4:
		$diary/name.text="THE SOLDIER"
		$diary/AnimatedSprite2D.play("soldier")
		$diary/description.visible=false
		if GlobalVars.progress >9:
			$diary/description.visible=true
			$diary/description.text= "He was my master\nHe want me in his team\nand I,poor commoner\nwith only a horse,\njust want to survive\na hope,for a better life\naccept everything\nuntil that day \nTHEY ABANDONED ME,\nAFTER ALL THIS TIME\nWE LIVE TOGETHER\nJUST BECAUSE HE WANT\nI DON'T REGRET\nKILLING HIM"
		
			

func _on_button_pressed():
	$AudioStreamPlayer3.play()
	$AnimationPlayer.play("FADE_OUT")
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://scenes/map.tscn")


func _on_button_2_pressed():
	$AudioStreamPlayer3.play()
	get_tree().quit()


func _on_button_3_pressed():
	$AudioStreamPlayer3.play()
	diary =1


func _on_next_page_pressed():
	if page ==4:
		$AudioStreamPlayer2.play()
		diary=0
		page=1
	else:
		$AudioStreamPlayer2.play()
		page +=1
		

func _on_exit_pressed():
	$AudioStreamPlayer3.play()
	diary=0
	page=1
