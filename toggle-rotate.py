import subprocess

screen = "DP-1"
rotate = "left"

output = subprocess.check_output(["xrandr"]).decode("utf-8").splitlines()
matchline = [l.split() for l in output if l.startswith(screen)][0]
s = matchline[matchline.index([s for s in matchline if s.count("+") == 2][0]) + 1]

if s == rotate:
    rotate = "normal"

subprocess.call(["xrandr", "--output", screen, "--rotate", rotate])

