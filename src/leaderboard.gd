extends Control


var endpoint = "https://script.google.com/macros/s/AKfycbyYFhBH1bXsdziPnQcFTLYnjFbfTdnRpsFW1EItHA5l6hqU4BLVIJXVd2ETg6IGEsljJg/exec"

func _ready():
	$GetScoreRequest.request(endpoint)


func _on_Button_pressed():
	var name = $HBoxContainer/TextEdit.text
	var data = {
		'name': name,
		'score': 0
	}
	
	_make_post_request(endpoint, data, false)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	
	var scores = $ScoresList.get_children()
	for score in scores:
		score.queue_free()
	
	if not json.result:
		# no result
		return
	
	for result in json.result:
		var label = Label.new()
		label.text = result[0] + " " + str(result[1])
		$ScoresList.add_child(label)


func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$SaveScoreRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)


func _on_GetScoreRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	
	if not json.result:
		return
	
	_update_scoreboard(json.result)


func _on_SaveScoreRequest_request_completed(result, response_code, headers, body):
	$GetScoreRequest.request(endpoint)


func _update_scoreboard(scores) -> void:
	var labels = $ScoresList.get_children()
	for label in labels:
		label.queue_free()
	
	for score in scores:
		var label = Label.new()
		label.text = score[0] + " " + str(score[1])
		$ScoresList.add_child(label)
