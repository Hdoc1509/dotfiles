frames_total() { ffprobe -v warning -show_frames "$1" | grep -c '\[/FRAME\]'; }

__video_streams() { ffprobe -v quiet -print_format json -show_streams "$1"; }

aspect_ratio() {
  __video_streams "$1" |
    jq '.streams[0] | (.width|tostring) + "x" + (.height|tostring)'
}

video_height() { __video_streams "$1" | jq '.streams[0] | .height'; }
video_width() { __video_streams "$1" | jq '.streams[0] | .width'; }
