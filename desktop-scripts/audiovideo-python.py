import sys
import subprocess

def reduce_noise(video_path):
    output_path = "reduced_noise_" + video_path
    command = [
        "ffmpeg",
        "-i", video_path,
        "-af", "afftdn",
        output_path
    ]
    subprocess.run(command)
    print(f"Noise reduced video saved as {output_path}")

def increase_volume(video_path):
    output_path = "increased_volume_" + video_path
    command = [
        "ffmpeg",
        "-i", video_path,
        "-af", "volume=2.0",
        output_path
    ]
    subprocess.run(command)
    print(f"Volume increased video saved as {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python audiovideo-python.py <reduce_noise|increase_volume> <video_path>")
        sys.exit(1)

    action = sys.argv[1]
    video_path = sys.argv[2]

    if action == "reduce_noise":
        reduce_noise(video_path)
    elif action == "increase_volume":
        increase_volume(video_path)
    else:
        print("Invalid action. Use 'reduce_noise' or 'increase_volume'.")
        sys.exit(1)
        