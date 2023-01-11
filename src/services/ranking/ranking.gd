extends Node


signal retrieved(rankings)
signal saved
signal failed

export(String) var url


func get_rankings() -> int:
	var error: int = $GetRankingsRequest.request(url)
	
	if error != OK:
		return -1
	
	return 0


func save_ranking(ranking: Dictionary) -> int:
	var data = JSON.print(ranking)
	var headers = ["Content-Type: application/json"] # Add 'Content-Type' header:
	var error: int = $SaveRankingRequest.request(url, headers, false, HTTPClient.METHOD_POST, data)
	
	if error != OK:
		return -1
	
	return 0


func _on_GetRankingsRequest_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		emit_signal("failed")
		return
	
	var response := JSON.parse(body.get_string_from_utf8())
	
	if response.error != OK or typeof(response.result) != TYPE_ARRAY:
		emit_signal("failed")
		return
		
	var rankings := []
	
	for entry in response.result:
		rankings.append({
			"name": entry[0],
			"score": entry[1],
		})
	
	emit_signal("retrieved", rankings)


func _on_SaveRankingRequest_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		emit_signal("failed")
		return
	
	emit_signal("saved")
