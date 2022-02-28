class_name LocalState

var money : int
var respect : int
var popularity : int

func state_merge(other_state: LocalState) -> LocalState:
    money += other_state
    respect = (respect + other_state.respect) / 2
    popularity = popularity > other_state.popularity ? popularity : other_state.popularity 