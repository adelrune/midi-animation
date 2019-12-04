from mido import MidiFile, frozen
from pprint import pprint
import json

absolute_ts = 0
chans = {}
ms = [m for m in MidiFile("1m.mid")]
mintime = min(filter(None,[m.time for m in ms]))
times = {m.time for m in ms}
for m in ms:
    if m.time < 0.00625 and m.time > 0:
        print(m)
ms = []
chan_note_stacks = {}
frames = {}
parts = {0:"picc", 1:"flute", 2: "guit", 3:"bass",4:"drum", 8:"bass", 9:"drum"}
def to_dict(msg):
    return {"chan":msg.channel, "part":parts[msg.channel],"note":msg.note,"dur":round(msg.duration/(1/16)), "vel":msg.velocity}

for message in MidiFile("1m.mid"):
    absolute_ts += message.time
    object.__setattr__(message, "abs_time", absolute_ts)
    try:
        chans.setdefault(message.channel, []).append(message)
    except:
        chans.setdefault("nochan", []).append(message)

    if message.type == "note_on":
        if message.velocity !=0:
            chan_note_stacks.setdefault(message.channel, {}).setdefault(message.note, []).append(message)
        else:
            note_on_msg = chan_note_stacks[message.channel][message.note].pop()
            object.__setattr__(note_on_msg, "duration", message.abs_time - note_on_msg.abs_time)
            frames.setdefault(round(note_on_msg.abs_time/(1/16)), []).append(to_dict(note_on_msg))
    ms.append(message)

print(chan_note_stacks)
noteons = list(filter(lambda x : x.type == "note_on" and x.velocity > 0 ,ms))
durs = {n.duration for n in noteons}
with open("frames.json", "w") as f:
    json.dump(frames, f, indent=4, sort_keys=True)
