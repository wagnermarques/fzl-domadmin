from PIL import Image, ImageDraw

# Create a 32x32 transparent image
img = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Draw a simple blue circle in the center
draw.ellipse((6, 6, 26, 26), fill=(65, 105, 225, 255))  # Royal blue

# Save as 32x32.png
img.save("32x32.png")
print("Icon saved as 32x32.png")
