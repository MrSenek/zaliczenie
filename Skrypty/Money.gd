extends Node

signal coin_collected(new_amount) # Tworzymy sygnał

var coins = 0

func add_coin():
	coins += 1
	coin_collected.emit(coins) # Wysyłamy informację w świat: "Ktoś zebrał monetę!"
