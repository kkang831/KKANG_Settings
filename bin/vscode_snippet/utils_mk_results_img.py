def mk_results_img(
        images: list[np.ndarray],
        descriptions: list[str],
        image_resolution: int = 512,
    ):
    from PIL import Image
    image_width, image_height = image_resolution, image_resolution

    concatenated_np = np.concatenate(images, axis=1)
    concatenated_image = Image.fromarray(concatenated_np)

    text_height = 80  
    new_image = Image.new('RGB', (concatenated_image.width, concatenated_image.height + text_height), (255, 255, 255))
    new_image.paste(concatenated_image, (0, 0))

    from PIL import Image, ImageDraw, ImageFont
    draw = ImageDraw.Draw(new_image)

    font_dir = os.path.join(os.environ['link_dir'], 'fonts')
    font = ImageFont.truetype(f"{font_dir}/ARIAL.TTF", 80)

    for i, description in enumerate(descriptions):
        text_width = draw.textlength(description, font=font)
        text_x = i * image_width + (image_width - text_width) / 2
        text_y = image_height
        draw.text((text_x, text_y), description, fill=(0, 0, 0), font=font)
    return new_image
