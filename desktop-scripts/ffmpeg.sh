
#You can extract frames from a video and save them as an animated GIF:
function fzl-ffmpeg-convert-video-to-gif(){
    ffmpeg -i $1 -vf "fps=15,scale=640:-1:flags=lanczos" -c:v gif $2
}
export -f fzl-ffmpeg-convert-video-to-gif

function fzl-ffmpeg-convert-video-to-gif-optimized(){
    ffmpeg -i $1 -vf "fps=15,scale=640:-1:flags=lanczos" -c:v gif -b:v 2M $2
}
export -f fzl-ffmpeg-convert-video-to-gif-optimized


#You can overlay text on the frames of your GIF:
function fzl-ffmpeg-convert-video-to-gif-with-text(){
    text=$1
    output_file=$2
    ffmpeg -i $text -vf "fps=15,scale=640:-1,drawtext=text='Hello World':x=10:y=10:fontsize=24:fontcolor=white" -c:v gif $output_file
}
export -f fzl-ffmpeg-convert-video-to-gif-with-text
