echo " ### multimedia-scripts.sh"

#multimedia convertions
function fzl-convert-video-gif-anim(){
    mkdir -p pngs
    gst-launch-1.0 filesrc location="input.webm" ! decodebin ! videoconvert ! pngenc ! multifilesink location="pngs/%04d.png"
    convert -delay 10 -loop 0 pngs/*.png output.gif
}
export -f fzl-convert-video-gif-anim


function fzl-convert-video-mp4(){
    input_file="$1"
    output_file="${input_file%.*}_converted.mp4"
    ffmpeg -i "$input_file" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 192k "$output_file"
}
export -f fzl-convert-video-mp4

#function to reduce audio noise of a mp4 video file
function fzl-audio-noise-reduce--of-mp4(){
    input_file="$1"
    output_file="${input_file%.*}_noise_reduced.mp4"
    ffmpeg -i "$input_file" -c:v copy -af "arnndn=m=rnnoise-models/rnnoise-model-2018-08-28.pb" "$output_file"
}
export -f fzl-audio-noise-reduce--of-mp4

function fzl-convert-audio--of-mp3(){
    input_file="$1"
    output_file="${input_file%.*}.mp3"
    ffmpeg -i "$input_file" -vn -ar 44100 -ac 2 -b:a 192k "$output_file"
}
export -f fzl-convert-audio--of-mp3

#function fzl-audio-noise-reduce(){    
##    input_file="$1"
#    output_file="${input_file%.*}_noise_reduced.mp4"
#    ffmpeg -i "$input_file" -c:v copy -af "arnndn=m=rnnoise-models/rnnoise-model-2018-08-28.pb" "$output_file"
#}
#export -f fzl-audio-noise-reduce


